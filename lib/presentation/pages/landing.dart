import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:meine_wunschliste/presentation/pages/home.dart';
import 'package:meine_wunschliste/presentation/pages/user_tasks.dart';

class Landing extends StatelessWidget{

  @override
  Widget build(BuildContext context){
    return FirebaseAuth.instance.currentUser != null ? const UserTasks() : const Home();
  }
}