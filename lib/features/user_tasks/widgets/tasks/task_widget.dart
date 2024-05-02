import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meine_wunschliste/domain/models/models.dart';
import 'package:meine_wunschliste/features/user_tasks/blocs/folders_bloc/folders_bloc.dart';
import 'package:meine_wunschliste/features/user_tasks/blocs/tasks_bloc/tasks_bloc.dart';

class TaskWidget extends StatefulWidget {
  TaskWidget({required this.task, super.key});

  final Task task;

  @override
  _TaskWidgetState createState() => _TaskWidgetState(task: task);
}

class _TaskWidgetState extends State<TaskWidget> {
  _TaskWidgetState({required this.task});
  final Task task;
  bool watch = false;
  List<Task> childrens = [];

  @override
  Widget build(BuildContext context) {
    // final foldersBloc = BlocProvider.of<FoldersBloc>(context);
    // final tasksBloc = BlocProvider.of<TasksBloc>(context);
    final Size screenSize = MediaQuery.of(context).size;
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
              child: Text(task.name),
              onPressed: () {
                setState(() {
                  watch = !watch;
                });
              },
            )),
        if (watch && task.step != 2)
          Container(
            margin: EdgeInsets.only(bottom: screenSize.height * 0.013),
            height: screenSize.height * 0.09 * childrens.length,
            child: ReorderableList(
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: ((context, index) {
                final task = childrens[index];
                return TaskWidget(key: ValueKey(task.uid), task: task);
              }),
              itemCount: childrens.length,
              onReorder: ((oldIndex, newIndex) {
                if (newIndex > oldIndex) {
                  newIndex -= 1;
                }
                final Task folderNavigation = childrens.removeAt(oldIndex);
                childrens.insert(newIndex, folderNavigation);
              }),
            ),
          ),
        // if (watch) SizedBox()
      ],
    );
  }
}
