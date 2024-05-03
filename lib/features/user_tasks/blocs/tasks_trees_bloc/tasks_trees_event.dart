part of 'tasks_trees_bloc.dart';

class TasksTreesEvent {}

class ShowTasksTreesEvent extends TasksTreesEvent {}

class AddTasksTreeEvent extends TasksTreesEvent {
  AddTasksTreeEvent({required this.name});
  final String name;
}

class ChangeOrderTasksTreesEvent extends TasksTreesEvent {
  ChangeOrderTasksTreesEvent({required this.tasks});
  final List<Task> tasks;
}
