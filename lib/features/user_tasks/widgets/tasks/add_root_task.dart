import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meine_wunschliste/domain/models/steps.dart';
import 'package:meine_wunschliste/features/user_tasks/blocs/root_tasks_bloc/root_tasks_bloc.dart';

class AddRootTask extends StatefulWidget {
  const AddRootTask({super.key});

  @override
  _AddRootTaskState createState() => _AddRootTaskState();
}

class _AddRootTaskState extends State<AddRootTask> {
  final TextEditingController textController = TextEditingController();

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final tasksBloc = BlocProvider.of<RootTasksBloc>(context);
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
                        tasksBloc.add(AddRootTaskEvent(name: itemName));
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
