import 'package:flutter/material.dart';
import 'package:meine_wunschliste/data/services/auth_service.dart';

class Auth extends StatelessWidget {
  const Auth({super.key});

  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFFEEA434),
          title: const Text('Auth'),
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
                child: Text('google'),
                onTap: () => AuthService().signInWithGoogle(),
              )),
        ),
      ),
    );
  }
}