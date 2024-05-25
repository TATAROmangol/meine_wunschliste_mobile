import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:meine_wunschliste/services/auth_service.dart';

class LogOutWidget extends StatelessWidget {
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
          onPressed: () {
            AuthService().logOut();
          },
          child: Text("Сменить аккаунт"),
        ));
  }
}
