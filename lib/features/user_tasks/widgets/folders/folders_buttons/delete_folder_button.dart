import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meine_wunschliste/features/user_tasks/blocs/blocs.dart';

class DeleteActiveFolderButton extends StatefulWidget {
  const DeleteActiveFolderButton({required this.currentBloc, super.key});

  final Bloc currentBloc;

  @override
  DeleteActiveFolderButtonState createState() =>
      DeleteActiveFolderButtonState();
}

class DeleteActiveFolderButtonState extends State<DeleteActiveFolderButton> {
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
                      widget.currentBloc.add(DeleteActiveFolderEvent());
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
