import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meine_wunschliste/features/user_tasks/blocs/folders_bloc/folders_bloc.dart';
import 'package:meine_wunschliste/features/user_tasks/blocs/tasks_bloc/tasks_bloc.dart';
import 'package:meine_wunschliste/features/user_tasks/widgets/widgets.dart';

class UserTasks extends StatelessWidget {
  UserTasks({super.key});

  @override
  Widget build(BuildContext context) {
    final foldersBloc = FoldersBloc();
    final tasksBloc = TasksBloc();
    return MultiBlocProvider(
      providers: [
        BlocProvider<FoldersBloc>(create: (context) => foldersBloc),
        BlocProvider<TasksBloc>(create: (context) => tasksBloc)
      ],
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFFFF9648),
          title: const Text('Meine Wunschliste'),
          leading: GestureDetector(
            child: const Icon(Icons.arrow_back),
            onTap: () {},
          ),
          actions: const [AddFolderWidget()],
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
              const FolderBar(),
              TaskTreeView(),
              const AddRootTask(),
            ],
          ),
        ),
      ),
    );
  }
}
