import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:meine_wunschliste/domain/user_theme.dart';
import 'package:meine_wunschliste/features/tasks_and_folders/blocs/blocs.dart';

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
    final UserTheme theme = GetIt.I.get<UserTheme>();
    final Size screenSize = MediaQuery.of(context).size;
    final foldersBloc = BlocProvider.of<FoldersBloc>(context);
    final tasksTreeBloc = BlocProvider.of<TasksTreesBloc>(context);

    return GestureDetector(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          color: theme.accentColor,
        ),
        height: screenSize.height * 0.045,
        width: screenSize.height * 0.045,
        margin: const EdgeInsets.only(bottom: 5),
        child: Center(
          child: Image.asset(
            'assets/icons/add_category.png',
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
