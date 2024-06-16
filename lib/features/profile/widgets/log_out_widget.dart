import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:meine_wunschliste/domain/repository.dart';
import 'package:meine_wunschliste/services/auth_service.dart';
import 'package:meine_wunschliste/features/auth/view/auth_view.dart';
import 'package:meine_wunschliste/services/sync_service/sync_service.dart';

class LogOutWidget extends StatelessWidget {
  final SyncService syncService = GetIt.I.get<SyncService>();

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return Container(
      height: screenSize.height * 0.05,
      width: screenSize.width * 0.54,
      margin: EdgeInsets.only(
        top: screenSize.height * 0.05,
        bottom: screenSize.height * 0.05,
        left: screenSize.width * 0.05,
        right: screenSize.width * 0.05,
      ),
      child: 
      ElevatedButton(
        onPressed: () async {
          await AuthService().logOut(context, syncService);
        },
        child: const Text("Сменить аккаунт"),
      ),
    );
  }
}
