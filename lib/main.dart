import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:meine_wunschliste/firebase_options.dart';
import 'package:meine_wunschliste/presentation/pages/home.dart';
import 'package:meine_wunschliste/presentation/pages/user_tasks.dart';

void main()  async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  
  runApp(FirebaseAuth.instance.currentUser != null ? const UserTasks() : const Home());
}
