part of 'subtasks_bloc.dart';

class SubtasksEvent{}

class ShowSubtasksEvent extends SubtasksEvent{
  ShowSubtasksEvent({required this.parentUid});
  final String parentUid;
}