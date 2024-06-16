import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meine_wunschliste/domain/repository_models/realm_models.dart';
import 'package:meine_wunschliste/features/tasks_and_folders/blocs/blocs.dart';

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
  CorrectingTaskButtonState createState() => CorrectingTaskButtonState();
}

class CorrectingTaskButtonState extends State<CorrectingTaskButton> {
  @override
  Widget build(BuildContext context) {
    final TextEditingController nameController =
        TextEditingController(text: widget.task.name);
    final TextEditingController commentController =
        TextEditingController(text: widget.task.comment);
    DateTime? dateTime;
    final Size screenSize = MediaQuery.of(context).size;

    return GestureDetector(
      child: Container(
        width: screenSize.height * 0.04,
        height: screenSize.height * 0.04,
        child: Center(
          child: Image.asset(
            'assets/icons/redact.png',
            width: screenSize.height * 0.035,
            height: screenSize.height * 0.035,
            fit: BoxFit.contain,
          ),
        ),
      ),
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
                    TextButton(
                      onPressed: () async {
                        final DateTime? picked = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime(2101),
                        );
                        if (picked != null) {
                          final TimeOfDay? time = await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.now(),
                          );
                          if (time != null) {
                            setState(() {
                              dateTime = DateTime(
                                picked.year,
                                picked.month,
                                picked.day,
                                time.hour,
                                time.minute,
                              );
                            });
                          }
                        }
                      },
                      child: const Text('Изменить дату и время'),
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
                            dateTime: dateTime,
                            task: widget.task))
                        : widget.parentBloc is RootTaskBloc
                            ? widget.parentBloc.add(
                                CorrectingRootTaskChildEvent(
                                    parentUid: widget.parentUid,
                                    name: taskName,
                                    comment: taskComment,
                                    dateTime: dateTime,
                                    task: widget.task))
                            : widget.parentBloc.add(CorrectingSubtaskChildEvent(
                                parentUid: widget.parentUid,
                                name: taskName,
                                comment: taskComment,
                                dateTime: dateTime,
                                task: widget.task));

                    nameController.clear();
                    commentController.clear();
                    dateTime = null;
                    Navigator.of(context).pop();
                  },
                  child: const Text('Изменить'),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
