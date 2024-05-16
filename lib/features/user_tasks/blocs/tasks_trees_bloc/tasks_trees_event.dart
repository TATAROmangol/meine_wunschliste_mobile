part of 'tasks_trees_bloc.dart';

class TasksTreesEvent {}

class ShowTasksTreesEvent extends TasksTreesEvent {
  ShowTasksTreesEvent({this.activeChildUid = ''});
  final String activeChildUid;
}

class AddTasksTreeEvent extends TasksTreesEvent {
  AddTasksTreeEvent({required this.name, required this.comment});
  final String name;
  final String comment;
}

class CorrectingTasksTreeChildEvent extends TasksTreesEvent {
  CorrectingTasksTreeChildEvent({
    required this.name,
    required this.comment,
    required this.task,
    required this.parentUid,
  });
  final String name;
  final String comment;
  final Task task;
  final String parentUid;
}

class ChangeOrderTasksTreesEvent extends TasksTreesEvent {
  ChangeOrderTasksTreesEvent({required this.children});
  final List<Task> children;
}

class DeleteTasksTreeChildEvent extends TasksTreesEvent {
  DeleteTasksTreeChildEvent({required this.task});
  final Task task;
}
