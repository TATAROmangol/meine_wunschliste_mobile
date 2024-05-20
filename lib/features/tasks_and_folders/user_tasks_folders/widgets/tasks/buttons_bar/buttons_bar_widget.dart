import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meine_wunschliste/domain/models/models.dart';
import 'package:meine_wunschliste/features/tasks_and_folders/blocs/blocs.dart';
import 'package:meine_wunschliste/features/tasks_and_folders/user_tasks_folders/widgets/tasks/buttons_bar/buttons_bar.dart';

class ButtonsBarwidget extends StatefulWidget {
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
  ButtonsBarwidgetState createState() => ButtonsBarwidgetState();
}

class ButtonsBarwidgetState extends State<ButtonsBarwidget> {
  bool showComment = false;

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(10.0),
          bottomRight: Radius.circular(10.0),
        ),
        color: widget.currentBloc is RootTaskBloc
            ? Color(0xFFFFFF).withOpacity(0.5)
            : widget.currentBloc is SubtaskBloc
                ? Color(0xFFF4E5).withOpacity(0.5)
                : Color(0xFFE0C3).withOpacity(0.5),
        border: const Border(
          left: BorderSide(
            color: Colors.black,
            width: 2.0,
          ),
          right: BorderSide(
            color: Colors.black,
            width: 3.0,
          ),
          bottom: BorderSide(
            color: Colors.black,
            width: 3.0,
          ),
        ),
      ),
      width: screenSize.width * 0.78,
      margin: widget.currentBloc is RootTaskBloc
          ? EdgeInsets.only(
              bottom: screenSize.height * 0.013,
              left: screenSize.width * 0.09,
              right: screenSize.width * 0.09,
            )
          : widget.currentBloc is SubtaskBloc
              ? EdgeInsets.only(
                  bottom: screenSize.height * 0.013,
                  left: screenSize.width * 0.10,
                  right: screenSize.width * 0.08,
                )
              : EdgeInsets.only(
                  bottom: screenSize.height * 0.013,
                  left: screenSize.width * 0.11,
                  right: screenSize.width * 0.09,
                ),
      child: widget.task.isComplete
          ? Column(
              children: [
                UncompleteTaskButton(
                    parentUid: widget.parentUid,
                    parentBloc: widget.parentBloc,
                    task: widget.task),
              ],
            )
          : Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    if (widget.currentBloc is! SubSubtaskBloc)
                      AddChildTaskButton(
                          currentBloc: widget.currentBloc, task: widget.task),
                    if (widget.currentBloc is! SubSubtaskBloc)
                      ChangeChildrenTasksOrderButton(
                          task: widget.task, currentBloc: widget.currentBloc),
                    showComment
                        ? IconButton(
                            onPressed: () =>
                                setState(() => showComment = !showComment),
                            icon: const Icon(Icons.airplanemode_active))
                        : IconButton(
                            onPressed: () =>
                                setState(() => showComment = !showComment),
                            icon: const Icon(Icons.airplanemode_inactive)),
                    DeleteTaskButton(
                        parentBloc: widget.parentBloc,
                        task: widget.task,
                        parentUid: widget.parentUid),
                    CorrectingTaskButton(
                        parentBloc: widget.parentBloc,
                        parentUid: widget.parentUid,
                        task: widget.task),
                    widget.childrenComplete
                        ? CompleteTaskButton(
                            parentUid: widget.parentUid,
                            parentBloc: widget.parentBloc,
                            task: widget.task)
                        : const Icon(Icons.add_alert)
                  ],
                ),
                if (showComment)
                  Container(
                    width: screenSize.width * 0.78,
                    decoration: const BoxDecoration(
                      border: Border(
                        top: BorderSide(
                          color: Colors.black,
                          width: 2.0,
                        ),
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(screenSize.width * 0.02),
                      child: Center(child: Text(widget.task.comment)),
                    ),
                  )
              ],
            ),
    );
  }
}
