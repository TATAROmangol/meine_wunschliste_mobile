import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meine_wunschliste/features/tasks_and_folders/blocs/folders_bloc/folders_bloc.dart';
import 'package:meine_wunschliste/features/tasks_and_folders/blocs/tasks_trees_bloc/tasks_trees_bloc.dart';
import 'package:meine_wunschliste/features/tasks_and_folders/user_tasks_folders/widgets/widgets.dart';

class UserTasksFolders extends StatelessWidget {
  const UserTasksFolders({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<FoldersBloc>(
            create: (context) => BlocProvider.of<FoldersBloc>(context)),
        BlocProvider<TasksTreesBloc>(
            create: (context) => BlocProvider.of<TasksTreesBloc>(context))
      ],
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Мои мечты'),
          backgroundColor: const Color(0xFFFF9648),
          toolbarHeight: MediaQuery.of(context).size.height * 0.05,
          actions: const [
            AddFolderButton(),
            AddTasksTree(),
          ],
        ),
        body: const Column(
          children: <Widget>[
            FolderBar(),
            TaskTreeView(),
          ],
        ),
        backgroundColor: Colors.transparent,
      ),
    );
  }
}
