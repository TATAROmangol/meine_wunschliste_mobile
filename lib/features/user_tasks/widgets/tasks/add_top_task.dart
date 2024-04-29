import 'package:flutter/material.dart';
import 'package:meine_wunschliste/features/user_tasks/blocs/tasks_bloc/tasks_bloc.dart';

class AddTopTask extends StatefulWidget {
  const AddTopTask({required this.tasksBloc, super.key});

  final TasksBloc tasksBloc;

  @override
  _AddTopTaskState createState() =>
      _AddTopTaskState(tasksBloc: tasksBloc);
}

class _AddTopTaskState extends State<AddTopTask> {
  _AddTopTaskState({required this.tasksBloc});
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
              tasksBloc.add(AddTopTaskEvent(name: itemName));
            }
            Navigator.of(context).pop();
            print('add $itemName');
          },
          child: const Text('Добавить'),
        ),
      ],
    );
  }
}
