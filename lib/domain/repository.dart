import 'package:meine_wunschliste/domain/models/models.dart';
import 'package:realm/realm.dart';

class Repository {
  Repository({required this.realm});

  final Realm realm;

  //папки
  Future<List<Folder>> getFolders() async {
    return realm.all<Folder>().toList();
  }

  Future<void> addFolder(String name) async {
    var countItems = await getCountFolders();
    var newFolder = Folder(Uuid.v4().toString(), countItems, name);
    await realm.write(() => realm.add<Folder>(newFolder));
    await changeActiveFolder(newFolder);
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
    try {
      return realm.all<ActiveFolder>().first.folder;
    } catch (e) {
      realm.write(() => realm.add<ActiveFolder>(ActiveFolder()));
      return null;
    }
  }

  Future<void> changeActiveFolder(Folder newFolder) async {
    var newActiveFolder = ActiveFolder();
    newActiveFolder.folder = newFolder;
    realm.write(() {
      realm.delete(realm.all<ActiveFolder>().first);
      realm.add<ActiveFolder>(newActiveFolder);
    });
  }

  //задачи
  Future<List<Task>> getTopTasks() async {
    var activeFolder = await getActiveFolder();
    var topTasksRepository = realm.find<TasksTop>(activeFolder!.uid);
    if (topTasksRepository != null) {
      return topTasksRepository.tasks;
    } else {
      realm.write(() => realm.add<TasksTop>(TasksTop(activeFolder.uid)));
      return [];
    }
  }

  // Future<void> addTopTask(String name) async {
  //   var activeFolder = await getActiveFolder();
  //   if (activeFolder!.uid.isNotEmpty) {
  //     var topTasksRepository = realm.find<TasksTop>(activeFolder.uid);
  //     if (topTasksRepository != null) {
  //       var currentTasks = topTasksRepository.tasks;
  //       var newTask = Task(Uuid.v4().toString(), currentTasks.length, 1, name);
  //       currentTasks.add(newTask);
  //       realm.write(() => topTasksRepository.tasks = currentTasks);
  //     } else {
  //       var newTaskTopRep = TasksTop(activeFolder.uid);
  //       var newTask = Task(Uuid.v4().toString(), 0, 1, name);
  //       newTaskTopRep.tasks.add(newTask);
  //       realm.write(() => realm.add<TasksTop>(newTaskTopRep));
  //     }
  //   }
  // }
}
