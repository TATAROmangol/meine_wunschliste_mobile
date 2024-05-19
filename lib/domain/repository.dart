import 'package:meine_wunschliste/domain/models/models.dart';
import 'package:meine_wunschliste/domain/models/steps.dart';
import 'package:realm/realm.dart';

class Repository {
  Repository({required this.realm});

  final Realm realm;
  ActiveFolder activeFolder = ActiveFolder();

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
    if (activeFolder.folder != null) {
      return activeFolder.folder;
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
      activeFolder.folder = newFolder;
    });
  }

  Future<void> renameActiveFolder(String newName) async {
    final newFolder =
        Folder(activeFolder.folder!.uid, activeFolder.folder!.order, newName);

    realm.write(() {
      final currentFolder = realm.find<Folder>(activeFolder.folder!.uid)!;
      realm.delete<Folder>(currentFolder);
    });

    changeActiveFolder(newFolder);
  }

  Future<void> deleteActiveFolder() async {
    final tasks = await getTasks(Steps.rootTask, activeFolder.folder!.uid);

    for (var task in tasks) {
      _deleteRootTask(activeFolder.folder!.uid, Steps.rootTask, task,
          all: true);
    }

    realm.write(() {
      final currentFolder = realm.find<Folder>(activeFolder.folder!.uid)!;
      realm.delete<Folder>(currentFolder);
      realm.all<ActiveFolder>().first.folder = null;
      activeFolder.folder = null;
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
              realm.add<Subtasks>(Subtasks(parentUid, false));
            });
    } else {
      var repositryTasks = realm.find<SubSubtasks>(parentUid);
      repositryTasks != null
          ? tasks = repositryTasks.tasks.map((e) => e).toList()
          : realm.write(() {
              realm.add<SubSubtasks>(SubSubtasks(parentUid, false));
            });
    }
    return tasks;
  }

  bool getStateTasks(Steps step, String parentUid) {
    if (step == Steps.subtask) {
      var repositryTasks = realm.find<Subtasks>(parentUid)!;
      return repositryTasks.allComplete;
    } else {
      var repositryTasks = realm.find<SubSubtasks>(parentUid)!;
      return repositryTasks.allComplete;
    }
  }

  Future<void> addTask(
      Steps step, String parentUid, String name, String comment) async {
    var tasks = [Task(Uuid.v4().toString(), name, comment, false)];
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
                realm.add<Subtasks>(Subtasks(parentUid, tasks: tasks, false));
              })
            : realm.write(() {
                var topTasksRepository = realm.find<SubSubtasks>(parentUid);
                if (topTasksRepository != null) {
                  tasks.addAll(topTasksRepository.tasks);
                  realm.delete<SubSubtasks>(topTasksRepository);
                }
                realm.add<SubSubtasks>(
                    SubSubtasks(parentUid, tasks: tasks, false));
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
                final complete = topTasksRepository!.allComplete;
                realm.delete<Subtasks>(topTasksRepository);
                realm
                    .add<Subtasks>(Subtasks(parentUid, complete, tasks: tasks));
              })
            : realm.write(() {
                var topTasksRepository = realm.find<SubSubtasks>(parentUid);
                final complete = topTasksRepository!.allComplete;
                realm.delete<SubSubtasks>(topTasksRepository);
                realm.add<SubSubtasks>(
                    SubSubtasks(parentUid, complete, tasks: tasks));
              });
  }

  int getIndexElement(Task task, List<Task> tasks) {
    for (var i = 0; i < tasks.length; i++) {
      if (tasks[i].uid == task.uid) return i;
    }
    return 0;
  }

  Future<void> reloadCompleteChildren(String parentUid, Steps step) async {
    final tasks = await getTasks(step, parentUid);
    for (var task in tasks) {
      if (task.isComplete == false) {
        if (step == Steps.subtask) {
          var repositryTasks = realm.find<Subtasks>(parentUid)!;
          realm.write(() {
            realm.delete<Subtasks>(repositryTasks);
            realm.add<Subtasks>(Subtasks(parentUid, false, tasks: tasks));
          });
        } else {
          var repositryTasks = realm.find<SubSubtasks>(parentUid)!;
          realm.write(() {
            realm.delete<SubSubtasks>(repositryTasks);
            realm.add<SubSubtasks>(SubSubtasks(parentUid, false, tasks: tasks));
          });
        }
        return;
      }
    }
    if (step == Steps.subtask) {
      var repositryTasks = realm.find<Subtasks>(parentUid)!;
      realm.write(() {
        realm.delete<Subtasks>(repositryTasks);
        realm.add<Subtasks>(Subtasks(parentUid, true, tasks: tasks));
      });
    } else {
      var repositryTasks = realm.find<SubSubtasks>(parentUid)!;
      realm.write(() {
        realm.delete<SubSubtasks>(repositryTasks);
        realm.add<SubSubtasks>(SubSubtasks(parentUid, true, tasks: tasks));
      });
    }
  }

  Future<void> correctingTask(String parentUid, Steps step, Task task,
      String name, String comment, bool isComplete) async {
    if (step == Steps.rootTask) {
      var repository = realm.find<RootTasks>(parentUid)!;
      var tasks = await getTasks(Steps.rootTask, parentUid);
      final order = getIndexElement(task, tasks);

      realm.write(() {
        realm.delete<RootTasks>(repository);
        tasks[order].name = name;
        tasks[order].comment = comment;
        tasks[order].isComplete = isComplete;
        realm.add<RootTasks>(RootTasks(parentUid, tasks: tasks));
      });
    } else if (step == Steps.subtask) {
      var repository = realm.find<Subtasks>(parentUid)!;
      final complete = repository.allComplete;
      var tasks = await getTasks(Steps.subtask, parentUid);
      final order = getIndexElement(task, tasks);

      realm.write(() {
        realm.delete<Subtasks>(repository);
        tasks[order].name = name;
        tasks[order].comment = comment;
        tasks[order].isComplete = isComplete;
        realm.add<Subtasks>(Subtasks(parentUid, complete, tasks: tasks));
      });
    } else {
      var repository = realm.find<SubSubtasks>(parentUid)!;
      final complete = repository.allComplete;
      var tasks = await getTasks(Steps.subSubtask, parentUid);
      final order = getIndexElement(task, tasks);

      realm.write(() {
        realm.delete<SubSubtasks>(repository);
        tasks[order].name = name;
        tasks[order].comment = comment;
        tasks[order].isComplete = isComplete;
        realm.add<SubSubtasks>(SubSubtasks(parentUid, complete, tasks: tasks));
      });
    }
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
