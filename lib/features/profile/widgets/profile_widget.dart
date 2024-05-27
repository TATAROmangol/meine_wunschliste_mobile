import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfileWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final User? user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      return Container(
        child: Center(
          child: Text('No user logged in'),
        ),
      );
    }

    final String? photoUrl = user.photoURL;
    final String? displayName = user.displayName;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        color: Color(0xFFE0C3).withOpacity(1),
      ),
      height: screenSize.height * 0.155,
      width: screenSize.width * 0.90,
      margin: EdgeInsets.only(
        top: screenSize.height * 0.05,
        bottom: screenSize.height * 0.05,
        left: screenSize.width * 0.05,
        right: screenSize.width * 0.05,
      ),
      child: Row(
        children: [
          if (photoUrl != null)
            CircleAvatar(
              radius: screenSize.width * 0.1,
              backgroundImage: NetworkImage(photoUrl),
            ),
          SizedBox(width: screenSize.width * 0.05),
          
          if (displayName != null)
            Text(
              displayName,
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
        ],
      ),
    );
  }
}
