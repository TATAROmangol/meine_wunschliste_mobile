import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:meine_wunschliste/domain/models/models.dart';
import 'package:meine_wunschliste/domain/repository.dart';

part 'tasks_event.dart';
part 'tasks_state.dart';

class TasksBloc extends Bloc<TasksEvent, TasksState> {
  TasksBloc() : super(TasksStateInitial()) {
    on<ShowRootTasksEvent>((event, emit) async {
      try {
        final List<Task> tasks = await repository.getRootTasks();
        emit(ShowRootTasksState(tasks: tasks));
      } catch (e) {
        emit(ShowRootTasksState(tasks: []));
      }
    });
    on<AddRootTaskEvent>((event, emit) async {
      repository.addRootTask(event.name);
      add(ShowRootTasksEvent());
    });
    on<ChangeOrderRootTaskEvent>((event, emit) async {
      repository.changeRootTasksOrder(event.tasks);
      add(ShowRootTasksEvent());
    });
  }
  final Repository repository = GetIt.I.get<Repository>();
}
