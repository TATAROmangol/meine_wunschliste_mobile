part of 'tasks_bloc.dart';

class TasksEvent {}

class ShowRootTasksEvent extends TasksEvent {}

class AddRootTaskEvent extends TasksEvent {
  AddRootTaskEvent({required this.name});
  final String name;
}

<<<<<<< HEAD
class ChangeOrderRootTaskEvent extends TasksEvent {
  ChangeOrderRootTaskEvent({required this.tasks});
=======
class ChangeOrderTopTaskEvent extends TasksEvent {
  ChangeOrderTopTaskEvent({required this.tasks});
>>>>>>> cf26426b94106fce844d75a22f05f36bcd2a5583
  final List<Task> tasks;
}
