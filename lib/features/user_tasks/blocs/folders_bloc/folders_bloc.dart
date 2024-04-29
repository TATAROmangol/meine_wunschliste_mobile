import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:meine_wunschliste/domain/models/models.dart';
import 'package:meine_wunschliste/domain/repository.dart';

part 'folders_event.dart';
part 'folders_state.dart';

class FoldersBloc extends Bloc<FoldersEvent, FoldersState> {
  FoldersBloc() : super(FoldersInitial()) {
    on<ShowFoldersEvent>((event, emit) async {
      final folders = await repository.getFolders();
      folders.sort((a, b) => b.order.compareTo(a.order));

      final activeFolder = await repository.getActiveFolder();
      emit(ShowFoldersState(folders: folders, activeFolder: activeFolder));
    });

    on<ChangeOrderFolderEvent>((event, emit) {
      for (var i = 0; i < event.folders.length; i++) {
        repository.updateFolderOrder(
            event.folders[i], event.folders.length - i - 1);
      }
      add(ShowFoldersEvent());
    });

    on<AddFolderEvent>((event, emit) async {
      repository.addFolder(event.name);
      add(ShowFoldersEvent());
    });

    on<ChangeActiveFolder>((event, emit) async {
      repository.changeActiveFolder(event.folder);
      add(ShowFoldersEvent());
    });
  }

  final Repository repository = GetIt.I.get<Repository>();
}