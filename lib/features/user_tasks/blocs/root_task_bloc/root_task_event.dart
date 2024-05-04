part of 'root_task_bloc.dart';

class RootTaskEvent {}

class ShowRootTaskChildrenEvent extends RootTaskEvent {
  ShowRootTaskChildrenEvent({required this.parentUid});
  final String parentUid;
}

class AddRootTaskChildEvent extends RootTaskEvent {
  AddRootTaskChildEvent({required this.name, required this.parentUid});
  final String name;
  final String parentUid;
}
