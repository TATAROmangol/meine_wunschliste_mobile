import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:meine_wunschliste/domain/repository.dart';
import 'package:meine_wunschliste/domain/repository_models/realm_models.dart';
import 'package:meine_wunschliste/domain/user_theme.dart';
import 'package:meine_wunschliste/features/tasks_and_folders/blocs/blocs.dart';
import 'package:meine_wunschliste/features/tasks_and_folders/user_tasks_folders/widgets/tasks/buttons_bar/buttons/buttons.dart';

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
    final UserTheme theme = GetIt.I.get<UserTheme>();
    final Repository repository = GetIt.I.get<Repository>();

    final TextEditingController nameController =
        TextEditingController(text: widget.task.name);
    final TextEditingController commentController =
        TextEditingController(text: widget.task.comment);

    var notification = repository.getNotification(widget.task.uid.hashCode);
    
    DateTime? selectedDate = notification?.scheduledDate;
    DataTextController dataTextController = selectedDate == null
    ? DataTextController('Выбрать дату')
    : DataTextController('${DateFormat('yyyy-MM-dd').format(selectedDate)}');
     
    final Size screenSize = MediaQuery.of(context).size;

    Color transformColor(Color color) {
    int red = color.red;
    int green = color.green + 28;
    int blue = color.blue + 34;

    green = green.clamp(0, 255);
    blue = blue.clamp(0, 255);

    return Color.fromARGB(color.alpha, red, green, blue);
  }

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
              title: const Text('Редактировать'),
              backgroundColor: theme.accentColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(35.0),
                side: BorderSide(color: theme.borderColor, width: 2.0),
              ),
              content: SingleChildScrollView(
                child: SizedBox(
                  width: screenSize.width * 0.8,
                  child: Column(
                    children: [
                      TextField(
                        controller: nameController,
                        decoration: InputDecoration(
                          labelText: 'Введите название',
                          filled: true,
                          fillColor: transformColor(theme.accentColor),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                            borderSide: BorderSide(
                              color: theme.borderColor,
                              width: 1.0,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                            borderSide: BorderSide(
                              color: theme.borderColor,
                              width: 2.0,
                            ),
                          ),
                          labelStyle: TextStyle(
                            color: theme.textColor,
                          ),
                        ),
                        style: TextStyle(color: theme.textColor),
                      ),
                      SizedBox(height: 20.0),
                      TextField(
                        controller: commentController,
                        decoration: InputDecoration(
                          labelText: 'Введите описание',
                          filled: true,
                          fillColor: transformColor(theme.accentColor),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                            borderSide: BorderSide(
                              width: 1.0,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                            borderSide: BorderSide(
                              width: 2.0,
                            ),
                          )
                        ),
                        maxLines: null,
                        minLines: 3,
                      ),
                      SizedBox(height: 10.0),
                      TextButton(
                        onPressed: () async {
                          final DateTime? picked = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime.now(),
                            lastDate: DateTime(2101),
                          );
                          if (picked != null) {
                            setState(() {
                              selectedDate = picked;
                            });
                            dataTextController.setText('${DateFormat('yyyy-MM-dd').format(selectedDate!)}');
                          }
                        },
                        child: ValueListenableBuilder<String>(
                          valueListenable: dataTextController.textNotifier,
                          builder: (context, buttonText, _) {
                            return Text(buttonText);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    nameController.clear();
                    commentController.clear();
                    selectedDate = null;
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
                            dateTime: selectedDate,
                            task: widget.task))
                        : widget.parentBloc is RootTaskBloc
                            ? widget.parentBloc.add(
                                CorrectingRootTaskChildEvent(
                                    parentUid: widget.parentUid,
                                    name: taskName,
                                    comment: taskComment,
                                    dateTime: selectedDate,
                                    task: widget.task))
                            : widget.parentBloc.add(CorrectingSubtaskChildEvent(
                                parentUid: widget.parentUid,
                                name: taskName,
                                comment: taskComment,
                                dateTime: selectedDate,
                                task: widget.task));

                    nameController.clear();
                    commentController.clear();
                    selectedDate = null;
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
