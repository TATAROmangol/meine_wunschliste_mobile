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
  AddRootTaskChildEvent({required this.name, required this.parentUid});
  final String name;
  final String parentUid;
}

class DeleteRootTaskEvent extends RootTaskEvent {
  DeleteRootTaskEvent({required this.parentUid, required this.task});
  final String parentUid;
  final Task task;
}

class RenameTaskEvent extends RootTaskEvent {
  RenameTaskEvent({
    required this.newName,
    required this.order,
    required this.parentUid,
  });
  final String newName;
  final int order;
  final String parentUid;
}
