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
      acriveFolder == null
          ? emit(ShowTasksTreesState(
              activeChildUid: event.activeChildUid,
              parentUid: '',
              children: []))
          : emit(ShowTasksTreesState(
              activeChildUid: event.activeChildUid,
              parentUid: acriveFolder.uid,
              children:
                  await repository.getTasks(Steps.rootTask, acriveFolder.uid)));
    });
    on<AddTasksTreeEvent>((event, emit) async {
      var activeFolder = await repository.getActiveFolder();
      repository.addTask(
          Steps.rootTask, activeFolder!.uid, event.name, event.comment);
      add(ShowTasksTreesEvent());
    });
    on<ChangeOrderTasksTreesEvent>((event, emit) async {
      var activeFolder = await repository.getActiveFolder();
      repository.changeTasksOrder(
          event.children, Steps.rootTask, activeFolder!.uid);
      add(ShowTasksTreesEvent());
    });
    on<CorrectingTasksTreeChildEvent>((event, emit) async {
      repository.correctingTask(event.parentUid, Steps.rootTask, event.task,
          event.name, event.comment, event.task.isComplete);
      add(ShowTasksTreesEvent(activeChildUid: event.task.uid));
    });

    on<DeleteTasksTreeChildEvent>((event, emit) async {
      var activeFolder = await repository.getActiveFolder();
      repository.deleteTask(activeFolder!.uid, Steps.rootTask, event.task);
      add(ShowTasksTreesEvent());
    });

    on<CompleteTasksTreeChildEvent>((event, emit) async {
      var activeFolder = await repository.getActiveFolder();
      repository.correctingTask(activeFolder!.uid, Steps.rootTask, event.task,
          event.task.name, event.task.comment, true);
      add(ShowTasksTreesEvent(activeChildUid: event.task.uid));
    });
  }
  final Repository repository = GetIt.I.get<Repository>();
}
