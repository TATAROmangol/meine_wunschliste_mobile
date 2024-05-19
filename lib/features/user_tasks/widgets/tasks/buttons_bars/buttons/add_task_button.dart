import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meine_wunschliste/domain/models/models.dart';
import 'package:meine_wunschliste/features/user_tasks/blocs/blocs.dart';

class AddChildTaskButton extends StatefulWidget {
  const AddChildTaskButton(
      {required this.currentBloc, required this.task, super.key});

  final Bloc currentBloc;
  final Task task;

  @override
  AddChildTaskButtonState createState() => AddChildTaskButtonState();
}

class AddChildTaskButtonState extends State<AddChildTaskButton> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController commentController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return SizedBox(
      height: 50,
      child: IconButton(
        icon: const Icon(Icons.add),
        onPressed: () {
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
                            labelText: 'Введите название'),
                      ),
                      TextField(
                        controller: commentController,
                        decoration: const InputDecoration(
                            labelText: 'Введите описание'),
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
                      if (taskName.isNotEmpty) {
                        widget.currentBloc is RootTaskBloc
                            ? widget.currentBloc.add(AddRootTaskChildEvent(
                                name: taskName,
                                comment: taskComment,
                                parentUid: widget.task.uid))
                            : widget.currentBloc.add(AddSubtaskChildEvent(
                                name: taskName,
                                comment: taskComment,
                                parentUid: widget.task.uid));
                      }
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
      ),
    );
  }
}
