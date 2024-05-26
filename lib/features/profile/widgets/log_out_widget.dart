import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:meine_wunschliste/domain/repository.dart';
import 'package:meine_wunschliste/services/auth_service.dart';
import 'package:meine_wunschliste/features/auth/view/auth_view.dart';

class LogOutWidget extends StatelessWidget {
  final Repository repository = GetIt.I.get<Repository>();

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        color: Color(0xFFE0C3).withOpacity(1),
      ),
      height: screenSize.height * 0.05,
      width: screenSize.width * 0.54,
      margin: EdgeInsets.only(
        top: screenSize.height * 0.05,
        bottom: screenSize.height * 0.05,
        left: screenSize.width * 0.05,
        right: screenSize.width * 0.05,
      ),
      child: TextButton(
        onPressed: () async {
          await repository.goClearRepository();
          await AuthService().logOut();
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => AuthView()),
          );
        },
        child: const Text("Сменить аккаунт"),
      ),
    );
  }
}
