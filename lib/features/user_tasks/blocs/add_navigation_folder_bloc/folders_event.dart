part of 'folders_bloc.dart';

class FoldersEvent {}

class ShowFoldersEvent extends FoldersEvent {}

class AddFolderNavigatinEvent extends FoldersEvent {}

class ChangeOrderFolderEvent extends FoldersEvent {
  ChangeOrderFolderEvent({required this.folders});

  final List<Folder> folders;
}
