import 'package:flutter/material.dart';

class ProfileWidget extends StatelessWidget{
  
  @override
  Widget build(BuildContext context){
    final Size screenSize = MediaQuery.of(context).size;
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
                
              ],)
    );
  }
}