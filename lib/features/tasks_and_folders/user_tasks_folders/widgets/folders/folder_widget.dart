import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meine_wunschliste/domain/models/models.dart';
import 'package:meine_wunschliste/features/tasks_and_folders/blocs/blocs.dart';
import 'package:meine_wunschliste/features/tasks_and_folders/user_tasks_folders/widgets/folders/folders_buttons/folders_buttons.dart';

class FolderWidget extends StatefulWidget {
  const FolderWidget({
    super.key,
    required this.folder,
    required this.last,
    required this.isActive,
  });

  final Folder folder;
  final bool isActive;
  final bool last;

  @override
  FolderWidgetState createState() => FolderWidgetState();
}

class FolderWidgetState extends State<FolderWidget> {
  bool showButtons = false;

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final foldersBloc = BlocProvider.of<FoldersBloc>(context);
    final tasksTreeBloc = BlocProvider.of<TasksTreesBloc>(context);
    if (!widget.isActive) {
      showButtons = false;
    }
    return BlocListener<FoldersBloc, FoldersState>(
      bloc: foldersBloc,
      listener: (context, state) {
        if (state is ShowFoldersState) {
          showButtons = false;
        }
      },
      child: GestureDetector(
        onVerticalDragUpdate: (details) {
          if (details.delta.dy > 0) {
            if (widget.isActive) {
              setState(() {
                showButtons = true;
              });
            }
          } else if (details.delta.dy < 0) {
            // свайп вверх
            setState(() {
              showButtons = false;
            });
          }
        },
        child: Container(
          constraints: BoxConstraints(
            minWidth: screenSize.width * 0.25,
          ),
          margin: const EdgeInsets.only(left: 3, right: 2),
          decoration: (widget.isActive)
              ? const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                  color: Color(0xFFFF9648),
                  border: Border(
                    left: BorderSide(
                      color: Color.fromRGBO(0, 0, 0, 1),
                      width: 1,
                    ),
                    right: BorderSide(
                      color: Color.fromRGBO(0, 0, 0, 1),
                      width: 1.5,
                    ),
                    bottom: BorderSide(
                      color: Color.fromRGBO(0, 0, 0, 1),
                      width: 1.5,
                    ),
                  ),
                )
              : const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                  color: const Color(0xFFFFB26A),
                  border: Border(
                    top: BorderSide(
                      color: Color.fromRGBO(0, 0, 0, 1),
                      width: 1,
                    ),
                    left: BorderSide(
                      color: Color.fromRGBO(0, 0, 0, 1),
                      width: 1,
                    ),
                    right: BorderSide(
                      color: Color.fromRGBO(0, 0, 0, 1),
                      width: 1,
                    ),
                    bottom: BorderSide(
                      color: Color.fromRGBO(0, 0, 0, 1),
                      width: 1,
                    ),
                  ),
                ),
          child: showButtons
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    RenameActiveFolderButton(currentName: widget.folder.name),
                    DeleteActiveFolderButton(currentBloc: foldersBloc)
                  ],
                )
              : TextButton(
                  onPressed: () {
                    if (!widget.isActive) {
                      foldersBloc
                          .add(ChangeActiveFolder(folder: widget.folder));
                      foldersBloc.stream.listen((state) {
                        if (state is ShowFoldersState) {
                          tasksTreeBloc
                              .add(ShowTasksTreesEvent(activeChildUid: ''));
                        }
                      });
                    }
                  },
                  child: Center(child: Text(widget.folder.name)),
                ),
        ),
      ),
    );
  }
}
