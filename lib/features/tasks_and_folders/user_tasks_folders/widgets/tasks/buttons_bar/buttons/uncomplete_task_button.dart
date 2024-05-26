import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meine_wunschliste/domain/repository_models/realm_models.dart';
import 'package:meine_wunschliste/features/tasks_and_folders/blocs/blocs.dart';

class UncompleteTaskButton extends StatelessWidget {
  const UncompleteTaskButton(
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
        parentBloc is RootTaskBloc
                ? parentBloc.add(UncompleteRootTaskChildEvent(
                    parentUid: parentUid, task: task))
                : parentBloc.add(UncompleteSubtaskaskChildEvent(
                    parentUid: parentUid, task: task));
      },
      icon: const Icon(Icons.auto_delete_sharp),
    );
  }
}
