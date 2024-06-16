import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meine_wunschliste/features/tasks_and_folders/blocs/blocs.dart';
import 'package:meine_wunschliste/services/notification_service.dart';

class AddChildTaskButton extends StatefulWidget {
  const AddChildTaskButton(
      {required this.currentBloc, required this.parentUid, super.key});

  final Bloc currentBloc;
  final String parentUid;

  @override
  AddChildTaskButtonState createState() => AddChildTaskButtonState();
}

class AddChildTaskButtonState extends State<AddChildTaskButton> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController commentController = TextEditingController();
  DateTime? dateTime;

  @override
  void dispose() {
    nameController.dispose();
    commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return GestureDetector(
      child: SizedBox(
        width: screenSize.height * 0.04,
        height: screenSize.height * 0.04,
        child: Center(
          child: Image.asset(
            'assets/icons/add_task.png',
            width: screenSize.height * 0.04,
            height: screenSize.height * 0.04,
            fit: BoxFit.contain,
          ),
        ),
      ),
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Добавить Задачу'),
              content: SizedBox(
                width: screenSize.width * 0.8,
                height: screenSize.width * 0.8,
                child: Column(
                  children: [
                    TextField(
                      controller: nameController,
                      decoration: const InputDecoration(
                        labelText: 'Введите название',
                      ),
                    ),
                    TextField(
                      controller: commentController,
                      decoration: const InputDecoration(
                        labelText: 'Введите описание',
                      ),
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
                      child: const Text('Выбрать дату и время'),
                    ),
                    if (dateTime != null) Text('Дата: ${dateTime.toString()}'),
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
                    if (taskName.isNotEmpty) {
                      widget.currentBloc is RootTaskBloc
                          ? widget.currentBloc.add(AddRootTaskChildEvent(
                              name: taskName,
                              comment: taskComment,
                              dateTime: dateTime,
                              parentUid: widget.parentUid))
                          : widget.currentBloc.add(AddSubtaskChildEvent(
                              name: taskName,
                              comment: taskComment,
                              dateTime: dateTime,
                              parentUid: widget.parentUid));
                    }
                    nameController.clear();
                    commentController.clear();
                    dateTime = null;
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
