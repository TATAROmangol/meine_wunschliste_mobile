part of 'tasks_bloc.dart';

class TasksEvent {}

class ShowRootTasksEvent extends TasksEvent {}

class AddRootTaskEvent extends TasksEvent {
  AddRootTaskEvent({required this.name});
  final String name;
}

class ChangeOrderRootTaskEvent extends TasksEvent {
  ChangeOrderRootTaskEvent({required this.tasks});
  final List<Task> tasks;
}
