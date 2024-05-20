import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:meine_wunschliste/domain/models/models.dart';
import 'package:meine_wunschliste/domain/models/steps.dart';
import 'package:meine_wunschliste/domain/repository.dart';

part 'root_task_event.dart';
part 'root_task_state.dart';

class RootTaskBloc extends Bloc<RootTaskEvent, RootTaskState> {
  RootTaskBloc() : super(RootTaskStateInitial()) {
    on<ShowRootTaskEvent>((event, emit) async {
      final children =
          await repository.getTasks(Steps.subtask, event.parentUid);
      var childrenComplete = children.isEmpty
          ? true
          : repository.getStateTasks(Steps.subtask, event.parentUid);
      emit(ShowRootTaskState(
          children: children,
          activeChildUid: event.activeChildUid,
          childrenComplete: childrenComplete));
    });
    on<CloseRootTaskEvent>((event, emit) async {
      emit(CloseRootTaskChildrenState());
    });
    on<AddRootTaskChildEvent>((event, emit) async {
      repository.addTask(
          Steps.subtask, event.parentUid, event.name, event.comment);
      add(ShowRootTaskEvent(parentUid: event.parentUid));
    });
    on<EndChangeRootTaskOrderChildrenEvent>((event, emit) async {
      repository.changeTasksOrder(
          event.children, Steps.subtask, event.parentUid);
      add(ShowRootTaskEvent(parentUid: event.parentUid));
    });
    on<DeleteRootTaskChildEvent>((event, emit) async {
      repository.deleteTask(event.parentUid, Steps.subtask, event.task);
      add(ShowRootTaskEvent(parentUid: event.parentUid));
    });
    on<CorrectingRootTaskChildEvent>((event, emit) async {
      repository.correctingTask(event.parentUid, Steps.subtask, event.task,
          event.name, event.comment, event.task.isComplete);
      add(ShowRootTaskEvent(
          parentUid: event.parentUid, activeChildUid: event.task.uid));
    });
    on<CompleteRootTaskChildEvent>((event, emit) async {
      await repository.correctingTask(event.parentUid, Steps.subtask,
          event.task, event.task.name, event.task.comment, true);
      await repository.reloadCompleteChildren(event.parentUid, Steps.subtask);
      add(ShowRootTaskEvent(
          parentUid: event.parentUid, activeChildUid: event.task.uid));
    });
    on<UncompleteRootTaskChildEvent>((event, emit) async {
      await repository.correctingTask(event.parentUid, Steps.subtask,
          event.task, event.task.name, event.task.comment, false);
      await repository.reloadCompleteChildren(event.parentUid, Steps.subtask);
      add(ShowRootTaskEvent(
          parentUid: event.parentUid, activeChildUid: event.task.uid));
    });
  }
  final Repository repository = GetIt.I.get<Repository>();
}
