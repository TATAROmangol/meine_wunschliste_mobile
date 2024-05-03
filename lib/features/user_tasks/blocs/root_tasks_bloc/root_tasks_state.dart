part of 'root_tasks_bloc.dart';

class RootTasksState {}

class RootTasksStateInitial extends RootTasksState {}

class ShowRootTasksState extends RootTasksState {
  ShowRootTasksState({required this.tasks});

  final List<Task> tasks;
}
