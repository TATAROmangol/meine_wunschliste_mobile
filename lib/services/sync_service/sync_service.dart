import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';
import 'package:meine_wunschliste/domain/repository.dart';
import 'package:meine_wunschliste/domain/repository_models/realm_models.dart';
import 'package:meine_wunschliste/services/sync_service/convert_methods.dart';
import 'package:realm/realm.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

class SyncService {
  SyncService({required this.realm});

  final Realm realm;
  final Repository repository = GetIt.I.get<Repository>();

  Future<void> loadDataFromFirebaseToRealm() async {
    final firebase_auth.User? user =
        firebase_auth.FirebaseAuth.instance.currentUser;
    if (user == null) return;

    final String userId = user.uid;
    final DocumentReference userDoc =
        FirebaseFirestore.instance.collection('users').doc(userId);

    final CollectionReference _subSubtasksCollection =
        userDoc.collection('SubSubtasks');
    var snapshotSubSubtasks = await _subSubtasksCollection.get();
    var subSubtasks = snapshotSubSubtasks.docs
        .map((doc) => convertFirestoreSubSubtasksToRealm(
            doc.data() as Map<String, dynamic>))
        .toList();

    final CollectionReference _subtasksCollection =
        userDoc.collection('Subtasks');
    var snapshotSubtasks = await _subtasksCollection.get();
    var subtasks = snapshotSubtasks.docs
        .map((doc) =>
            convertFirestoreSubtasksToRealm(doc.data() as Map<String, dynamic>))
        .toList();

    final CollectionReference _rootTasksCollection =
        userDoc.collection('RootTasks');
    var snapshotRootTasks = await _rootTasksCollection.get();
    var rootTasks = snapshotRootTasks.docs
        .map((doc) => convertFirestoreRootTasksToRealm(
            doc.data() as Map<String, dynamic>))
        .toList();

    final CollectionReference _foldersCollection = userDoc.collection('Folder');
    var snapshotFolders = await _foldersCollection.get();
    var folders = snapshotFolders.docs
        .map((doc) =>
            convertFirestoreFolderToRealm(doc.data() as Map<String, dynamic>))
        .toList();

    final CollectionReference _completeTasksCollection =
        userDoc.collection('CompleteTasks');
    var snapshotCompleteTasks = await _completeTasksCollection.get();
    var completeTasks = snapshotCompleteTasks.docs
        .map((doc) => convertFirestoreCompleteTasksToRealm(
            doc.data() as Map<String, dynamic>))
        .toList();

    realm.write(() {
      for (var subSubtask in subSubtasks) {
        realm.add<SubSubtasks>(subSubtask);
      }
      for (var subtask in subtasks) {
        realm.add<Subtasks>(subtask);
      }
      for (var rootTask in rootTasks) {
        realm.add<RootTasks>(rootTask);
      }
      for (var folder in folders) {
        realm.add<Folder>(folder);
      }
      for (var completeTask in completeTasks) {
        realm.add<CompleteTasks>(completeTask);
      }
    });
  }

  Future<void> updateDataBetweenFirebaseAndRealm() async {
    final firebase_auth.User? user =
        firebase_auth.FirebaseAuth.instance.currentUser;
    if (user == null) return;

    final String userId = user.uid;
    final DocumentReference userDoc =
        FirebaseFirestore.instance.collection('users').doc(userId);

    // Получаем данные из Realm
    var realmSubSubtasks = realm.all<SubSubtasks>().toList();
    var realmSubtasks = realm.all<Subtasks>().toList();
    var realmRootTasks = realm.all<RootTasks>().toList();
    var realmFolders = realm.all<Folder>().toList();
    var realmCompleteTasks = realm.all<CompleteTasks>().toList();

    // Удаляем старые документы из коллекций
    await _clearFirestoreCollection(userDoc.collection('SubSubtasks'));
    await _clearFirestoreCollection(userDoc.collection('Subtasks'));
    await _clearFirestoreCollection(userDoc.collection('RootTasks'));
    await _clearFirestoreCollection(userDoc.collection('Folder'));
    await _clearFirestoreCollection(userDoc.collection('CompleteTasks'));

    // Обновляем под-подзадачи
    for (var subSubtask in realmSubSubtasks) {
      await userDoc
          .collection('SubSubtasks')
          .doc(subSubtask.uid)
          .set(convertRealmSubSubtasksToFirestore(subSubtask));
    }

    // Обновляем подзадачи
    for (var subtask in realmSubtasks) {
      await userDoc
          .collection('Subtasks')
          .doc(subtask.uid)
          .set(convertRealmSubtasksToFirestore(subtask));
    }

    // Обновляем корневые задачи
    for (var rootTask in realmRootTasks) {
      await userDoc
          .collection('RootTasks')
          .doc(rootTask.uid)
          .set(convertRealmRootTasksToFirestore(rootTask));
    }

    // Обновляем папки
    for (var folder in realmFolders) {
      await userDoc
          .collection('Folder')
          .doc(folder.uid)
          .set(convertRealmFolderToFirestore(folder));
    }

    // Обновляем завершенные задачи
    if (realmCompleteTasks.isNotEmpty) {
      var completeTasks = realmCompleteTasks.first;
      await userDoc
          .collection('CompleteTasks')
          .doc('completeTasks')
          .set(convertRealmCompleteTasksToFirestore(completeTasks));
    }
  }

  Future<void> _clearFirestoreCollection(CollectionReference collection) async {
    var snapshots = await collection.get();
    for (var doc in snapshots.docs) {
      await doc.reference.delete();
    }
  }

  Future<void> clearRealmData() async {
    repository.goClearRepository();
  }
}
