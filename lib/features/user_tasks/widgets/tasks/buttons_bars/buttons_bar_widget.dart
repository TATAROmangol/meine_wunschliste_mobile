import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meine_wunschliste/domain/models/models.dart';
import 'package:meine_wunschliste/features/user_tasks/blocs/blocs.dart';
import 'package:meine_wunschliste/features/user_tasks/widgets/tasks/buttons_bars/buttons_bars.dart';

class ButtonsBarwidget extends StatelessWidget {
  const ButtonsBarwidget(
      {required this.parentUid,
      required this.task,
      required this.parentBloc,
      required this.currentBloc,
      required this.childrenComplete,
      super.key});

  final String parentUid;
  final Task task;
  final bool childrenComplete;
  final Bloc parentBloc;
  final Bloc currentBloc;

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return SizedBox(
      width: screenSize.width * 0.8,
      child: task.isComplete
          ? UncompleteTaskButton(
              parentUid: parentUid, parentBloc: parentBloc, task: task)
          : Row(
              children: [
                if (currentBloc is! SubSubtaskBloc)
                  AddChildTaskButton(currentBloc: currentBloc, task: task),
                if (currentBloc is! SubSubtaskBloc)
                  ChangeChildrenTasksOrderButton(
                      task: task, currentBloc: currentBloc),
                DeleteTaskButton(
                    parentBloc: parentBloc, task: task, parentUid: parentUid),
                CorrectingTaskButton(
                    parentBloc: parentBloc, parentUid: parentUid, task: task),
                childrenComplete
                    ? CompleteTaskButton(
                        parentUid: parentUid,
                        parentBloc: parentBloc,
                        task: task)
                    : const Icon(Icons.add_alert)
              ],
            ),
    );
  }
}
