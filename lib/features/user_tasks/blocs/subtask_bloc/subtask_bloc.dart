import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:meine_wunschliste/domain/models/models.dart';
import 'package:meine_wunschliste/domain/models/steps.dart';
import 'package:meine_wunschliste/domain/repository.dart';
import 'package:meine_wunschliste/features/user_tasks/blocs/blocs.dart';

part 'subtask_event.dart';
part 'subtask_state.dart';

class SubtaskBloc extends Bloc<SubtaskEvent, SubtaskState> {
  SubtaskBloc() : super(SubtaskStateInitial()) {
    on<ShowSubtaskChildrenEvent>((event, emit) async {
      final children =
          await repository.getTasks(Steps.subSubtask, event.parentUid);

      emit(ShowSubtaskChildrenState(
          children: children, activeChildUid: event.activeChildUid));
    });
    on<CloseSubtaskChildEvent>((event, emit) async {
      emit(CloseSubtaskChildrenState());
    });
    on<AddSubtaskChildEvent>((event, emit) async {
      repository.addTask(
          Steps.subSubtask, event.parentUid, event.name, event.comment);
      add(ShowSubtaskChildrenEvent(parentUid: event.parentUid));
    });
    on<EndChangeSubtaskOrderChildrenEvent>((event, emit) async {
      repository.changeTasksOrder(
          event.children, Steps.subSubtask, event.parentUid);
      add(ShowSubtaskChildrenEvent(parentUid: event.parentUid));
    });
    on<CorrectingSubtaskChildEvent>((event, emit) async {
      repository.correctingTask(event.parentUid, Steps.subSubtask, event.task,
          event.name, event.comment);
      add(ShowSubtaskChildrenEvent(parentUid: event.parentUid));
    });
    on<DeleteSubtaskChildEvent>((event, emit) async {
      repository.deleteTask(event.parentUid, Steps.subSubtask, event.task);
      add(ShowSubtaskChildrenEvent(parentUid: event.parentUid));
    });
  }
  final Repository repository = GetIt.I.get<Repository>();
}
