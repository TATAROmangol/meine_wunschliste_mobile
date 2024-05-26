import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meine_wunschliste/domain/repository_models/realm_models.dart';
import 'package:meine_wunschliste/features/tasks_and_folders/blocs/blocs.dart';
import 'package:meine_wunschliste/features/tasks_and_folders/blocs/tasks_trees_bloc/tasks_trees_bloc.dart';

class CompleteTaskButton extends StatelessWidget {
  const CompleteTaskButton(
      {required this.parentUid,
      required this.parentBloc,
      required this.task,
      super.key});

  final String parentUid;
  final Bloc parentBloc;
  final Task task;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        parentBloc is TasksTreesBloc
            ? parentBloc.add(
                CompleteTasksTreeChildEvent(task: task))
            : parentBloc is RootTaskBloc
                ? parentBloc.add(CompleteRootTaskChildEvent(
                    parentUid: parentUid, task: task))
                : parentBloc.add(CompleteSubtaskaskChildEvent(
                    parentUid: parentUid, task: task));
      },
      icon: const Icon(Icons.add_task),
    );
  }
}
