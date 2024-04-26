part of 'folders_bloc.dart';

class FoldersEvent {}

class ShowFoldersEvent extends FoldersEvent {}

class AddFolderEvent extends FoldersEvent {
  AddFolderEvent({required this.name});
  final String name;
}

class ChangeOrderFolderEvent extends FoldersEvent {
  ChangeOrderFolderEvent({required this.folders});

  final List<Folder> folders;
}
