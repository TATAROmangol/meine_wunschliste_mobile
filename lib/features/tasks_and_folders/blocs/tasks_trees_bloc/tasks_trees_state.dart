part of 'tasks_trees_bloc.dart';

class TasksTreesState {}

class TasksTreeStatesInitial extends TasksTreesState {}

class CloseTasksTreesState extends TasksTreesState {
  CloseTasksTreesState({required this.children});
  final List<Task> children;
}

class OrderTasksTreesState extends TasksTreesState {
  OrderTasksTreesState({required this.children});
  final List<Task> children;
}

class ShowTasksTreesState extends TasksTreesState {
  ShowTasksTreesState(
      {required this.children,
      required this.parentUid,
      required this.activeChildUid});
  final List<Task> children;
  final String parentUid;
  final String activeChildUid;
}

class ShowCompleteTasksTreesState extends TasksTreesState {
  ShowCompleteTasksTreesState(
      {required this.children, required this.activeChildUid});
  final List<Task> children;
  final String activeChildUid;
}

class ReloadStatisticRootState extends TasksTreesState {}

class CloseCompleteTasksTreesState extends TasksTreesState {
  CloseCompleteTasksTreesState({required this.children});
  final List<Task> children;
}
