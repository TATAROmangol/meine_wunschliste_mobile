import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meine_wunschliste/domain/models/models.dart';
import 'package:meine_wunschliste/features/user_tasks/blocs/blocs.dart';
import 'package:meine_wunschliste/features/user_tasks/widgets/widgets.dart';

class RootTaskWidget extends StatefulWidget {
  RootTaskWidget({required this.task, super.key});

  final Task task;

  @override
  _RootTaskWidgetState createState() => _RootTaskWidgetState();
}

class _RootTaskWidgetState extends State<RootTaskWidget> {
  bool watch = false;

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final rootTasksBloc = BlocProvider.of<RootTaskBloc>(context);

    return BlocBuilder<RootTaskBloc, RootTaskState>(
      builder: (context, state) {
        return Column(
          children: [
            Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  color: Color(0xFFFFFF).withOpacity(0.5),
                ),
                height: screenSize.height * 0.09,
                width: screenSize.width * 0.91,
                margin: EdgeInsets.only(bottom: screenSize.height * 0.013),
                child: TextButton(
                  child: Text(widget.task.name),
                  onPressed: () {
                    watch = !watch;
                    rootTasksBloc.add(
                        ShowRootTaskChildrenEvent(parentUid: widget.task.uid));
                  },
                )),
            if (watch && state is ShowRootTaskChildrensState)
              Column(
                children: [
                  TasksButtonsBar(
                      bloc: rootTasksBloc, task: widget.task),
                  Column(
                    children: state.childrens.map(
                      (task) {
                        return BlocProvider<SubtaskBloc>(
                          create: (context) => SubtaskBloc(),
                          child: SubtaskWidget(
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
