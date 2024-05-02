import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meine_wunschliste/features/user_tasks/blocs/folders_bloc/folders_bloc.dart';
import 'package:meine_wunschliste/features/user_tasks/blocs/tasks_bloc/tasks_bloc.dart';

class AddFolderWidget extends StatefulWidget {
<<<<<<< HEAD
  const AddFolderWidget({super.key});

  @override
  _AddFolderWidgetState createState() => _AddFolderWidgetState();
}

class _AddFolderWidgetState extends State<AddFolderWidget> {
  final TextEditingController textController = TextEditingController();
=======
  const AddFolderWidget(
      {required this.foldersBloc, required this.tasksBloc, super.key});

  final FoldersBloc foldersBloc;
  final TasksBloc tasksBloc;

  @override
  _AddFolderWidgetState createState() =>
      _AddFolderWidgetState(foldersBloc: foldersBloc, tasksBloc: tasksBloc);
}

class _AddFolderWidgetState extends State<AddFolderWidget> {
  _AddFolderWidgetState({required this.foldersBloc, required this.tasksBloc});
  final TextEditingController _textController = TextEditingController();
  final FoldersBloc foldersBloc;
  final TasksBloc tasksBloc;
>>>>>>> cf26426b94106fce844d75a22f05f36bcd2a5583

   @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
<<<<<<< HEAD
    final foldersBloc = BlocProvider.of<FoldersBloc>(context);
    final tasksBloc = BlocProvider.of<TasksBloc>(context);
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
=======
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
              foldersBloc.stream.listen((state) {
                if (state is ShowFoldersState) {
                  tasksBloc.add(ShowTopTasksEvent());
                }
              });
            }
            Navigator.of(context).pop();
>>>>>>> cf26426b94106fce844d75a22f05f36bcd2a5583
          },
        );
      },
    );
  }
}
