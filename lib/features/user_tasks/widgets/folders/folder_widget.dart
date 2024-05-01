import 'package:flutter/material.dart';
import 'package:meine_wunschliste/features/user_tasks/blocs/folders_bloc/folders_bloc.dart';
import 'package:meine_wunschliste/domain/models/models.dart';
import 'package:meine_wunschliste/features/user_tasks/blocs/tasks_bloc/tasks_bloc.dart';

class FolderWidget extends StatelessWidget {
  FolderWidget(
      {required this.folder,
      required this.last,
      required this.activeFolder,
      required this.foldersBloc,
      required this.tasksBloc,
      super.key});

  final Folder folder;
  final Folder? activeFolder;
  final bool last;
  final FoldersBloc foldersBloc;
  final TasksBloc tasksBloc;

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return (activeFolder != null && folder.uid == activeFolder!.uid)
        ? Container(
            margin: last != true
                ? const EdgeInsets.only(right: 3)
                : const EdgeInsets.all(0),
            padding: const EdgeInsets.symmetric(horizontal: 5),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(15),
                bottomRight: Radius.circular(15),
              ),
              color: Color(0xFFFF9648),
              border: Border(
                left: BorderSide(
                  color: Color.fromRGBO(0, 0, 0, 0.5),
                  width: 1.0,
                ),
                right: BorderSide(
                  color: Color.fromRGBO(0, 0, 0, 0.5),
                  width: 1.0,
                ),
                bottom: BorderSide(
                  color: Color.fromRGBO(0, 0, 0, 0.5),
                  width: 1.0,
                ),
              ),
            ),
            child: Center(
                child: TextButton(onPressed: () {}, child: Text(folder.name))))
        : Container(
            margin: last != true
                ? const EdgeInsets.only(right: 3)
                : const EdgeInsets.all(0),
            padding: const EdgeInsets.symmetric(horizontal: 5),
            height: screenSize.height * 0.04,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(15),
                bottomRight: Radius.circular(15),
              ),
              color: Color(0xFFFFB26A),
              border: Border.all(color: const Color.fromRGBO(0, 0, 0, 0.5), width: 1),
            ),
            child: Center(
              child: TextButton(
                onPressed: () {
                  foldersBloc.add(ChangeActiveFolder(folder: folder));
                  foldersBloc.stream.listen((state) {
                    if (state is ShowFoldersState) {
                      tasksBloc.add(ShowTopTasksEvent());
                    }
                  });
                },
                child: Text(folder.name),
              ),
            ),
          );
  }
}
