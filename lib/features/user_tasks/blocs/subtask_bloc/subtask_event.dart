part of 'subtask_bloc.dart';

class SubtaskEvent {}

class ShowSubtaskEvent extends SubtaskEvent {
  ShowSubtaskEvent({required this.parentUid});
  final String parentUid;
}
