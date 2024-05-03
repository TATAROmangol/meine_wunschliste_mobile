part of 'root_tasks_bloc.dart';

class RootTasksEvent {}

class ShowRootTasksEvent extends RootTasksEvent {}

class AddRootTaskEvent extends RootTasksEvent {
  AddRootTaskEvent({required this.name});
  final String name;
}

class ChangeOrderRootTaskEvent extends RootTasksEvent {
  ChangeOrderRootTaskEvent({required this.tasks});
  final List<Task> tasks;
}
