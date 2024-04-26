import 'package:flutter/material.dart';

class AddFolderWidget extends StatefulWidget {
  const AddFolderWidget({super.key});

  @override
  _AddFolderWidgetState createState() =>
      _AddFolderWidgetState();
}

class _AddFolderWidgetState extends State<AddFolderWidget> {
  _AddFolderWidgetState();
  final TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Добавить элемент'),
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
          onPressed: () async {
            String itemName = _textController.text;
            //realmRepository.addFolder(itemName);
            Navigator.of(context).pop();
            print('add $itemName');
          },
          child: const Text('Добавить'),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }
}
