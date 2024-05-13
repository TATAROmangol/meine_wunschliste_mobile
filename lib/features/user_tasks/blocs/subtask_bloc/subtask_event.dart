part of 'subtask_bloc.dart';

class SubtaskEvent {}

class CloseSubtaskChildEvent extends SubtaskEvent {}

class ShowSubtaskChildrenEvent extends SubtaskEvent {
  ShowSubtaskChildrenEvent(
      {required this.parentUid, this.activeChildUid = ''});
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
  AddSubtaskChildEvent({required this.name, required this.parentUid});
  final String name;
  final String parentUid;
}

class DeleteSubtaskEvent extends SubtaskEvent {
  DeleteSubtaskEvent(
      {required this.parentBloc, required this.parentUid, required this.task});
  final Bloc parentBloc;
  final String parentUid;
  final Task task;
}
