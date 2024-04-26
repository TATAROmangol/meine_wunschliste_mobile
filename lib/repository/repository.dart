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
    var countItems = await getCountFolders();
    realm.write(() => realm.add<FoldersRepository>(
        FoldersRepository(Uuid.v4().toString(), countItems, name)));
  }

  Future<int> getCountFolders() async {
    var items = realm.all<FoldersRepository>().toList();
    return items.length;
  }

  Future<void> updateFolderOrder(Folder folderNavigation, int index) async {
    var item = realm.find<FoldersRepository>(folderNavigation.uid);
    if (item != null) realm.write(() => item.order = index);
  }
}
