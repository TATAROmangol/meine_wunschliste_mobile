import 'package:flutter/material.dart';
import 'package:meine_wunschliste/domain/models/models.dart';
import 'package:meine_wunschliste/features/user_tasks/blocs/blocs.dart';

class DeleteTaskButton extends StatefulWidget {
  const DeleteTaskButton({required this.bloc, required this.task, super.key});

  final bloc;
  final Task task;

  @override
  DeleteTaskButtonState createState() => DeleteTaskButtonState();
}

class DeleteTaskButtonState extends State<DeleteTaskButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: IconButton(
        icon: const Icon(Icons.delete),
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Вы уверенны?'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Отмена'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      widget.bloc
                          .add(DeleteTasksTreeChildEvent(task: widget.task));
                      Navigator.of(context).pop();
                    },
                    child: const Text('Удалить'),
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
