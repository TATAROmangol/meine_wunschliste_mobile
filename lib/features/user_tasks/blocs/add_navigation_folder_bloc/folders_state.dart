part of 'folders_bloc.dart';

class FoldersState {}

class FoldersInitial extends FoldersState {
  final List<Folder> foldersNavigation = [];
}

class ShowFolderState extends FoldersState {
  ShowFolderState({required this.folders, required this.uidActiveFolder});

  final List<Folder> folders;
  final String uidActiveFolder;
}
