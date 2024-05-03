import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:meine_wunschliste/domain/repository.dart';

part 'sub_subtasks_event.dart';
part 'sub_subtasks_state.dart';

class SubSubtasksBloc extends Bloc<SubSubtasksEvent, SubSubtasksState> {
  SubSubtasksBloc() : super(SubSubtasksStateInitial()) {
    on<SubSubtasksEvent>((event, emit) async {
      
    });
  }
  final Repository repository = GetIt.I.get<Repository>();
}