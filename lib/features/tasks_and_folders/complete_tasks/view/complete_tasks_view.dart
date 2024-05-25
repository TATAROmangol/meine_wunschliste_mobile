import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meine_wunschliste/features/tasks_and_folders/blocs/tasks_trees_bloc/tasks_trees_bloc.dart';
import 'package:meine_wunschliste/features/tasks_and_folders/complete_tasks/widgets/complete_task_tree.dart';

class CompleteTasksView extends StatelessWidget {
  const CompleteTasksView({super.key});

  @override
  Widget build(BuildContext context) {
    final listenBloc = BlocProvider.of<TasksTreesBloc>(context);
    return BlocProvider(
      create: (context) => TasksTreesBloc(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Достигнутые мечты'),
          backgroundColor: const Color(0xFFFF9648),
          toolbarHeight: MediaQuery.of(context).size.height * 0.05,
        ),
        body: CompleteTaskTreeView(listenBloc: listenBloc),
        backgroundColor: Colors.transparent,
      ),
    );
  }
}
