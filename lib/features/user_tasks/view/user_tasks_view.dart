import 'package:flutter/material.dart';
import 'package:meine_wunschliste/features/user_tasks/widgets/widgets.dart';

class UserTasks extends StatelessWidget {
  UserTasks({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFEEA434),
        title: const Text('Meine Wunschliste'),
        leading: GestureDetector(
          child: const Icon(Icons.arrow_back),
          onTap: () {},
        ),
        actions: [
          GestureDetector(
            child: const Icon(Icons.folder_copy_outlined),
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return const AddFolderWidget();
                },
              );
            },
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/background.jpeg'),
            fit: BoxFit.cover,
          ),
        ),
        child: const Column(
          children: <Widget>[
            FolderBar(),
            //TaskListView(),
            //const AddTaskView(),
          ],
        ),
      ),
    );
  }
}
