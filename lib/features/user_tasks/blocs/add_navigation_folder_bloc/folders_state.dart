part of 'folders_bloc.dart';

class FoldersState {}

class AddFolderNavigationInitial extends FoldersState {
  final List<Folder> foldersNavigation = [];
}

class ShowFolderState extends FoldersState {
  ShowFolderState({required this.folders});

  final List<Folder> folders;
}
