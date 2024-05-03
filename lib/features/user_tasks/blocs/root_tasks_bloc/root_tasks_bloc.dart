import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:meine_wunschliste/domain/models/models.dart';
import 'package:meine_wunschliste/domain/models/steps.dart';
import 'package:meine_wunschliste/domain/repository.dart';

part 'root_tasks_event.dart';
part 'root_tasks_state.dart';

class RootTasksBloc extends Bloc<RootTasksEvent, RootTasksState> {
  RootTasksBloc() : super(RootTasksStateInitial()) {
    on<ShowRootTasksEvent>((event, emit) async {
      var acriveFolder = await repository.getActiveFolder();
      final List<Task> tasks = acriveFolder == null
          ? []
          : await repository.getTasks(Steps.rootTask, acriveFolder.uid);
      emit(ShowRootTasksState(tasks: tasks));
    });
    on<AddRootTaskEvent>((event, emit) async {
      var activeFolder = await repository.getActiveFolder();
      repository.addTask(Steps.rootTask, activeFolder!.uid, event.name);
      add(ShowRootTasksEvent());
    });
    on<ChangeOrderRootTaskEvent>((event, emit) async {
      repository.changeRootTasksOrder(event.tasks);
      add(ShowRootTasksEvent());
    });
  }
  final Repository repository = GetIt.I.get<Repository>();
}
