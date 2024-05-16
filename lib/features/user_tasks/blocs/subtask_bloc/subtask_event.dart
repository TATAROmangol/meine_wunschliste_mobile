part of 'subtask_bloc.dart';

class SubtaskEvent {}

class CloseSubtaskChildEvent extends SubtaskEvent {}

class ShowSubtaskChildrenEvent extends SubtaskEvent {
  ShowSubtaskChildrenEvent({required this.parentUid, this.activeChildUid = ''});
  final String parentUid;
  final String activeChildUid;
}

class EndChangeSubtaskOrderChildrenEvent extends SubtaskEvent {
  EndChangeSubtaskOrderChildrenEvent(
      {required this.children, required this.parentUid});
  final List<Task> children;
  final String parentUid;
}

class AddSubtaskChildEvent extends SubtaskEvent {
  AddSubtaskChildEvent(
      {required this.name, required this.comment, required this.parentUid});
  final String name;
  final String comment;
  final String parentUid;
}

class CorrectingSubtaskChildEvent extends SubtaskEvent {
  CorrectingSubtaskChildEvent({
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

class DeleteSubtaskChildEvent extends SubtaskEvent {
  DeleteSubtaskChildEvent({required this.parentUid, required this.task});
  final String parentUid;
  final Task task;
}
