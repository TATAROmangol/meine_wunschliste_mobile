import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:meine_wunschliste/domain/models/models.dart';
import 'package:meine_wunschliste/domain/models/steps.dart';
import 'package:meine_wunschliste/domain/repository.dart';

part 'subtasks_event.dart';
part 'subtasks_state.dart';

class SubtasksBloc extends Bloc<SubtasksEvent, SubtasksState> {
  SubtasksBloc() : super(SubtasksStateInitial()) {
    on<ShowSubtasksEvent>((event, emit) async {
      final tasks = await repository.getTasks(Steps.subtask, event.parentUid);
      emit(ShowSubtasksState(tasks: tasks));
    });
  }
  final Repository repository = GetIt.I.get<Repository>();
}