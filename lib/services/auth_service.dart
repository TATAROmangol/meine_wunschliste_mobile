import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:meine_wunschliste/services/sync_service/sync_service.dart';

class AuthService {
  final firebase_auth.FirebaseAuth _firebaseAuth = firebase_auth.FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<firebase_auth.User?> signInWithGoogle(SyncService syncService) async {
    final GoogleSignInAccount? gUser = await _googleSignIn.signIn();

    if (gUser == null) {
      return null;
    }

    final GoogleSignInAuthentication gAuth = await gUser.authentication;

    final credential = firebase_auth.GoogleAuthProvider.credential(
      accessToken: gAuth.accessToken,
      idToken: gAuth.idToken,
    );

    final firebase_auth.UserCredential userCredential = await _firebaseAuth.signInWithCredential(credential);

    // Очистка и повторная загрузка данных после авторизации
    await syncService.clearRealmData();
    await syncService.loadDataFromFirebaseToRealm();

    return userCredential.user;
  }

  Future<void> logOut(BuildContext context, SyncService syncService) async {
    await syncService.updateDataBetweenFirebaseAndRealm();
    await syncService.clearRealmData(); // Очистка данных перед выходом
    await _firebaseAuth.signOut();
    Phoenix.rebirth(context); // Перезапуск приложения
  }
}
