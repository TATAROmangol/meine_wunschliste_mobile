import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:meine_wunschliste/data/services/auth_service.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFFEEA434),
          title: const Text('settings'),
        ),
        body: Expanded(
          child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/background.jpeg'),
                  fit: BoxFit.cover,
                ),
              ),
              child: //const NavigationListViev(),
                  GestureDetector(
                child: Text('out'),
                onTap: () => AuthService().logOutFromGoogle(),
              )),
        ),
      ),
    );
  }
}
