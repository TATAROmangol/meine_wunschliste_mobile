import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:meine_wunschliste/domain/models/models.dart';
import 'package:meine_wunschliste/domain/models/steps.dart';
import 'package:meine_wunschliste/domain/repository.dart';

part 'subtask_event.dart';
part 'subtask_state.dart';

class SubtaskBloc extends Bloc<SubtaskEvent, SubtaskState> {
  SubtaskBloc() : super(SubtaskStateInitial()) {
    on<ShowSubtaskEvent>((event, emit) async {
      final tasks = await repository.getTasks(Steps.subtask, event.parentUid);
      emit(ShowSubtaskState(tasks: tasks));
    });
  }
  final Repository repository = GetIt.I.get<Repository>();
}
