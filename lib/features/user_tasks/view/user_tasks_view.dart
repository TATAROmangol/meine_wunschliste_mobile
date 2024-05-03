import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meine_wunschliste/features/user_tasks/blocs/folders_bloc/folders_bloc.dart';
import 'package:meine_wunschliste/features/user_tasks/blocs/root_task_bloc/root_task_bloc.dart';
import 'package:meine_wunschliste/features/user_tasks/blocs/tasks_trees_bloc/tasks_trees_bloc.dart';
import 'package:meine_wunschliste/features/user_tasks/widgets/widgets.dart';

import '../blocs/sub_subtask_bloc/sub_subtask_bloc.dart';
import '../blocs/subtask_bloc/subtask_bloc.dart';

class UserTasks extends StatelessWidget {
  UserTasks({super.key});

  @override
  Widget build(BuildContext context) {
    final foldersBloc = FoldersBloc();
    final tasksBloc = RootTaskBloc();
    final subtasksBloc = SubtaskBloc();
    final subSubtasksBloc = SubSubtaskBloc();
    final tasksTreeBloc = TasksTreesBloc();
    return MultiBlocProvider(
      providers: [
        BlocProvider<FoldersBloc>(create: (context) => foldersBloc),
        BlocProvider<RootTaskBloc>(create: (context) => tasksBloc),
        BlocProvider<SubtaskBloc>(create: (context) => subtasksBloc),
        BlocProvider<SubSubtaskBloc>(create: (context) => subSubtasksBloc),
        BlocProvider<TasksTreesBloc>(create: (context) => tasksTreeBloc)
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
