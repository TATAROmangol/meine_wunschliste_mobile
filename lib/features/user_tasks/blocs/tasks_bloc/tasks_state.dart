part of 'tasks_bloc.dart';

class TasksState {}

class TasksStateInitial extends TasksState {}

class ShowTopTasksState extends TasksState {
  ShowTopTasksState({required this.tasks});

  final List<Task> tasks;
}
