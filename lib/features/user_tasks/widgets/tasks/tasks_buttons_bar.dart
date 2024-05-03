import 'package:flutter/material.dart';

class TasksButtonsBar extends StatelessWidget {
  const TasksButtonsBar({super.key});

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        color: Color(0xFFFFFF).withOpacity(0.5),
      ),
      margin: EdgeInsets.only(bottom: screenSize.height * 0.013),
      height: screenSize.height * 0.05,
      width: screenSize.width * 0.5,
      child: Row(children: [
        IconButton(onPressed: () {}, icon: Icon(Icons.add)),
        IconButton(onPressed: () {}, icon: Icon(Icons.delete)),
        IconButton(onPressed: () {}, icon: Icon(Icons.settings)),
        IconButton(onPressed: () {}, icon: Icon(Icons.comment)),
      ]),
    );
  }
}
