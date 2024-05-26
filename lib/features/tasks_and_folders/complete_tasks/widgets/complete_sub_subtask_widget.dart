import 'package:flutter/material.dart';
import 'package:meine_wunschliste/domain/repository_models/realm_models.dart';
import 'package:meine_wunschliste/features/tasks_and_folders/blocs/blocs.dart';

class CompleteSubSubtaskWidget extends StatefulWidget {
  const CompleteSubSubtaskWidget(
      {required this.task,
      required this.parentTask,
      required this.parentBloc,
      super.key});

  final Task task;
  final Task parentTask;
  final SubtaskBloc parentBloc;

  @override
  CompleteSubSubtaskWidgetState createState() =>
      CompleteSubSubtaskWidgetState();
}

class CompleteSubSubtaskWidgetState extends State<CompleteSubSubtaskWidget> {
  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            color: Color(0xFFE0C3).withOpacity(0.5),
            border: const Border(
              left: BorderSide(
                color: Colors.green,
                width: 2.0,
              ),
              right: BorderSide(
                color: Colors.green,
                width: 3.0,
              ),
              bottom: BorderSide(
                color: Colors.green,
                width: 3.0,
              ),
              top: BorderSide(
                color: Colors.green,
                width: 2.0,
              ),
            ),
          ),
          height: screenSize.height * 0.07,
          width: screenSize.width * 0.84,
          margin: EdgeInsets.only(
            top: screenSize.height * 0.013,
            left: screenSize.width * 0.115,
            right: screenSize.width * 0.045,
          ),
          child: Center(child: Text(widget.task.name)),
        ),
      ],
    );
  }
}
