import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/state_manager.dart';
import 'package:meine_wunschliste/domain/models/models.dart';
import 'package:meine_wunschliste/features/user_tasks/blocs/blocs.dart';
import 'package:meine_wunschliste/features/user_tasks/widgets/tasks/more_bar.dart';
import 'package:meine_wunschliste/features/user_tasks/widgets/widgets.dart';

class RootTaskWidget extends StatefulWidget {
  const RootTaskWidget(
      {required this.task,
      required this.isActive,
      required this.currentBloc,
      required this.parentBloc,
      super.key});

  final Task task;
  final bool isActive;
  final RootTaskBloc currentBloc;
  final TasksTreesBloc parentBloc;

  @override
  RootTaskWidgetState createState() => RootTaskWidgetState();
}

class RootTaskWidgetState extends State<RootTaskWidget> {
  bool watchSettingsButtons = false;
  bool watchMoreButtons = false;

  @override
  void initState() {
    widget.isActive
        ? widget.currentBloc
            .add(ShowRootTaskChildrenEvent(parentUid: widget.task.uid))
        : widget.currentBloc.add(CloseRootTaskChildrenEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    //ты писька
    return BlocListener<TasksTreesBloc, TasksTreesState>(
      bloc: widget.parentBloc,
      listener: (context, state) {
        if (state is ShowTasksTreesState) {
          if(state.activeChildUid == widget.task.uid)
          {
widget.currentBloc
                  .add(ShowRootTaskChildrenEvent(parentUid: widget.task.uid));
          } else {
            widget.currentBloc.add(CloseRootTaskChildrenEvent());
            watchSettingsButtons = false;
          }
          //watchSettingsButtons = false;
          watchMoreButtons = false;
        }
      },
      child: BlocBuilder<RootTaskBloc, RootTaskState>(
        bloc: widget.currentBloc,
        builder: (context, state) {
          return Column(children: [
            GestureDetector(
              onHorizontalDragUpdate: (details) {
                if (details.delta.dx > 0) {
                  if (widget.isActive) {
                    setState(() {
                      watchSettingsButtons = false;
                    });
                  }
                } else if (details.delta.dx < 0) {
                  if (widget.isActive) {
                    // свайп влево
                    setState(() {
                      watchSettingsButtons = true;
                      watchMoreButtons = false;
                      widget.currentBloc.add(ShowRootTaskChildrenEvent(
                          parentUid: widget.task.uid));
                      widget.parentBloc.add(
                          ShowTasksTreesEvent(activeChildUid: widget.task.uid));
                    });
                  }
                }
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  color: Color(0xFFFFFF).withOpacity(0.5),
                ),
                height: screenSize.height * 0.09,
                width: screenSize.width * 0.91,
                margin: EdgeInsets.only(bottom: screenSize.height * 0.013),
                child: watchSettingsButtons
                    ? Row(
                        children: [
                          ChangeTasksOrderButton(
                            task: widget.task,
                            bloc: widget.currentBloc,
                          ),
                          DeleteTaskButton(
                              bloc: widget.parentBloc, task: widget.task)
                        ],
                      )
                    : Row(
                        children: [
                          Expanded(
                            child: TextButton(
                                onPressed: () {
                                  widget.isActive
                                      ? widget.parentBloc
                                          .add(ShowTasksTreesEvent())
                                      : widget.parentBloc.add(
                                          ShowTasksTreesEvent(
                                              activeChildUid: widget.task.uid));
                                },
                                child: Text(widget.task.name)),
                          ),
                          Container(
                              width: 50,
                              height: 50,
                              child: widget.isActive
                                  ? IconButton(
                                      onPressed: () {
                                        setState(() {
                                          watchMoreButtons = !watchMoreButtons;
                                        });
                                      },
                                      icon: const Icon(Icons.more))
                                  : Container())
                        ],
                      ),
              ),
            ),
            if (watchMoreButtons)
              MainBar(
                  currentBloc: widget.currentBloc, currentTask: widget.task),
            if (state is ShowRootTaskChildrenState)
              Column(
                children: state.children.map(
                  (e) {
                    var isActive = state.activeChildUid == e.uid;
                    return BlocProvider<SubtaskBloc>(
                      key: ValueKey(e.uid),
                      create: (context) => SubtaskBloc(),
                      child: BlocBuilder<SubtaskBloc, SubtaskState>(
                        builder: (context, state) {
                          return SubtaskWidget(
                            task: e,
                            parentUid: widget.task.uid,
                            isActive: isActive,
                            currentBloc: BlocProvider.of<SubtaskBloc>(context),
                            parentBloc: widget.currentBloc,
                          );
                        },
                      ),
                    );
                  },
                ).toList(),
              ),
          ]);
        },
      ),
    );
  }
}
