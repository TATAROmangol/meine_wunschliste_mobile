import 'package:flutter/material.dart';
import 'package:meine_wunschliste/presentation/widgets/widgets.dart';

class UserTasks extends StatelessWidget {
  const UserTasks({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFFEEA434),
          title: const Text('Meine Wunschliste'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {},
          ),
        ),
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/phon.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            children: <Widget>[
              FolderListViev(),
              TaskListViev(),
              const AddTaskViev(),
            ],
          ),
        ),
      ),
    );
  }
}
