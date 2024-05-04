import 'package:flutter/material.dart';
import 'package:meine_wunschliste/domain/models/models.dart';
import 'package:meine_wunschliste/features/user_tasks/widgets/tasks/tasks.dart';

class TasksButtonsBar extends StatelessWidget {
  const TasksButtonsBar({required this.bloc, required this.task ,super.key});

  final bloc;
  final Task task;

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        color: Color(0xFFFFFF).withOpacity(0.5),
      ),
      margin: EdgeInsets.only(bottom: screenSize.height * 0.013),
      height: screenSize.height * 0.05,
      width: screenSize.width * 0.5,
      child: Row(children: [
        AddTaskButton(bloc: bloc, parentUid: task.uid),
        IconButton(onPressed: () {}, icon: Icon(Icons.delete)),
        IconButton(onPressed: () {}, icon: Icon(Icons.settings)),
        IconButton(onPressed: () {}, icon: Icon(Icons.comment)),
      ]),
    );
  }
}