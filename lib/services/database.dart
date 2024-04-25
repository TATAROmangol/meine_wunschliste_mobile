import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meine_wunschliste/domain/models/folder_navigation.dart';

class DataBase {
  final CollectionReference _foldersCollection =
      FirebaseFirestore.instance.collection('folders');

  // Future<List<Folder>> getFolders() async {
  //   var snapshot = await _foldersCollection.get();
  //   return snapshot.docs
  //       .map((doc) =>
  //           Folder.fromJson(doc.id, doc.data() as Map<String, dynamic>))
  //       .toList();
  //}
}
