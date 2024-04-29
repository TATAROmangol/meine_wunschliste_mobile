import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:meine_wunschliste/domain/models/models.dart';
import 'package:meine_wunschliste/domain/repository.dart';

part 'tasks_event.dart';
part 'tasks_state.dart';

class TasksBloc extends Bloc<TasksEvent, TasksState> {
  TasksBloc() : super(TasksStateInitial()) {
    on<ShowTopTasksEvent>((event, emit) async {
      final List<Task> tasks =
          await repository.getTopTasks();
      tasks.sort((a, b) => a.order.compareTo(b.order));
      emit(ShowTopTasksState(tasks: tasks));
    });
    on<AddTopTaskEvent>((event, emit) async {
      //repository.addTopTask(event.name);
      add(ShowTopTasksEvent());
    });
    
  }
  final Repository repository = GetIt.I.get<Repository>();
}
