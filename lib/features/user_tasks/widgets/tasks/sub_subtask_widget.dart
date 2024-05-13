import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meine_wunschliste/domain/models/models.dart';
import 'package:meine_wunschliste/features/user_tasks/blocs/blocs.dart';
import 'package:meine_wunschliste/features/user_tasks/widgets/tasks/tasks_buttons/delete_task.dart';

import '../../blocs/sub_subtask_bloc/sub_subtask_bloc.dart';

class SubSubtaskWidget extends StatefulWidget {
  const SubSubtaskWidget(
      {required this.task,
      required this.parentUid,
      required this.currentBloc,
      required this.parentBloc,
      super.key});

  final Task task;
  final String parentUid;
  final SubSubtaskBloc currentBloc;
  final SubtaskBloc parentBloc;

  @override
  SubSubtaskWidgetState createState() => SubSubtaskWidgetState();
}

class SubSubtaskWidgetState extends State<SubSubtaskWidget> {
  bool watchSettingsButtons = false;

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return BlocBuilder<SubSubtaskBloc, SubSubtaskState>(
      bloc: widget.currentBloc,
      builder: (context, state) {
        return Column(children: [
          GestureDetector(
            onHorizontalDragUpdate: (details) {
              if (details.delta.dx > 0) {
                // свайп вправо
                setState(() {
                  watchSettingsButtons = false;
                });
              } else if (details.delta.dx < 0) {
                // свайп влево
                setState(() {
                  watchSettingsButtons = true;
                });
              }
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                color: Color(0xFFE0C3).withOpacity(0.5),
              ),
              height: screenSize.height * 0.07,
              width: screenSize.width * 0.84,
              margin: EdgeInsets.only(bottom: screenSize.height * 0.013),
              child: watchSettingsButtons
                  ? Row(
                      children: [
                        DeleteTaskButton(
                            bloc: widget.parentBloc, task: widget.task)
                      ],
                    )
                  : TextButton(
                      onPressed: () {},
                      child: Text(widget.task.name),
                    ),
            ),
          ),
        ]);
      },
    );
  }
}
