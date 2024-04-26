import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:meine_wunschliste/features/user_tasks/view/user_tasks_view.dart';
import 'package:meine_wunschliste/repository/models/repository_models.dart';
import 'package:meine_wunschliste/repository/repository.dart';
import 'package:meine_wunschliste/services/firebase_options.dart';
import 'package:meine_wunschliste/presentation/pages/pages.dart';
import 'package:realm/realm.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final config = Configuration.local([
    FoldersRepository.schema,
    TasksTopRepository.schema,
    TasksCenterRepository.schema,
    TasksBottomRepository.schema,
    Task.schema
  ]);
  final realm = Realm(config);
  GetIt.I.registerSingleton<Repository>(Repository(realm: realm));

  runApp(MaterialApp(
      home: (FirebaseAuth.instance.currentUser != null)
          ? UserTasks()
          : const Auth()));
}
