import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meine_wunschliste/domain/models/models.dart';
import 'package:meine_wunschliste/domain/models/steps.dart';
import 'package:meine_wunschliste/features/user_tasks/widgets/tasks/tasks_buttons_bar.dart';
import 'package:meine_wunschliste/features/user_tasks/widgets/widgets.dart';

import '../../blocs/sub_subtasks_bloc/sub_subtasks_bloc.dart';
import '../../blocs/subtasks_bloc/subtasks_bloc.dart';

class SubtaskWidget extends StatefulWidget {
  SubtaskWidget({required this.task, required this.subSubtasksBloc, required this.subtasksBloc, super.key});

  final Task task;
  final SubSubtasksBloc subSubtasksBloc;
  final SubtasksBloc subtasksBloc;

  @override
  _SubtaskWidgetState createState() => _SubtaskWidgetState();
}

class _SubtaskWidgetState extends State<SubtaskWidget> {
  bool watch = false;
  List<Task> childrens = [Task('0', 'me', Steps.subSubtask.index)];

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return Column(
      children: [
        Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              color: Color(0xFFF4E5).withOpacity(0.5),
            ),
            height: screenSize.height * 0.09,
            width: screenSize.width * 0.87,
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
                    .map((e) => SubSubtaskWidget(
                          task: e,
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
