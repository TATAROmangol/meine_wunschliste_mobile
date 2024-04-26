import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:meine_wunschliste/features/user_tasks/blocs/add_navigation_folder_bloc/folders_bloc.dart';
import 'package:meine_wunschliste/features/user_tasks/widgets/widgets.dart';
import 'package:meine_wunschliste/repository/repository.dart';

class UserTasks extends StatelessWidget {
  UserTasks({super.key});

  @override
  Widget build(BuildContext context) {
    final foldersBloc = FoldersBloc();
    final tasksBloc = FoldersBloc();
    return MultiBlocProvider(
      providers: [BlocProvider<FoldersBloc>(create: (context) => foldersBloc)],
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFFFF9648),
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
                    return AddFolderWidget(
                      foldersBloc: foldersBloc,
                    );
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
              FolderBar(),
              //TaskListView(),
              //const AddTaskView(),
            ],
          ),
        ),
      ),
    );
  }
}
