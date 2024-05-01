import 'package:meine_wunschliste/domain/models/models.dart';
import 'package:realm/realm.dart';

class Repository {
  Repository({required this.realm});

  final Realm realm;

  Folder? activeFolder = ActiveFolder().folder;

  //папки
  Future<List<Folder>> getFolders() async {
    var folders = realm.all<Folder>().toList();
    folders.sort((a, b) => b.order.compareTo(a.order));
    return folders;
  }

  Future<void> addFolder(String name) async {
    var countItems = await getCountFolders();
    var uid = Uuid.v4().toString();
    var newFolder = Folder(uid, countItems, name);
    _createRootTasks(uid);
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

  Future<void> changeActiveFolder(Folder newFolder) async {
    realm.write(() {
      realm.all<ActiveFolder>().first.folder = newFolder;
    });
  }

  //задачи
  Future<void> _createRootTasks(String uid) async {
    realm.write(() => realm.add<RootTasks>(RootTasks(uid)));
  }

  Future<List<Task>> getTopTasks() async {
    var rootTasks = realm.find<RootTasks>(activeFolder!.uid);
    return rootTasks!.tasks.map((e) => e).toList();
  }

  Future<void> addTopTask(String name) async {
    var uid = activeFolder!.uid;

    realm.write(() {
      var topTasksRepository = realm.find<RootTasks>(uid);
      var tasks = [Task(Uuid.v4().toString(), 0, name)];

      tasks.addAll(topTasksRepository!.tasks);
      realm.delete<RootTasks>(topTasksRepository);
    });
  }

  Future<void> changeTopTasksOrder(List<Task> tasks) async {
    var uid = activeFolder!.uid;
    realm.write(() {
      var topTasksRepository = realm.find<RootTasks>(uid);
      realm.delete<RootTasks>(topTasksRepository!);
      realm.add<RootTasks>(RootTasks(uid, tasks: tasks));
    });
  }
}
