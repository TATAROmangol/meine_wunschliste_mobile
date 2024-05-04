import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meine_wunschliste/features/user_tasks/blocs/blocs.dart';

class AddTasksTree extends StatefulWidget {
  const AddTasksTree({super.key});

  @override
  _AddTasksTreeState createState() => _AddTasksTreeState();
}

class _AddTasksTreeState extends State<AddTasksTree> {
  final TextEditingController textController = TextEditingController();

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final tasksTreeBloc = BlocProvider.of<TasksTreesBloc>(context);
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
                        tasksTreeBloc.add(AddTasksTreeEvent(name: itemName));
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
