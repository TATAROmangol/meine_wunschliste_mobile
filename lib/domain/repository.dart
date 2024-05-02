import 'package:meine_wunschliste/domain/models/models.dart';
import 'package:realm/realm.dart';

class Repository {
  Repository({required this.realm});

  final Realm realm;

  //папки
  Future<List<Folder>> getFolders() async {
    var folders = realm.all<Folder>().toList();
    folders.sort((a, b) => b.order.compareTo(a.order));
    return folders;
  }

  Future<void> addFolder(String name) async {
    var countItems = await getCountFolders();
    var newFolder = Folder(Uuid.v4().toString(), countItems, name);
    await changeActiveFolder(newFolder);
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
    var activeFolderRep = realm.all<ActiveFolder>().toList();
    if (activeFolderRep.isEmpty) {
      realm.write(() => realm.add<ActiveFolder>(ActiveFolder()));
      return ActiveFolder().folder;
    }
    return activeFolderRep[0].folder;
  }

  Future<void> changeActiveFolder(Folder newFolder) async {
    realm.write(() {
      realm.all<ActiveFolder>().first.folder = newFolder;
    });
  }

  //задачи
  Future<List<Task>> getRootTasks() async {
    var activeFolder = await getActiveFolder();
    var topTasksRepository = realm.find<RootTasks>(activeFolder!.uid);
    if (topTasksRepository != null) {
      return topTasksRepository.tasks.map((e) => e).toList();
    } else {
      realm.write(() => realm.add<RootTasks>(RootTasks(activeFolder.uid)));
      return [];
    }
  }

  Future<void> addRootTask(String name) async {
    var activeFolder = await getActiveFolder();
    var uid = activeFolder!.uid;

    realm.write(() {
      var topTasksRepository = realm.find<RootTasks>(uid);
      var tasks = [Task(Uuid.v4().toString(), 0, name)];
      if (topTasksRepository != null) {
        tasks.addAll(topTasksRepository.tasks);
        realm.delete<RootTasks>(topTasksRepository);
      }
      realm.add<RootTasks>(RootTasks(uid, tasks: tasks));
    });
  }

  Future<void> changeRootTasksOrder(List<Task> tasks) async {
    var activeFolder = await getActiveFolder();
    var uid = activeFolder!.uid;
    realm.write(() {
      var topTasksRepository = realm.find<RootTasks>(uid);
      realm.delete<RootTasks>(topTasksRepository!);
      realm.add<RootTasks>(RootTasks(uid, tasks: tasks));
    });
  }
}