import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meine_wunschliste/features/user_tasks/blocs/folders_bloc/folders_bloc.dart';
import 'package:meine_wunschliste/features/user_tasks/blocs/root_tasks_bloc/root_tasks_bloc.dart';

class AddFolderWidget extends StatefulWidget {
  const AddFolderWidget({super.key});

  @override
  _AddFolderWidgetState createState() => _AddFolderWidgetState();
}

class _AddFolderWidgetState extends State<AddFolderWidget> {
  final TextEditingController textController = TextEditingController();

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final foldersBloc = BlocProvider.of<FoldersBloc>(context);
    final tasksBloc = BlocProvider.of<RootTasksBloc>(context);
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
                          tasksBloc.add(ShowRootTasksEvent());
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
