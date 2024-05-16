import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meine_wunschliste/features/user_tasks/blocs/blocs.dart';

class AddFolderButton extends StatefulWidget {
  const AddFolderButton({super.key});

  @override
  AddFolderButtonState createState() => AddFolderButtonState();
}

class AddFolderButtonState extends State<AddFolderButton> {
  final TextEditingController textController = TextEditingController();

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final foldersBloc = BlocProvider.of<FoldersBloc>(context);
    final tasksTreeBloc = BlocProvider.of<TasksTreesBloc>(context);
    return GestureDetector(
      child: const Icon(Icons.folder_copy_outlined),
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Добавить папку'),
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
                      foldersBloc.add(AddFolderEvent(name: itemName));
                      foldersBloc.stream.listen((state) {
                        if (state is ShowFoldersState) {
                          tasksTreeBloc.add(ShowTasksTreesEvent());
                        }
                      });
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
    );
  }
}
