import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meine_wunschliste/domain/models/models.dart';
import 'package:meine_wunschliste/domain/models/steps.dart';
import 'package:meine_wunschliste/features/user_tasks/blocs/root_task_bloc/root_task_bloc.dart';
import 'package:meine_wunschliste/features/user_tasks/widgets/tasks/tasks_buttons_bar.dart';
import 'package:meine_wunschliste/features/user_tasks/widgets/widgets.dart';

import '../../blocs/sub_subtask_bloc/sub_subtask_bloc.dart';
import '../../blocs/subtask_bloc/subtask_bloc.dart';

class RootTaskWidget extends StatefulWidget {
  RootTaskWidget(
      {required this.task,
      required this.rootTasksBloc,
      required this.subtasksBloc,
      required this.subSubtasksBloc,
      super.key});

  final Task task;
  final RootTaskBloc rootTasksBloc;
  final SubtaskBloc subtasksBloc;
  final SubSubtaskBloc subSubtasksBloc;

  @override
  _RootTaskWidgetState createState() => _RootTaskWidgetState();
}

class _RootTaskWidgetState extends State<RootTaskWidget> {
  bool watch = false;
  List<Task> childrens = [Task('0', 'hello', Steps.subSubtask.index)];

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return Column(
      children: [
        Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              color: Color(0xFFFFFF).withOpacity(0.5),
            ),
            height: screenSize.height * 0.09,
            width: screenSize.width * 0.91,
            margin: EdgeInsets.only(bottom: screenSize.height * 0.013),
            child: TextButton(
              child: Text(widget.task.name),
              onPressed: () {
                setState(() {
                  watch = !watch;
                });
              },
            )),
        if (watch)
          Column(
            children: [
              const TasksButtonsBar(),
              Column(
                children: childrens
                    .map((e) => SubtaskWidget(
                          task: e,
                          subtasksBloc: widget.subtasksBloc,
                          subSubtasksBloc: widget.subSubtasksBloc,
                        ))
                    .toList(),
              ),
            ],
          ),
      ],
    );
  }
}
