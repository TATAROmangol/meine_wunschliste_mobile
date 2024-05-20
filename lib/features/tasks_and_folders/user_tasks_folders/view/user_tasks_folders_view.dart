import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meine_wunschliste/features/custom_bottom_navigation_bar.dart';
import 'package:meine_wunschliste/features/tasks_and_folders/blocs/folders_bloc/folders_bloc.dart';
import 'package:meine_wunschliste/features/tasks_and_folders/blocs/tasks_trees_bloc/tasks_trees_bloc.dart';
import 'package:meine_wunschliste/features/tasks_and_folders/user_tasks_folders/widgets/widgets.dart';

class UserTasksFolders extends StatelessWidget {
  const UserTasksFolders({super.key});

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final foldersBloc = FoldersBloc();
    final tasksTreesBloc = TasksTreesBloc();

    return MultiBlocProvider(
      providers: [
        BlocProvider<FoldersBloc>(create: (context) => foldersBloc),
        BlocProvider<TasksTreesBloc>(create: (context) => tasksTreesBloc)
      ],
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Мои мечты'),
          backgroundColor: const Color(0xFFFF9648),
          toolbarHeight: MediaQuery.of(context).size.height * 0.05,
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
              TaskTreeView(),
              //AddTasksTree(),
              CustomBottomNavigationBar(),
            ],
          ),
        ),
      ),
    );
  }
}
