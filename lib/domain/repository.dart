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

  Future<void> renameFolder(String uid, String newName) async {
    realm.write(() {
      final currentFolder = realm.find<Folder>(uid);
      final newFolder =
          Folder(uid.toString(), currentFolder!.order.toInt(), newName);
      realm.write(() {
        realm.delete<Folder>(currentFolder);
        realm.add<Folder>(newFolder);
      });
    });
  }

  Future<void> deleteFolder(String uid) async {
    realm.write(() {
      final currentFolder = realm.find<Folder>(uid);
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
    var tasks = [Task(Uuid.v4().toString(), name)];
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

  Future<void> renameTask(
      String parentUid, Steps step, int order, String newName) async {
    step == Steps.rootTask
        ? realm.write(() {
            var tasks = realm.find<RootTasks>(parentUid)!.tasks;
            final currentTask = tasks[order];
            final newTask = Task(currentTask.uid, newName);
            tasks[order] = newTask;
            changeTasksOrder(tasks, step, parentUid);
          })
        : step == Steps.subtask
            ? realm.write(() {
                var tasks = realm.find<Subtasks>(parentUid)!.tasks;
                final currentTask = tasks[order];
                final newTask = Task(currentTask.uid, newName);
                tasks[order] = newTask;
                changeTasksOrder(tasks, step, parentUid);
              })
            : realm.write(() {
                var tasks = realm.find<SubSubtasks>(parentUid)!.tasks;
                final currentTask = tasks[order];
                final newTask = Task(currentTask.uid, newName);
                tasks[order] = newTask;
                changeTasksOrder(tasks, step, parentUid);
              });
  }

  Future<void> deleteTask(String parentUid, Steps step, Task task,
      {bool all = false}) async {
    return step == Steps.rootTask
        ? _deleteRootTask(parentUid, step, task, all: all)
        : step == Steps.subtask
            ? _deleteSubtaskTask(parentUid, step, task, all: all)
            : _deleteSubSubtaskTask(parentUid, step, task);
  }

  Future<void> _deleteRootTask(String parentUid, Steps step, Task deleteTask,
      {bool all = false}) async {
    var rootTasksRepository = realm.find<RootTasks>(parentUid);
    if (rootTasksRepository != null) {
      var tasks = rootTasksRepository.tasks.map((e) => e).toList();
      tasks.remove(deleteTask);

      var subtasksRepository = realm.find<Subtasks>(deleteTask.uid);
      if (subtasksRepository != null) {
        for (var task in tasks) {
          _deleteSubtaskTask(deleteTask.uid, Steps.subtask, task, all: true);
        }
      }

      if (all) {
        realm.write(() {
          realm.delete<RootTasks>(rootTasksRepository);
        });
      } else {
        changeTasksOrder(tasks, step, parentUid);
      }
    }
  }

  Future<void> _deleteSubtaskTask(String parentUid, Steps step, Task deleteTask,
      {bool all = false}) async {
    var subtasksRepository = realm.find<Subtasks>(parentUid);
    if (subtasksRepository != null) {
      realm.write(() {
        var tasks = subtasksRepository.tasks;
        tasks.remove(deleteTask);

        final subSubtasksRepository = realm.find<SubSubtasks>(deleteTask.uid);
        if (subSubtasksRepository != null) {
          realm.delete<SubSubtasks>(subSubtasksRepository);
        }

        if (all) {
          realm.delete<Subtasks>(subtasksRepository);
        }
      });
    }
    return;
  }

  Future<void> _deleteSubSubtaskTask(
      String parentUid, Steps step, Task deleteTask) async {
    realm.write(() {
      var tasks = realm.find<SubSubtasks>(parentUid)!.tasks;
      tasks.remove(deleteTask);
    });
  }
}
