import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meine_wunschliste/domain/models/models.dart';
import 'package:meine_wunschliste/features/user_tasks/blocs/blocs.dart';
import 'package:meine_wunschliste/features/user_tasks/widgets/tasks/buttons_bars/buttons_bar_widget.dart';

class SubSubtaskWidget extends StatefulWidget {
  const SubSubtaskWidget(
      {required this.task,
      required this.parentTask,
      required this.currentBloc,
      required this.parentBloc,
      super.key});

  final Task task;
  final Task parentTask;
  final SubSubtaskBloc currentBloc;
  final SubtaskBloc parentBloc;

  @override
  SubSubtaskWidgetState createState() => SubSubtaskWidgetState();
}

class SubSubtaskWidgetState extends State<SubSubtaskWidget> {
  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return BlocListener<SubtaskBloc, SubtaskState>(
      bloc: widget.parentBloc,
      listener: (context, state) {
        if (state is ShowSubtaskState) {
          state.activeChildUid != widget.task.uid
              ? widget.currentBloc.add(CloseSubSubtaskEvent())
              : widget.currentBloc.add(ShowSubSubtaskEvent());
        }
      },
      child: BlocBuilder<SubSubtaskBloc, SubSubtaskState>(
        bloc: widget.currentBloc,
        builder: (context, state) {
          return Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  color: Color(0xFFE0C3).withOpacity(0.5),
                ),
                height: screenSize.height * 0.07,
                width: screenSize.width * 0.84,
                margin: EdgeInsets.only(
                  bottom: screenSize.height * 0.013,
                  left: screenSize.width * 0.08,
                  right: screenSize.width * 0.045,
                ),
                child: widget.parentTask.isComplete
                    ? Center(child: Text(widget.task.name))
                    : TextButton(
                        onPressed: () {
                          state is ShowSubSubtaskState
                              ? widget.parentBloc.add(ShowSubtaskEvent(
                                  parentUid: widget.parentTask.uid))
                              : widget.parentBloc.add(ShowSubtaskEvent(
                                  parentUid: widget.parentTask.uid,
                                  activeChildUid: widget.task.uid));
                        },
                        child: Text(widget.task.name)),
              ),
              if (state is ShowSubSubtaskState && !widget.parentTask.isComplete)
                ButtonsBarwidget(
                    parentUid: widget.parentTask.uid,
                    task: widget.task,
                    parentBloc: widget.parentBloc,
                    currentBloc: widget.currentBloc,
                    childrenComplete: true),
            ],
          );
        },
      ),
    );
  }
}
