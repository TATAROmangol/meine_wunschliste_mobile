import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meine_wunschliste/features/tasks_and_folders/blocs/blocs.dart';

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
    final Size screenSize = MediaQuery.of(context).size;
    return GestureDetector(
      child: Container(
        height: screenSize.height * 0.04,
        width: screenSize.height * 0.04,
        child: Center(
          child: Image.asset(
            'assets/icons/delete.png',
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
        },);
  }
}