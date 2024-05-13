import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:meine_wunschliste/features/user_tasks/view/user_tasks_view.dart';
import 'package:meine_wunschliste/domain/models/models.dart';
import 'package:meine_wunschliste/domain/repository.dart';
import 'package:meine_wunschliste/services/firebase_options.dart';
import 'package:meine_wunschliste/presentation/pages/pages.dart';
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
    Task.schema
  ]);

  final realm = await Realm.open(config);
  GetIt.I.registerSingleton<Repository>(Repository(realm: realm));
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
        ? const UserTasks()
        : const Auth(),
  ));
}
