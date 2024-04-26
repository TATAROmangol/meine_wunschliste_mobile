import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:meine_wunschliste/domain/models/models.dart';
import 'package:meine_wunschliste/repository/repository.dart';

part 'folders_event.dart';
part 'folders_state.dart';

class FoldersBloc extends Bloc<FoldersEvent, FoldersState> {
  FoldersBloc() : super(AddFolderNavigationInitial()) {
    on<ShowFoldersEvent>((event, emit) async {
      final items = await repository.getFolders();
      final foldersNavigation =
          items.map((item) => Folder.fromRepository(item)).toList();
      foldersNavigation.sort((a, b) => a.order.compareTo(b.order));
      emit(ShowFolderState(folders: foldersNavigation));
    });
    on<ChangeOrderFolderEvent>((event, emit) async {
      for (var i = 0; i < event.folders.length; i++) {
        repository.updateFolderOrder(event.folders[i], i);
      }
      emit(ShowFolderState(folders: event.folders));
    });
  }
  final Repository repository = GetIt.I.get<Repository>();
}
