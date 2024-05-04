part of 'subtask_bloc.dart';

class SubtaskEvent {}

class ShowSubtaskChildrenEvent extends SubtaskEvent {
  ShowSubtaskChildrenEvent({required this.parentUid});
  final String parentUid;
}

class AddSubtaskChildEvent extends SubtaskEvent{
  AddSubtaskChildEvent({required this.name, required this.parentUid});
  final String name;
  final String parentUid;
}
