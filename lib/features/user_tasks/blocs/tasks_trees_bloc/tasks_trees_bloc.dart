import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:meine_wunschliste/domain/models/models.dart';
import 'package:meine_wunschliste/domain/models/steps.dart';
import 'package:meine_wunschliste/domain/repository.dart';

part 'tasks_trees_event.dart';
part 'tasks_trees_state.dart';

class TasksTreesBloc extends Bloc<TasksTreesEvent, TasksTreesState> {
  TasksTreesBloc() : super(TasksTreeStatesInitial()) {
    on<ShowTasksTreesEvent>((event, emit) async {
      var acriveFolder = await repository.getActiveFolder();
      final List<Task> tasks = acriveFolder == null
          ? []
          : await repository.getTasks(Steps.rootTask, acriveFolder.uid);
      emit(ShowTasksTreesState(tasks: tasks));
    });
    on<AddTasksTreeEvent>((event, emit) async {
      var activeFolder = await repository.getActiveFolder();
      repository.addTask(Steps.rootTask, activeFolder!.uid, event.name);
      add(ShowTasksTreesEvent());
    });
    on<ChangeOrderTasksTreesEvent>((event, emit) async {
      var activeFolder = await repository.getActiveFolder();
      repository.changeTasksOrder(
          event.tasks, Steps.rootTask, activeFolder!.uid);
      add(ShowTasksTreesEvent());
    });
  }
  final Repository repository = GetIt.I.get<Repository>();
}
