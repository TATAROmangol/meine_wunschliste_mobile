part of 'subtask_bloc.dart';

class SubtaskState {}

class SubtaskStateInitial extends SubtaskState {}

class ShowSubtaskChildrenState extends SubtaskState {
  ShowSubtaskChildrenState({required this.childrens});
  final List<Task> childrens;
}
