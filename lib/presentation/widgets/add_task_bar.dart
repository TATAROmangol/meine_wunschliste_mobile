import 'package:flutter/material.dart';

class AddTaskBar extends StatelessWidget {
  const AddTaskBar({super.key});

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return Container(
      height: screenSize.height * 0.08,
      padding: const EdgeInsets.only(right: 30.0),
      alignment: Alignment.topRight,
      child: FloatingActionButton(
        onPressed: () {},
        mini: true,
        shape: const CircleBorder(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
