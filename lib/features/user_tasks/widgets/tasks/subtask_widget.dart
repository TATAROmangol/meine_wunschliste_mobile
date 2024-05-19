import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meine_wunschliste/domain/models/models.dart';
import 'package:meine_wunschliste/features/user_tasks/blocs/blocs.dart';
import 'package:meine_wunschliste/features/user_tasks/widgets/tasks/buttons_bars/buttons_bar_widget.dart';
import 'package:meine_wunschliste/features/user_tasks/widgets/widgets.dart';

class SubtaskWidget extends StatefulWidget {
  const SubtaskWidget(
      {required this.task,
      required this.parentTask,
      required this.currentBloc,
      required this.parentBloc,
      super.key});

  final Task task;
  final Task parentTask;
  final SubtaskBloc currentBloc;
  final RootTaskBloc parentBloc;

  @override
  SubtaskWidgetState createState() => SubtaskWidgetState();
}

class SubtaskWidgetState extends State<SubtaskWidget> {
  bool showComment = false;

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return BlocListener<RootTaskBloc, RootTaskState>(
      bloc: widget.parentBloc,
      listener: (context, state) {
        if (state is ShowRootTaskState) {
          state.activeChildUid == widget.task.uid
              ? widget.currentBloc
                  .add(ShowSubtaskEvent(parentUid: widget.task.uid))
              : widget.currentBloc.add(CloseSubtaskEvent());
        }
      },
      child: BlocBuilder<SubtaskBloc, SubtaskState>(
        bloc: widget.currentBloc,
        builder: (context, state) {
          return Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  color: Color(0xFFF4E5).withOpacity(0.5),
                ),
                height: screenSize.height * 0.08,
                width: screenSize.width * 0.87,
                margin: EdgeInsets.only(
                  bottom: screenSize.height * 0.013,
                  left: screenSize.width * 0.065,
                  right: screenSize.width * 0.045,
                ),
                child: widget.parentTask.isComplete
                    ? Center(child: Text(widget.task.name))
                    : Row(
                        children: [
                          Expanded(
                            child: TextButton(
                                onPressed: () {
                                  if (state is ShowSubtaskState &&
                                      state.activeChildUid != '') {
                                    widget.parentBloc.add(ShowRootTaskEvent(
                                        parentUid: widget.parentTask.uid,
                                        activeChildUid: widget.task.uid));
                                  } else if (state is ShowSubtaskState) {
                                    widget.parentBloc.add(ShowRootTaskEvent(
                                        parentUid: widget.parentTask.uid));
                                  } else {
                                    widget.parentBloc.add(ShowRootTaskEvent(
                                        parentUid: widget.parentTask.uid,
                                        activeChildUid: widget.task.uid));
                                  }
                                },
                                child: Text(widget.task.name)),
                          )
                        ],
                      ),
              ),
              if (state is ShowSubtaskState &&
                  state.activeChildUid == '' &&
                  !widget.parentTask.isComplete)
                ButtonsBarwidget(
                    parentUid: widget.parentTask.uid,
                    task: widget.task,
                    parentBloc: widget.parentBloc,
                    currentBloc: widget.currentBloc,
                    childrenComplete: state.childrenComplete),
              if (state is ShowSubtaskState)
                Column(
                  children: state.children.map(
                    (e) {
                      return BlocProvider<SubSubtaskBloc>(
                        key: ValueKey(e.uid),
                        create: (context) => SubSubtaskBloc(),
                        child: BlocBuilder<SubSubtaskBloc, SubSubtaskState>(
                          builder: (context, state) {
                            return SubSubtaskWidget(
                              task: e,
                              parentTask: widget.task,
                              currentBloc:
                                  BlocProvider.of<SubSubtaskBloc>(context),
                              parentBloc: widget.currentBloc,
                            );
                          },
                        ),
                      );
                    },
                  ).toList(),
                ),
            ],
          );
        },
      ),
    );
  }
}
