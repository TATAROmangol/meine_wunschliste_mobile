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
      final children =
          await repository.getTasks(Steps.subtask, event.parentUid);
      emit(ShowRootTaskChildrenState(
          children: children,
          activeChildUid: event.activeChildUid,
          showMoreBar: children.isEmpty));
    });
    on<CloseRootTaskChildrenEvent>((event, emit) async {
      emit(CloseRootTaskChildrenState());
    });
    on<AddRootTaskChildEvent>((event, emit) async {
      repository.addTask(
          Steps.subtask, event.parentUid, event.name, event.comment);
      add(ShowRootTaskChildrenEvent(parentUid: event.parentUid));
    });
    on<EndChangeRootTaskOrderChildrenEvent>((event, emit) async {
      repository.changeTasksOrder(
          event.children, Steps.subtask, event.parentUid);
      add(ShowRootTaskChildrenEvent(parentUid: event.parentUid));
    });
    on<DeleteRootTaskChildEvent>((event, emit) async {
      repository.deleteTask(event.parentUid, Steps.subtask, event.task);
      add(ShowRootTaskChildrenEvent(parentUid: event.parentUid));
    });
    on<CorrectingRootTaskChildEvent>((event, emit) async {
      repository.correctingTask(event.parentUid, Steps.subtask, event.task,
          event.name, event.comment);
      add(ShowRootTaskChildrenEvent(parentUid: event.parentUid));
    });
  }
  final Repository repository = GetIt.I.get<Repository>();
}
