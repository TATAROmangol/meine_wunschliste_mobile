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
    UserNotification.schema,
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
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
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
      UserNotification.schema,
      Task.schema,
    ]);

    final realm = realm_dart.Realm(config);
    final Repository repository = Repository(realm: realm);
    final UserTheme userTheme = repository.createTheme();

    if (!GetIt.I.isRegistered<Repository>()) {
      GetIt.I.registerSingleton<Repository>(repository);
    }

    if (!GetIt.I.isRegistered<SyncService>()) {
      GetIt.I.registerSingleton<SyncService>(SyncService(realm: realm));
    }

    if (GetIt.I.isRegistered<UserTheme>()) {
      GetIt.I.unregister<UserTheme>();
    }
    GetIt.I.registerSingleton<UserTheme>(userTheme);
  }

  Color transformColor(Color color) {
    int red = color.red;
    int green = color.green + 28;
    int blue = color.blue + 34;

    green = green.clamp(0, 255);
    blue = blue.clamp(0, 255);

    return Color.fromARGB(color.alpha, red, green, blue);
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
          final UserTheme userTheme = GetIt.I.get<UserTheme>();
          return MaterialApp(
            theme: ThemeData(
              primarySwatch: Colors.blue,
              primaryColor: userTheme.textColor,
              textTheme: TextTheme(
                displayLarge: TextStyle(
                  fontFamily: 'Kinoble',
                  fontWeight: FontWeight.bold,
                  color: userTheme.textColor,
                ),
                displayMedium: TextStyle(
                  fontFamily: 'Kinoble',
                  fontWeight: FontWeight.bold,
                  color: userTheme.textColor,
                ),
                displaySmall: TextStyle(
                  fontFamily: 'Kinoble',
                  fontWeight: FontWeight.bold,
                  color: userTheme.textColor,
                ),
                headlineLarge: TextStyle(
                  fontFamily: 'Kinoble',
                  fontWeight: FontWeight.bold,
                  color: userTheme.textColor,
                ),
                headlineMedium: TextStyle(
                  fontFamily: 'Kinoble',
                  fontWeight: FontWeight.bold,
                  color: userTheme.textColor,
                ),
                headlineSmall: TextStyle(
                  fontFamily: 'Kinoble',
                  fontWeight: FontWeight.bold,
                  color: userTheme.textColor,
                ),
                titleLarge: TextStyle(
                  fontFamily: 'Kinoble',
                  fontWeight: FontWeight.bold,
                  color: userTheme.textColor,
                ),
                titleMedium: TextStyle(
                  fontFamily: 'Kinoble',
                  color: userTheme.textColor,
                ),
                titleSmall: TextStyle(
                  fontFamily: 'Kinoble',
                  color: userTheme.textColor,
                ),
                bodyLarge: TextStyle(
                  fontFamily: 'Kinoble',
                  color: userTheme.textColor,
                ),
                bodyMedium: TextStyle(
                  fontFamily: 'Kinoble',
                  color: userTheme.textColor,
                ),
                labelLarge: TextStyle(
                  fontFamily: 'Kinoble',
                  color: userTheme.textColor,
                ),
                bodySmall: TextStyle(
                  fontFamily: 'Kinoble',
                  color: userTheme.textColor,
                ),
                labelSmall: TextStyle(
                  fontFamily: 'Kinoble',
                  color: userTheme.textColor,
                ),
              ),
              buttonTheme: ButtonThemeData(
                buttonColor: userTheme.textColor, // Цвет фона кнопок
                textTheme: ButtonTextTheme.primary,
              ),
              elevatedButtonTheme: ElevatedButtonThemeData(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                    transformColor(userTheme.accentColor),
                  ),
                  foregroundColor: MaterialStateProperty.all<Color>(
                    userTheme.textColor,
                  ),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                  side: MaterialStateProperty.all<BorderSide>(
                    BorderSide(color: userTheme.borderColor, width: 1.0),
                  ),
                ),
              ),
              textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
                  foregroundColor: userTheme.textColor, // Цвет текста TextButton
                ),
              ),
              outlinedButtonTheme: OutlinedButtonThemeData(
                style: OutlinedButton.styleFrom(
                  foregroundColor: userTheme.textColor, // Цвет текста OutlinedButton
                  side: BorderSide(color: userTheme.textColor), // Цвет обводки OutlinedButton
                ),
              ),
              iconTheme: IconThemeData(color: userTheme.textColor), // Цвет иконок
            ),

            home: (FirebaseAuth.instance.currentUser != null)
                ? const MainScreen()
                : AuthView(),
          );
        }

        return const  MaterialApp(
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




// import 'dart:io';
// import 'package:realm/realm.dart';
// import 'package:path_provider/path_provider.dart';
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

//   final Directory directory = await getApplicationDocumentsDirectory();
//   final String path = directory.path + '/default.realm';

//   try {
//     final realm = await Realm.open(config);
//     realm.deleteAll();
//     realm.close();
//     GetIt.I.registerSingleton<Repository>(Repository(realm: realm));
//   } catch (e) {
//     // Если произошла ошибка миграции, удаляем файл базы данных
//     File(path).deleteSync();
//     print('Deleted realm file due to migration error');
//   }

//   runApp(MaterialApp(
//     home:AuthView(),
//   ));
// }
