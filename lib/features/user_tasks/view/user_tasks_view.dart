import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meine_wunschliste/features/user_tasks/blocs/folders_bloc/folders_bloc.dart';
import 'package:meine_wunschliste/features/user_tasks/blocs/root_tasks_bloc/root_tasks_bloc.dart';
import 'package:meine_wunschliste/features/user_tasks/widgets/widgets.dart';

import '../blocs/sub_subtasks_bloc/sub_subtasks_bloc.dart';
import '../blocs/subtasks_bloc/subtasks_bloc.dart';

class UserTasks extends StatelessWidget {
  UserTasks({super.key});

  @override
  Widget build(BuildContext context) {
    final foldersBloc = FoldersBloc();
    final tasksBloc = RootTasksBloc();
    final subtasksBloc = SubtasksBloc();
    final subSubtasksBloc = SubSubtasksBloc();
    return MultiBlocProvider(
      providers: [
        BlocProvider<FoldersBloc>(create: (context) => foldersBloc),
        BlocProvider<RootTasksBloc>(create: (context) => tasksBloc),
        BlocProvider<SubtasksBloc>(create: (context) => subtasksBloc),
        BlocProvider<SubSubtasksBloc>(create: (context) => subSubtasksBloc)
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
