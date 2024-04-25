import 'package:flutter/material.dart';
import 'package:meine_wunschliste/services/auth_service.dart';
import 'package:meine_wunschliste/presentation/widgets/home_viev/home_viev.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFFEEA434),
          title: const Text('main page'),
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
