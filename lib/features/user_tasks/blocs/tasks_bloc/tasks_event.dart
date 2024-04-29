part of 'tasks_bloc.dart';

class TasksEvent {}

class ShowTopTasksEvent extends TasksEvent {}

class AddTopTaskEvent extends TasksEvent {
  AddTopTaskEvent({required this.name});
  final String name;
}

class ChangeAddTopTaskEvent extends TasksEvent {
  ChangeAddTopTaskEvent({required this.tasks});
  final List<Task> tasks;
}
