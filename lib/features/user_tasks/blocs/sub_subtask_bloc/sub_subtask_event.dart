part of 'sub_subtask_bloc.dart';

class SubSubtaskEvent {}

class DeleteSubSubtaskEvent extends SubSubtaskEvent {
  DeleteSubSubtaskEvent(
      {required this.parentBloc, required this.parentUid, required this.task});
  final Bloc parentBloc;
  final String parentUid;
  final Task task;
}