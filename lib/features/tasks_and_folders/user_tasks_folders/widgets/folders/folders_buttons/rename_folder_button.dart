import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meine_wunschliste/features/tasks_and_folders/blocs/blocs.dart';

class RenameActiveFolderButton extends StatefulWidget {
  const RenameActiveFolderButton({required this.currentName, super.key});

  final String currentName;

  @override
  RenameActiveFolderButtonState createState() =>
      RenameActiveFolderButtonState();
}

class RenameActiveFolderButtonState extends State<RenameActiveFolderButton> {
  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final TextEditingController textController =
        TextEditingController(text: widget.currentName);
    final foldersBloc = BlocProvider.of<FoldersBloc>(context);
    return GestureDetector(
      child: Container(
        height: screenSize.height * 0.04,
        width: screenSize.height * 0.04,
        child: Center(
          child: Image.asset(
            'assets/icons/redact.png',
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
              title: const Text('Переименовать папку'),
              content: TextField(
                controller: textController,
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
                    if (itemName != widget.currentName) {
                      foldersBloc.add(RenameActiveFolderEvent(name: itemName));
                    }

                    textController.clear();
                    Navigator.of(context).pop();
                  },
                  child: const Text('Переименовать'),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
