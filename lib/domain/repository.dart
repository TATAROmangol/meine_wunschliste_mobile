import 'package:meine_wunschliste/domain/models/models.dart';
import 'package:meine_wunschliste/domain/models/steps.dart';
import 'package:realm/realm.dart';

class Repository {
  Repository({required this.realm});

  final Realm realm;
  ActiveFolder _activeFolder = ActiveFolder();

  //папки
  Future<List<Folder>> getFolders() async {
    var folders = realm.all<Folder>().toList();
    folders.sort((a, b) => b.order.compareTo(a.order));
    return folders;
  }

  Future<void> addFolder(String name) async {
    var countItems = await getCountFolders();
    var newFolder = Folder(Uuid.v4().toString(), countItems, name);
    changeActiveFolder(newFolder);
    realm.write(() => realm.add<Folder>(newFolder));
  }

  Future<int> getCountFolders() async {
    var items = realm.all<Folder>().toList();
    return items.length;
  }

  Future<void> updateFolderOrder(Folder folder, int index) async {
    var item = realm.find<Folder>(folder.uid);
    if (item != null) realm.write(() => item.order = index);
  }

  Future<Folder?> getActiveFolder() async {
    if (_activeFolder.folder != null) {
      return _activeFolder.folder;
    } else {
      var activeFolderRep = realm.all<ActiveFolder>();
      if (activeFolderRep.isEmpty) {
        realm.write(() => realm.add<ActiveFolder>(ActiveFolder()));
        return ActiveFolder().folder;
      }
      return activeFolderRep.first.folder;
    }
  }

  void changeActiveFolder(Folder newFolder) {
    realm.write(() {
      realm.all<ActiveFolder>().first.folder = newFolder;
      _activeFolder.folder = newFolder;
    });
  }

  //задачи

  Future<List<Task>> getTasks(Steps step, String parentUid) async {
    List<Task> tasks = [];
    if (step == Steps.rootTask) {
      var repositryTasks = realm.find<RootTasks>(parentUid);
      repositryTasks != null
          ? tasks = repositryTasks.tasks.map((e) => e).toList()
          : realm.write(() {
              realm.add<RootTasks>(RootTasks(parentUid));
            });
    } else if (step == Steps.subtask) {
      var repositryTasks = realm.find<Subtasks>(parentUid);
      repositryTasks != null
          ? tasks = repositryTasks.tasks.map((e) => e).toList()
          : realm.write(() {
              realm.add<Subtasks>(Subtasks(parentUid));
            });
    } else {
      var repositryTasks = realm.find<SubSubtasks>(parentUid);
      repositryTasks != null
          ? tasks = repositryTasks.tasks.map((e) => e).toList()
          : realm.write(() {
              realm.add<SubSubtasks>(SubSubtasks(parentUid));
            });
    }
    return tasks;
  }

  Future<void> addTask(Steps step, String parentUid, String name) async {
    var tasks = [Task(Uuid.v4().toString(), name, step.index)];
    step == Steps.rootTask
        ? realm.write(() {
            var topTasksRepository = realm.find<RootTasks>(parentUid);
            if (topTasksRepository != null) {
              tasks.addAll(topTasksRepository.tasks);
              realm.delete<RootTasks>(topTasksRepository);
            }
            realm.add<RootTasks>(RootTasks(parentUid, tasks: tasks));
          })
        : step == Steps.subtask
            ? realm.write(() {
                var topTasksRepository = realm.find<Subtasks>(parentUid);
                if (topTasksRepository != null) {
                  tasks.addAll(topTasksRepository.tasks);
                  realm.delete<Subtasks>(topTasksRepository);
                }
                realm.add<Subtasks>(Subtasks(parentUid, tasks: tasks));
              })
            : realm.write(() {
                var topTasksRepository = realm.find<SubSubtasks>(parentUid);
                if (topTasksRepository != null) {
                  tasks.addAll(topTasksRepository.tasks);
                  realm.delete<SubSubtasks>(topTasksRepository);
                }
                realm.add<SubSubtasks>(SubSubtasks(parentUid, tasks: tasks));
              });
  }

  Future<void> changeTasksOrder(
      List<Task> tasks, Steps step, String parentUid) async {
    step == Steps.rootTask
        ? realm.write(() {
            var topTasksRepository = realm.find<RootTasks>(parentUid);
            realm.delete<RootTasks>(topTasksRepository!);
            realm.add<RootTasks>(RootTasks(parentUid, tasks: tasks));
          })
        : step == Steps.subtask
            ? realm.write(() {
                var topTasksRepository = realm.find<Subtasks>(parentUid);
                realm.delete<Subtasks>(topTasksRepository!);
                realm.add<Subtasks>(Subtasks(parentUid, tasks: tasks));
              })
            : realm.write(() {
                var topTasksRepository = realm.find<SubSubtasks>(parentUid);
                realm.delete<SubSubtasks>(topTasksRepository!);
                realm.add<SubSubtasks>(SubSubtasks(parentUid, tasks: tasks));
              });
  }
}
