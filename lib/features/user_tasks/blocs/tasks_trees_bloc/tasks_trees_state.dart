part of 'tasks_trees_bloc.dart';

class TasksTreesState {}

class TasksTreeStatesInitial extends TasksTreesState {}

class ShowTasksTreesState extends TasksTreesState {
  ShowTasksTreesState({required this.tasks});

  final List<Task> tasks;
}
