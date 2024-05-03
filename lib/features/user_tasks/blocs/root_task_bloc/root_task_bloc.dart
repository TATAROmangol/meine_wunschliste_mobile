import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:meine_wunschliste/domain/repository.dart';

part 'root_task_event.dart';
part 'root_task_state.dart';

class RootTaskBloc extends Bloc<RootTaskEvent, RootTaskState> {
  RootTaskBloc() : super(RootTaskStateInitial()) {}
  final Repository repository = GetIt.I.get<Repository>();
}
