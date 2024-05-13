part of 'tasks_trees_bloc.dart';

class TasksTreesEvent {}

class ShowTasksTreesEvent extends TasksTreesEvent {
  ShowTasksTreesEvent({this.activeChildUid = ''});
  final String activeChildUid;
}

class AddTasksTreeEvent extends TasksTreesEvent {
  AddTasksTreeEvent({required this.name});
  final String name;
}

class ChangeOrderTasksTreesEvent extends TasksTreesEvent {
  ChangeOrderTasksTreesEvent({required this.children});
  final List<Task> children;
}

class DeleteTasksTreeChildEvent extends TasksTreesEvent {
  DeleteTasksTreeChildEvent({required this.task});
  final Task task;
}
