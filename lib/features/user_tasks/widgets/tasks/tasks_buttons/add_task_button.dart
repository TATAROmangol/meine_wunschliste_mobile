import 'package:flutter/material.dart';
import 'package:meine_wunschliste/features/user_tasks/blocs/blocs.dart';
import 'package:meine_wunschliste/features/user_tasks/blocs/root_task_bloc/root_task_bloc.dart';

class AddTaskButton extends StatefulWidget {
  const AddTaskButton({required this.bloc, required this.parentUid, super.key});

  final bloc;
  final String parentUid;

  @override
  _AddTaskButtonState createState() => _AddTaskButtonState();
}

class _AddTaskButtonState extends State<AddTaskButton> {
  final TextEditingController textController = TextEditingController();

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                content: TextField(
                  controller: textController,
                  decoration:
                      const InputDecoration(labelText: 'Введите название'),
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
                      String itemName = textController.text;
                      if (itemName.isNotEmpty) {
                        widget.bloc is RootTaskBloc
                            ? widget.bloc.add(AddRootTaskChildEvent(
                                name: itemName, parentUid: widget.parentUid))
                            : widget.bloc.add(AddSubtaskChildEvent(
                                    name: itemName,
                                    parentUid: widget.parentUid));
                      }
                      textController.clear();
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
