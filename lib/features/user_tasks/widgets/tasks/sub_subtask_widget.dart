import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meine_wunschliste/domain/models/models.dart';
import 'package:meine_wunschliste/features/user_tasks/widgets/tasks/tasks_buttons_bar.dart';

import '../../blocs/sub_subtask_bloc/sub_subtask_bloc.dart';

class SubSubtaskWidget extends StatefulWidget {
  SubSubtaskWidget({required this.task, super.key});

  final Task task;

  @override
  _SubSubtaskWidgetState createState() => _SubSubtaskWidgetState();
}

class _SubSubtaskWidgetState extends State<SubSubtaskWidget> {
  bool watch = false;

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final SubSubtaskBloc subSubtaskBloc =
        BlocProvider.of<SubSubtaskBloc>(context);

    return BlocBuilder<SubSubtaskBloc, SubSubtaskState>(
      builder: (context, state) {
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
                onPressed: () {},
              ),
            ),
            // if (watch)
            //   Column(
            //     children: [
            //       TasksButtonsBar(
            //           bloc: widget.subSubtaskBloc, parentUid: widget.task.uid),
            //     ],
            //   ),
          ],
        );
      },
    );
  }
}
