import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:meine_wunschliste/domain/models/models.dart';
import 'package:meine_wunschliste/domain/repository.dart';

part 'sub_subtask_event.dart';
part 'sub_subtask_state.dart';

class SubSubtaskBloc extends Bloc<SubSubtaskEvent, SubSubtaskState> {
  SubSubtaskBloc() : super(SubSubtaskStateInitial()) {
    on<DeleteSubSubtaskEvent>((event, emit) async {
      
    });
  }
  final Repository repository = GetIt.I.get<Repository>();
}
