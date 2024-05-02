import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meine_wunschliste/features/user_tasks/blocs/folders_bloc/folders_bloc.dart';
import 'package:meine_wunschliste/features/user_tasks/blocs/tasks_bloc/tasks_bloc.dart';
import 'package:meine_wunschliste/features/user_tasks/widgets/folders/folders.dart';
import 'package:meine_wunschliste/domain/models/models.dart';

class FolderBar extends StatefulWidget {
  const FolderBar({super.key});

  @override
  _FolderBarState createState() => _FolderBarState();
}

class _FolderBarState extends State<FolderBar> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<FoldersBloc>(context).add(ShowFoldersEvent());
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final FoldersBloc foldersBloc = BlocProvider.of<FoldersBloc>(context);
<<<<<<< HEAD
=======
    final TasksBloc tasksBloc = BlocProvider.of<TasksBloc>(context);
>>>>>>> cf26426b94106fce844d75a22f05f36bcd2a5583

    return BlocBuilder<FoldersBloc, FoldersState>(builder: (context, state) {
      if (state is ShowFoldersState) {
        final folders = state.folders;
        return Container(
          margin: EdgeInsets.only(bottom: screenSize.height * 0.016),
          height: screenSize.height * 0.04,
          child: ReorderableListView.builder(
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              final folder = folders[index];
              return FolderWidget(
                  key: ValueKey(folder.uid),
                  folder: folder,
                  activeFolder: state.activeFolder,
<<<<<<< HEAD
=======
                  foldersBloc: foldersBloc,
                  tasksBloc: tasksBloc,
>>>>>>> cf26426b94106fce844d75a22f05f36bcd2a5583
                  last: index == folders.length - 1);
            },
            itemCount: folders.length,
            onReorder: (oldIndex, newIndex) {
              if (newIndex > oldIndex) {
                newIndex -= 1;
              }
              final Folder folderNavigation = folders.removeAt(oldIndex);
              folders.insert(newIndex, folderNavigation);

              foldersBloc.add(ChangeOrderFolderEvent(folders: folders));
            },
            proxyDecorator:
                (Widget child, int index, Animation<double> animation) {
              return Material(
                color: Colors.transparent,
                child: child,
              );
            },
          ),
        );
      }
      return const Text('blya');
    });
  }
}
