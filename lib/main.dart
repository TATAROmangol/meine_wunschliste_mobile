
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:get_it/get_it.dart';
import 'package:meine_wunschliste/domain/repository.dart';
import 'package:meine_wunschliste/domain/user_theme.dart';
import 'package:meine_wunschliste/features/auth/view/auth_view.dart';
import 'package:meine_wunschliste/features/main_screen.dart';
import 'package:meine_wunschliste/services/firebase_options.dart';
import 'package:meine_wunschliste/services/notification_service.dart';
import 'package:meine_wunschliste/services/sync_service/sync_service.dart';
import 'package:realm/realm.dart' as realm_dart;
import 'package:timezone/data/latest.dart' as tz;

import 'domain/repository_models/realm_models.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await NotificationService.initialize();

  final config = realm_dart.Configuration.local([
    Folder.schema,
    ActiveFolder.schema,
    RootTasks.schema,
    Subtasks.schema,
    SubSubtasks.schema,
    CompleteTasks.schema,
    CustomUserTheme.schema,
    Task.schema,
  ]);

  final realm = realm_dart.Realm(config);
  final Repository repository = Repository(realm: realm);
  final UserTheme theme = repository.createTheme();

  if (!GetIt.I.isRegistered<Repository>()) {
    GetIt.I.registerSingleton<Repository>(repository);
  }

  if (!GetIt.I.isRegistered<SyncService>()) {
    GetIt.I.registerSingleton<SyncService>(SyncService(realm: realm));
  }

  if (GetIt.I.isRegistered<UserTheme>()) {
    GetIt.I.unregister<UserTheme>();
  }
  GetIt.I.registerSingleton<UserTheme>(theme);

  runApp(
    Phoenix(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Future<void> _initializeAppFuture;

  @override
  void initState() {
    super.initState();
    _initializeAppFuture = initializeApp();
  }

  Future<void> initializeApp() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    final config = realm_dart.Configuration.local([
      Folder.schema,
      ActiveFolder.schema,
      RootTasks.schema,
      Subtasks.schema,
      SubSubtasks.schema,
      CompleteTasks.schema,
      CustomUserTheme.schema,
      Task.schema,
    ]);

    final realm = realm_dart.Realm(config);
    final Repository repository = Repository(realm: realm);
    final UserTheme theme = repository.createTheme();


    if (!GetIt.I.isRegistered<Repository>()) {
      GetIt.I.registerSingleton<Repository>(repository);
    }

    if (!GetIt.I.isRegistered<SyncService>()) {
      GetIt.I.registerSingleton<SyncService>(SyncService(realm: realm));
    }

    if (GetIt.I.isRegistered<UserTheme>()) {
      GetIt.I.unregister<UserTheme>();
    }
    GetIt.I.registerSingleton<UserTheme>(theme);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initializeAppFuture,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return MaterialApp(
            home: Scaffold(
              body: Center(
                child: Text('Error initializing app: ${snapshot.error}'),
              ),
            ),
          );
        }

        if (snapshot.connectionState == ConnectionState.done) {
          return MaterialApp(
            home: (FirebaseAuth.instance.currentUser != null)
                ? MainScreen()
                : AuthView(),
          );
        }

        return MaterialApp(
          home: Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          ),
        );
      },
    );
  }
}




// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
//   );

//   final config = Configuration.local([
//     Folder.schema,
//     ActiveFolder.schema,
//     RootTasks.schema,
//     Subtasks.schema,
//     SubSubtasks.schema,
//     CompleteTasks.schema,
//     Task.schema
//   ]);

//   final realm = await Realm.open(config);
//   GetIt.I.registerSingleton<Repository>(Repository(realm: realm));
//   GetIt.I.registerSingleton<SyncService>(SyncService(realm: realm));
//   // final Directory directory = await getApplicationDocumentsDirectory();
//   // final String path = directory.path + '/default.realm';

//   // try {
//   //   final realm = await Realm.open(config);
//   //   realm.deleteAll();
//   //   realm.close();
//   //   GetIt.I.registerSingleton<Repository>(Repository(realm: realm));
//   // } catch (e) {
//   //   // Если произошла ошибка миграции, удаляем файл базы данных
//   //   File(path).deleteSync();
//   //   print('Deleted realm file due to migration error');
//   // }

//   runApp(MaterialApp(
//     home: (FirebaseAuth.instance.currentUser != null)
//         ? SyncView()
//         : AuthView(),
//   ));
// }
