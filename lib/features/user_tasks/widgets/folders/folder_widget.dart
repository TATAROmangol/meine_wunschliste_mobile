import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meine_wunschliste/features/user_tasks/blocs/folders_bloc/folders_bloc.dart';
import 'package:meine_wunschliste/domain/models/models.dart';
import 'package:meine_wunschliste/features/user_tasks/blocs/tasks_bloc/tasks_bloc.dart';

class FolderWidget extends StatelessWidget {
  FolderWidget(
      {required this.folder,
      required this.last,
      required this.activeFolder,
<<<<<<< HEAD
=======
      required this.foldersBloc,
      required this.tasksBloc,
>>>>>>> cf26426b94106fce844d75a22f05f36bcd2a5583
      super.key});

  final Folder folder;
  final Folder? activeFolder;
  final bool last;
<<<<<<< HEAD
=======
  final FoldersBloc foldersBloc;
  final TasksBloc tasksBloc;
>>>>>>> cf26426b94106fce844d75a22f05f36bcd2a5583

  @override
  Widget build(BuildContext context) {
    final foldersBloc = BlocProvider.of<FoldersBloc>(context);
    final tasksBloc = BlocProvider.of<TasksBloc>(context);

    return Container(
      margin: last != true
          ? const EdgeInsets.only(right: 3)
          : const EdgeInsets.all(0),
      padding: const EdgeInsets.symmetric(horizontal: 5),
      decoration: (activeFolder != null && folder.uid == activeFolder!.uid)
          ? const BoxDecoration(
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
            )
          : BoxDecoration(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(15),
                bottomRight: Radius.circular(15),
              ),
<<<<<<< HEAD
              color: const Color(0xFFFFB26A),
              border: Border.all(
                  color: const Color.fromRGBO(0, 0, 0, 0.5), width: 1),
=======
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
>>>>>>> cf26426b94106fce844d75a22f05f36bcd2a5583
            ),
      child: Center(
        child: TextButton(
            onPressed: () {
              if (activeFolder != null && folder.uid != activeFolder!.uid) {
                foldersBloc.add(ChangeActiveFolder(folder: folder));
                foldersBloc.stream.listen((state) {
                  if (state is ShowFoldersState) {
                    tasksBloc.add(ShowRootTasksEvent());
                  }
                });
              }
            },
            child: Text(folder.name)),
      ),
    );
  }
}
