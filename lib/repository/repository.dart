import 'package:meine_wunschliste/domain/models/models.dart';
import 'package:meine_wunschliste/repository/models/repository_models.dart';
import 'package:realm/realm.dart';

class Repository {
  Repository({required this.realm});

  final Realm realm;

  Future<List<FoldersRepository>> getFolders() async {
    return realm.write(() => realm.all<FoldersRepository>()).toList();
  }

  Future<void> addFolder(String name) async {
    var uid = Uuid.v4().toString();
    var countItems = await getCountFolders();
    await realm.write(() =>
        realm.add<FoldersRepository>(FoldersRepository(uid, countItems, name)));
    changeUidActiveFolder(uid);
  }

  Future<int> getCountFolders() async {
    var items = realm.all<FoldersRepository>().toList();
    return items.length;
  }

  Future<void> updateFolderOrder(Folder folderNavigation, int index) async {
    var item = realm.find<FoldersRepository>(folderNavigation.uid);
    if (item != null) realm.write(() => item.order = index);
  }

  Future<String> getUidActiveFolder() async {
    var item = realm.all<ActiveFolder>();
    if (item.isEmpty) {
      await realm.write(() => realm.add<ActiveFolder>(ActiveFolder('')));
    }
    ;
    var folder = realm.all<ActiveFolder>().first;

    return folder.uid;
  }

  Future<void> changeUidActiveFolder(String uid) async {
    var item = realm.all<ActiveFolder>();
    if (item.isEmpty) {
      await realm.write(() => realm.add<ActiveFolder>(ActiveFolder('')));
    }
    ;
    var folder = realm.all<ActiveFolder>().first;
    realm.write(() => folder.uid = uid);
  }
}
