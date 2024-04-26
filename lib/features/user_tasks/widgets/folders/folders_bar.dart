import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meine_wunschliste/domain/models/models.dart';
import 'package:meine_wunschliste/features/user_tasks/blocs/add_navigation_folder_bloc/folders_bloc.dart';
import 'package:meine_wunschliste/features/user_tasks/widgets/folders/folders.dart';

class FolderBar extends StatefulWidget {
  FolderBar({super.key});

  @override
  _FolderBarState createState() => _FolderBarState();
}

class _FolderBarState extends State<FolderBar> {
  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final FoldersBloc _foldersBloc = BlocProvider.of<FoldersBloc>(context);
    _foldersBloc.add(ShowFoldersEvent());
    return BlocBuilder<FoldersBloc, FoldersState>(builder: (context, state) {
      if (state is ShowFolderState) {
        final folders = state.folders;
        return Container(
          margin: EdgeInsets.only(bottom: screenSize.height * 0.02),
          height: screenSize.height * 0.04,
          child: ReorderableListView.builder(
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              final folder = folders[index];
              return FolderWidget(
                  key: ValueKey(folder.uid),
                  active: state.uidActiveFolder,
                  folder: folder,
                  last: index == folders.length - 1);
            },
            itemCount: folders.length,
            onReorder: (oldIndex, newIndex) {
              if (newIndex > oldIndex) {
                newIndex -= 1;
              }
              final Folder folderNavigation = folders.removeAt(oldIndex);
              folders.insert(newIndex, folderNavigation);

              _foldersBloc.add(ChangeOrderFolderEvent(folders: folders));
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
      return Container();
    });
  }
}
