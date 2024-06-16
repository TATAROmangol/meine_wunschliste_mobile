import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:meine_wunschliste/domain/user_theme.dart';
import 'package:meine_wunschliste/features/tasks_and_folders/blocs/blocs.dart';

class AddTasksTreeButton extends StatefulWidget {
  const AddTasksTreeButton({super.key});

  @override
  AddTasksTreeButtonState createState() => AddTasksTreeButtonState();
}

class AddTasksTreeButtonState extends State<AddTasksTreeButton> {
  final UserTheme theme = GetIt.I.get<UserTheme>();
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
    final TasksTreesBloc tasksTreeBloc =
        BlocProvider.of<TasksTreesBloc>(context);
    return GestureDetector(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          color: theme.accentColor,
        ),
        height: screenSize.height * 0.045,
        width: screenSize.height * 0.045,
        margin: const EdgeInsets.only(bottom: 5),
        child: Center(
          child: Image.asset(
            'assets/icons/add_task_tree.png',
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
                      tasksTreeBloc.add(AddTasksTreeEvent(
                          name: taskName,
                          comment: taskComment,
                          dateTime: dateTime));
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
