import 'package:flutter/material.dart';
import 'package:meine_wunschliste/features/user_tasks/blocs/folders_bloc/folders_bloc.dart';

class AddFolderWidget extends StatefulWidget {
  const AddFolderWidget({required this.foldersBloc, super.key});

  final FoldersBloc foldersBloc;

  @override
  _AddFolderWidgetState createState() =>
      _AddFolderWidgetState(foldersBloc: foldersBloc);
}

class _AddFolderWidgetState extends State<AddFolderWidget> {
  _AddFolderWidgetState({required this.foldersBloc});
  final TextEditingController _textController = TextEditingController();
  final FoldersBloc foldersBloc;

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Добавить папку'),
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
              foldersBloc.add(AddFolderEvent(name: itemName));
            }
            Navigator.of(context).pop();
          },
          child: const Text('Добавить'),
        ),
      ],
    );
  }
}
