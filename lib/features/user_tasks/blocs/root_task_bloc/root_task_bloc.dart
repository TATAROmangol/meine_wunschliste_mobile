import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:meine_wunschliste/domain/models/models.dart';
import 'package:meine_wunschliste/domain/models/steps.dart';
import 'package:meine_wunschliste/domain/repository.dart';

part 'root_task_event.dart';
part 'root_task_state.dart';

class RootTaskBloc extends Bloc<RootTaskEvent, RootTaskState> {
  RootTaskBloc() : super(RootTaskStateInitial()) {
    on<ShowRootTaskChildrenEvent>((event, emit) async {
      var childrens = await repository.getTasks(Steps.subtask, event.parentUid);
      emit(ShowRootTaskChildrensState(childrens: childrens));
    });
    on<AddRootTaskChildEvent>((event, emit) async {
      repository.addTask(Steps.subtask, event.parentUid, event.name);
      add(ShowRootTaskChildrenEvent(parentUid: event.parentUid));
    });
  }
  final Repository repository = GetIt.I.get<Repository>();
}
