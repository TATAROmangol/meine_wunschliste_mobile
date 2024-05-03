part of 'subtask_bloc.dart';

class SubtaskState {}

class SubtaskStateInitial extends SubtaskState {}

class ShowSubtaskState extends SubtaskState {
  ShowSubtaskState({required this.tasks});
  final List<Task> tasks;
}
