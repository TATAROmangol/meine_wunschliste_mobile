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
    final Size screenSize = MediaQuery.of(context).size;
    return GestureDetector(
      child: SizedBox(
        width: screenSize.height * 0.04,
        height: screenSize.height * 0.04,
        child: Center(
          child: Image.asset(
            'assets/icons/complete.png',
            width: screenSize.height * 0.04,
            height: screenSize.height * 0.04,
            fit: BoxFit.contain,
          ),
        ),
      ),
      onTap: () {
        parentBloc is TasksTreesBloc
            ? parentBloc.add(CompleteTasksTreeChildEvent(task: task))
            : parentBloc is RootTaskBloc
                ? parentBloc.add(CompleteRootTaskChildEvent(
                    parentUid: parentUid, task: task))
                : parentBloc.add(CompleteSubtaskaskChildEvent(
                    parentUid: parentUid, task: task));
      },
    );
  }
}
