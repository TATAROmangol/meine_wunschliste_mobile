import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meine_wunschliste/domain/models/models.dart';
import 'package:meine_wunschliste/features/user_tasks/blocs/blocs.dart';
import 'package:meine_wunschliste/features/user_tasks/widgets/widgets.dart';
import '../../blocs/subtask_bloc/subtask_bloc.dart';

class SubtaskWidget extends StatefulWidget {
  SubtaskWidget({required this.task, super.key});

  final Task task;

  @override
  _SubtaskWidgetState createState() => _SubtaskWidgetState();
}

class _SubtaskWidgetState extends State<SubtaskWidget> {
  bool watch = false;

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final SubtaskBloc subtasksBloc = BlocProvider.of<SubtaskBloc>(context);

    return BlocBuilder<SubtaskBloc, SubtaskState>(
      builder: (context, state) {
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
                    watch = !watch;
                    subtasksBloc.add(
                        ShowSubtaskChildrenEvent(parentUid: widget.task.uid));
                  },
                )),
            if (watch && state is ShowSubtaskChildrenState)
              Column(
                children: [
                  TasksButtonsBar(
                      bloc: subtasksBloc, task: widget.task),
                  Column(
                    children: state.childrens.map(
                      (task) {
                        return BlocProvider<SubSubtaskBloc>(
                          create: (context) => SubSubtaskBloc(),
                          child: SubSubtaskWidget(
                            task: task,
                          ),
                        );
                      },
                    ).toList(),
                  ),
                ],
              ),
          ],
        );
      },
    );
  }
}
