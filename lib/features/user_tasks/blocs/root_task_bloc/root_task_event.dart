part of 'root_task_bloc.dart';

class RootTaskEvent {}

class CloseRootTaskChildrenEvent extends RootTaskEvent {}

class ShowRootTaskChildrenEvent extends RootTaskEvent {
  ShowRootTaskChildrenEvent(
      {required this.parentUid, this.activeChildUid = ''});
  final String parentUid;
  final String activeChildUid;
}

class EndChangeRootTaskOrderChildrenEvent extends RootTaskEvent {
  EndChangeRootTaskOrderChildrenEvent(
      {required this.children, required this.parentUid});
  final List<Task> children;
  final String parentUid;
}

class AddRootTaskChildEvent extends RootTaskEvent {
  AddRootTaskChildEvent(
      {required this.name, required this.comment, required this.parentUid});
  final String name;
  final String comment;
  final String parentUid;
}

class DeleteRootTaskChildEvent extends RootTaskEvent {
  DeleteRootTaskChildEvent({required this.parentUid, required this.task});
  final String parentUid;
  final Task task;
}

class CorrectingRootTaskChildEvent extends RootTaskEvent {
  CorrectingRootTaskChildEvent({
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
