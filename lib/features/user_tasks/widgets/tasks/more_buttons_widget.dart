import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meine_wunschliste/domain/models/models.dart';
import 'package:meine_wunschliste/features/user_tasks/blocs/blocs.dart';
import 'package:meine_wunschliste/features/user_tasks/widgets/widgets.dart';

class MoreButtonsWidget extends StatelessWidget {
  const MoreButtonsWidget(
      {required this.parentUid,
      required this.task,
      required this.parentBloc,
      required this.currentBloc,
      super.key});

  final String parentUid;
  final Task task;
  final Bloc parentBloc;
  final Bloc currentBloc;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (currentBloc is! SubSubtaskBloc)
          AddChildTaskButton(currentBloc: currentBloc, task: task),

        DeleteTaskButton(
            parentBloc: parentBloc, task: task, parentUid: parentUid),

        if (currentBloc is! SubSubtaskBloc)
          ChangeChildrenTasksOrderButton(task: task, currentBloc: currentBloc),
          
        CorrectingTaskButton(
            parentBloc: parentBloc, parentUid: parentUid, task: task)
      ],
    );
  }
}
