import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:meine_wunschliste/repository/repository.dart';

part 'tasks_event.dart';
part 'tasks_state.dart';

class TasksBloc extends Bloc<TasksEvent, TasksState> {
  TasksBloc() : super(TasksStateInitial()) {
    // on<>((event, emit) async {
      
    // });
    // on<>((event, emit) async {
      
    // });
  }
  final Repository repository = GetIt.I.get<Repository>();
}