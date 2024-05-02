part of 'tasks_bloc.dart';

class TasksState {}

class TasksStateInitial extends TasksState {}

class ShowRootTasksState extends TasksState {
  ShowRootTasksState({required this.tasks});

  final List<Task> tasks;
}
