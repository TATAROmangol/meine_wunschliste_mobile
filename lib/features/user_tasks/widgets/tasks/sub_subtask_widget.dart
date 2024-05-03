import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meine_wunschliste/domain/models/models.dart';
import 'package:meine_wunschliste/domain/models/steps.dart';
import 'package:meine_wunschliste/features/user_tasks/widgets/tasks/tasks_buttons_bar.dart';

import '../../blocs/sub_subtask_bloc/sub_subtask_bloc.dart';
import '../../blocs/subtask_bloc/subtask_bloc.dart';

class SubSubtaskWidget extends StatefulWidget {
  SubSubtaskWidget(
      {required this.task, required this.subSubtasksBloc, super.key});

  final Task task;
  final SubSubtaskBloc subSubtasksBloc;

  @override
  _SubSubtaskWidgetState createState() => _SubSubtaskWidgetState();
}

class _SubSubtaskWidgetState extends State<SubSubtaskWidget> {
  bool watch = false;
  List<Task> childrens = [Task('0', 'hello', Steps.rootTask.index)];

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return Column(
      children: [
        Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              color: Color(0xFFE0C3).withOpacity(0.5),
            ),
            height: screenSize.height * 0.09,
            width: screenSize.width * 0.84,
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
          const Column(
            children: [
              TasksButtonsBar(),
            ],
          ),
      ],
    );
  }
}
