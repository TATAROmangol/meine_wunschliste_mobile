import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meine_wunschliste/repository/repository.dart';

class AddFolderView extends StatefulWidget {
  const AddFolderView({required this.repository, super.key});

  final Repository repository;

  @override
  AddFolderViewState createState() =>
      AddFolderViewState(realmRepository: repository);
}

class AddFolderViewState extends State<AddFolderView> {
  AddFolderViewState({required this.realmRepository});
  final TextEditingController _textController = TextEditingController();

  final Repository realmRepository;

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
            realmRepository.addFolderNavigation(itemName);
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
