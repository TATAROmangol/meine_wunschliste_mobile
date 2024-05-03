part of 'subtasks_bloc.dart';

class SubtasksState{}

class SubtasksStateInitial extends SubtasksState{}

class ShowSubtasksState extends SubtasksState{
  ShowSubtasksState({required this.tasks});
  final List<Task> tasks;
}