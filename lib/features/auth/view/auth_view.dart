import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:meine_wunschliste/features/sync_view.dart';
import 'package:meine_wunschliste/services/auth_service.dart';
import 'package:meine_wunschliste/services/sync_service/sync_service.dart';

class AuthView extends StatelessWidget {
  AuthView({super.key});

  final SyncService syncService = GetIt.I.get<SyncService>();

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
            child: Center(
              child: ElevatedButton(
                onPressed: () async {
                  final user = await AuthService().signInWithGoogle();
                  if (user != null) {
                    await syncService.loadDataFromFirebaseToRealm();
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SyncView()),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Failed to sign in with Google')),
                    );
                  }
                },
                child: Text('Google Sign-In'),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
