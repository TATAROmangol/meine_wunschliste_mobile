import 'package:meine_wunschliste/domain/models/models.dart';
import 'package:meine_wunschliste/repository/models/repository_models.dart';
import 'package:realm/realm.dart';

class Repository {
  Repository({required this.realm});

  final Realm realm;

  Future<List<FolderNavigationRepository>> getFoldersNavigatin() async {
    return realm.write(() => realm.all<FolderNavigationRepository>()).toList();
  }

  Future<void> addFolderNavigation(String name) async {
    var countItems = await getCountFoldersNavigation();
    realm.write(() => realm.add<FolderNavigationRepository>(
        FolderNavigationRepository(Uuid.v4().toString(), countItems, name)));
  }

  Future<int> getCountFoldersNavigation() async {
    var items = realm.all<FolderNavigationRepository>().toList();
    return items.length;
  }

  Future<void> updateFolderNavigationOrder(
      FolderNavigation folderNavigation, int index) async {
    var item = realm.find<FolderNavigationRepository>(folderNavigation.uid);
    if (item != null) realm.write(() => item.order = index);
  }
}
