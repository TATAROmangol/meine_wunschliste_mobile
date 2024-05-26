import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meine_wunschliste/domain/repository_models/realm_models.dart';
import 'package:meine_wunschliste/features/tasks_and_folders/blocs/blocs.dart';
import 'package:meine_wunschliste/features/tasks_and_folders/complete_tasks/widgets/widgets.dart';

class CompleteRootTaskWidget extends StatefulWidget {
  const CompleteRootTaskWidget(
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
  CompleteRootTaskWidgetState createState() => CompleteRootTaskWidgetState();
}

class CompleteRootTaskWidgetState extends State<CompleteRootTaskWidget> {
  @override
  void initState() {
    widget.isActive
        ? widget.currentBloc.add(ShowRootTaskEvent(parentUid: widget.task.uid))
        : widget.currentBloc.add(CloseRootTaskEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    //ты писька
    return BlocListener<TasksTreesBloc, TasksTreesState>(
      bloc: widget.parentBloc,
      listener: (context, state) {
        if (state is ShowCompleteTasksTreesState) {
          state.activeChildUid == widget.task.uid
              ? widget.currentBloc
                  .add(ShowRootTaskEvent(parentUid: widget.task.uid))
              : widget.currentBloc.add(CloseRootTaskEvent());
        }
      },
      child: BlocBuilder<RootTaskBloc, RootTaskState>(
        bloc: widget.currentBloc,
        builder: (context, state) {
          return Column(
            children: [
              Column(
                children: [
                  Container(
                    decoration: !widget.isActive
                        ? BoxDecoration(
                            borderRadius: BorderRadius.circular(15.0),
                            color: Color(0xFFFFFF).withOpacity(0.5),
                          )
                        : BoxDecoration(
                            borderRadius: BorderRadius.circular(15.0),
                            color: Color(0xFFFFFF).withOpacity(0.5),
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
                    height: screenSize.height * 0.09,
                    width: screenSize.width * 0.91,
                    margin: EdgeInsets.only(
                      top: screenSize.height * 0.013,
                      left: screenSize.width * 0.045,
                      right: screenSize.width * 0.045,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextButton(
                              onPressed: () {
                                state is ShowRootTaskState
                                    ? widget.parentBloc
                                        .add(ShowCompleteTasksTreesEvent())
                                    : widget.parentBloc.add(
                                        ShowCompleteTasksTreesEvent(
                                            activeChildUid: widget.task.uid));
                              },
                              child: Text(widget.task.name)),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              if (state is ShowRootTaskState)
                Column(
                  children: state.children.map(
                    (e) {
                      return BlocProvider<SubtaskBloc>(
                        key: ValueKey(e.uid),
                        create: (context) => SubtaskBloc(),
                        child: BlocBuilder<SubtaskBloc, SubtaskState>(
                          builder: (context, state) {
                            return CompleteSubtaskWidget(
                              task: e,
                              parentTask: widget.task,
                              currentBloc:
                                  BlocProvider.of<SubtaskBloc>(context),
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
