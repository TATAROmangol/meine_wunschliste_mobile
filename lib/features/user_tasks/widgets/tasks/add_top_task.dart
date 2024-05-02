import 'package:flutter/material.dart';
import 'package:meine_wunschliste/features/user_tasks/blocs/tasks_bloc/tasks_bloc.dart';

class AddRootTask extends StatefulWidget {
  const AddRootTask({required this.tasksBloc, super.key});

  final TasksBloc tasksBloc;

  @override
  _AddRootTaskState createState() => _AddRootTaskState(tasksBloc: tasksBloc);
}

class _AddRootTaskState extends State<AddRootTask> {
  _AddRootTaskState({required this.tasksBloc});
  final TextEditingController _textController = TextEditingController();
  final TasksBloc tasksBloc;

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Добавить Задачу'),
      content: TextField(
        controller: _textController,
        decoration: const InputDecoration(labelText: 'Введите название'),
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
            String itemName = _textController.text;
            if (itemName.isNotEmpty) {
              tasksBloc.add(AddRootTaskEvent(name: itemName));
            }
            Navigator.of(context).pop();
          },
          child: const Text('Добавить'),
        ),
      ],
    );
  }
}
