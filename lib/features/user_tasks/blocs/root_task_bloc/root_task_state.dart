part of 'root_task_bloc.dart';

class RootTaskState {}

class RootTaskStateInitial extends RootTaskState {}

class ShowRootTaskChildrensState extends RootTaskState{
  ShowRootTaskChildrensState({required this.childrens});
  final List<Task> childrens;
}