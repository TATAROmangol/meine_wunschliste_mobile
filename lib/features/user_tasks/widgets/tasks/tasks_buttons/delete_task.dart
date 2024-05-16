import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meine_wunschliste/domain/models/models.dart';
import 'package:meine_wunschliste/features/user_tasks/blocs/blocs.dart';

class DeleteTaskButton extends StatefulWidget {
  const DeleteTaskButton(
      {required this.parentBloc,
      required this.task,
      required this.parentUid,
      super.key});

  final Bloc parentBloc;
  final Task task;
  final String parentUid;

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
                      widget.parentBloc is TasksTreesBloc
                          ? widget.parentBloc
                              .add(DeleteTasksTreeChildEvent(task: widget.task))
                          : widget.parentBloc is RootTaskBloc
                              ? widget.parentBloc.add(DeleteRootTaskChildEvent(
                                  parentUid: widget.parentUid,
                                  task: widget.task))
                              : widget.parentBloc.add(DeleteSubtaskChildEvent(
                                  parentUid: widget.parentUid,
                                  task: widget.task));
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
