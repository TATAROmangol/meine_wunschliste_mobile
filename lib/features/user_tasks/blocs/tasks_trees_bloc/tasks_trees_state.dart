part of 'tasks_trees_bloc.dart';

class TasksTreesState {}

class TasksTreeStatesInitial extends TasksTreesState {}

class CloseChildrenTasksTreesState extends TasksTreesState{
  CloseChildrenTasksTreesState({required this.children});
  final List<Task> children;
}

class OrderTasksTreesState extends TasksTreesState{
  OrderTasksTreesState({required this.children});
  final List<Task> children;
}

class ShowTasksTreesState extends TasksTreesState {
  ShowTasksTreesState({required this.children,
      required this.parentUid,
      required this.activeChildUid});
  final List<Task> children;
  final String parentUid;
  final String activeChildUid;
}
