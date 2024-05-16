import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meine_wunschliste/domain/models/models.dart';
import 'package:meine_wunschliste/features/user_tasks/blocs/blocs.dart';
import 'package:meine_wunschliste/features/user_tasks/blocs/root_task_bloc/root_task_bloc.dart';
import 'package:meine_wunschliste/features/user_tasks/blocs/subtask_bloc/subtask_bloc.dart';

class CorrectingTaskButton extends StatefulWidget {
  const CorrectingTaskButton(
      {required this.task,
      required this.parentUid,
      required this.parentBloc,
      super.key});

  final Task task;
  final String parentUid;
  final Bloc parentBloc;

  @override
  CorrectingTaskButtonState createState() =>
      CorrectingTaskButtonState();
}

class CorrectingTaskButtonState extends State<CorrectingTaskButton> {

  


  @override
  Widget build(BuildContext context) {
    final TextEditingController nameController =
        TextEditingController(text: widget.task.name);
    final TextEditingController commentController =
        TextEditingController(text: widget.task.comment);
    final Size screenSize = MediaQuery.of(context).size;

    return GestureDetector(
      child: const Icon(Icons.abc),
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Изменить Задачу'),
              content: SizedBox(
                width: screenSize.width * 0.8,
                height: screenSize.width * 0.8,
                child: Column(
                  children: [
                    TextField(
                      controller: nameController,
                    ),
                    TextField(
                      controller: commentController,
                    ),
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Отмена'),
                ),
                ElevatedButton(
                  onPressed: () {
                    String taskName = nameController.text;
                    String taskComment = commentController.text;
                    widget.parentBloc is TasksTreesBloc
                        ? widget.parentBloc.add(CorrectingTasksTreeChildEvent(
                            parentUid: widget.parentUid,
                            name: taskName,
                            comment: taskComment,
                            task: widget.task))
                        : widget.parentBloc is RootTaskBloc
                        ? widget.parentBloc.add(CorrectingRootTaskChildEvent(
                            parentUid: widget.parentUid,
                            name: taskName,
                            comment: taskComment,
                            task: widget.task))
                        : widget.parentBloc.add(CorrectingSubtaskChildEvent(
                            parentUid: widget.parentUid,
                            name: taskName,
                            comment: taskComment,
                            task: widget.task));

                    nameController.clear();
                    commentController.clear();
                    Navigator.of(context).pop();
                  },
                  child: const Text('Добавить'),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
