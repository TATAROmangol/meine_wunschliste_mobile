part of 'root_task_bloc.dart';

class RootTaskState {}

class RootTaskStateInitial extends RootTaskState {}

class CloseRootTaskChildrenState extends RootTaskState {}

class ShowRootTaskChildrenState extends RootTaskState {
  ShowRootTaskChildrenState(
      {required this.children,
      required this.activeChildUid,
      required this.showMoreBar});
  final List<Task> children;
  final String activeChildUid;
  final bool showMoreBar;
}

class EndChangeOrderRootTaskChildrenState extends RootTaskState {
  EndChangeOrderRootTaskChildrenState({required this.children});
  final List<Task> children;
}
