part of 'subtask_bloc.dart';

class SubtaskState {}

class SubtaskStateInitial extends SubtaskState {}

class CloseSubtaskChildrenState extends SubtaskState {}

class ShowSubtaskChildrenState extends SubtaskState {
  ShowSubtaskChildrenState(
      {required this.children,
      required this.activeChildUid});
  final List<Task> children;
  final String activeChildUid;
}

class EndChangeOrderSubtaskChildrenState extends SubtaskState {
  EndChangeOrderSubtaskChildrenState({required this.children});
  final List<Task> children;
}
