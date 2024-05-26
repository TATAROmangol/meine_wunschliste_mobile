import 'dart:io';
import 'package:meine_wunschliste/features/auth/view/auth_view.dart';
import 'package:meine_wunschliste/features/features.dart';
import 'package:meine_wunschliste/features/main_screen.dart';
import 'package:meine_wunschliste/services/sync_service/sync_service.dart';
import 'package:path_provider/path_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:meine_wunschliste/features/tasks_and_folders/user_tasks_folders/view/user_tasks_folders_view.dart';
import 'package:meine_wunschliste/domain/repository_models/realm_models.dart';
import 'package:meine_wunschliste/domain/repository.dart';
import 'package:meine_wunschliste/services/firebase_options.dart';
import 'package:realm/realm.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final config = Configuration.local([
    Folder.schema,
    ActiveFolder.schema,
    RootTasks.schema,
    Subtasks.schema,
    SubSubtasks.schema,
    CompleteTasks.schema,
    Task.schema
  ]);

  final realm = await Realm.open(config);
  GetIt.I.registerSingleton<Repository>(Repository(realm: realm));
  GetIt.I.registerSingleton<SyncService>(SyncService(realm: realm));
  // final Directory directory = await getApplicationDocumentsDirectory();
  // final String path = directory.path + '/default.realm';

  // try {
  //   final realm = await Realm.open(config);
  //   realm.deleteAll();
  //   realm.close();
  //   GetIt.I.registerSingleton<Repository>(Repository(realm: realm));
  // } catch (e) {
  //   // Если произошла ошибка миграции, удаляем файл базы данных
  //   File(path).deleteSync();
  //   print('Deleted realm file due to migration error');
  // }

  runApp(MaterialApp(
    home: (FirebaseAuth.instance.currentUser != null)
        ? SyncView()
        : AuthView(),
  ));
}
