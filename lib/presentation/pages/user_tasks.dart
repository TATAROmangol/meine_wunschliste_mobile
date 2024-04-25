import 'package:flutter/material.dart';
import 'package:meine_wunschliste/repository/repository.dart';
import 'package:meine_wunschliste/presentation/widgets/user_tasks_view/user_tasks_view.dart';

class UserTasks extends StatelessWidget {
  const UserTasks({required this.realmRepository, super.key});

  final Repository realmRepository;

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
                  return AddFolderView(repository: realmRepository);
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
        child: Column(
          children: <Widget>[
            FolderListView(realmRepository: realmRepository),
            //TaskListView(),
            const AddTaskView(),
          ],
        ),
      ),
    );
  }
}
