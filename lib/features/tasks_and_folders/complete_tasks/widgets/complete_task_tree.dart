import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meine_wunschliste/features/tasks_and_folders/blocs/blocs.dart';
import 'package:meine_wunschliste/features/tasks_and_folders/complete_tasks/widgets/widgets.dart';

class CompleteTaskTreeView extends StatefulWidget {
  const CompleteTaskTreeView({required this.listenBloc, super.key});

  final listenBloc;

  @override
  CompleteTaskTreeViewState createState() => CompleteTaskTreeViewState();
}

class CompleteTaskTreeViewState extends State<CompleteTaskTreeView> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<TasksTreesBloc>(context).add(ShowCompleteTasksTreesEvent());
  }

  @override
  Widget build(BuildContext context) {
    final tasksTreesBloc = BlocProvider.of<TasksTreesBloc>(context);

    return BlocListener<TasksTreesBloc, TasksTreesState>(
      bloc: widget.listenBloc,
      listener: (context, state) {
        if (state is ReloadStatisticRootState) {
          tasksTreesBloc.add(ShowCompleteTasksTreesEvent());
        }
      },
      child: BlocBuilder<TasksTreesBloc, TasksTreesState>(
        bloc: tasksTreesBloc,
        builder: (context, state) {
          if (state is ShowCompleteTasksTreesState) {
            return Expanded(
              child: ListView.builder(
                itemCount: state.children.length,
                itemBuilder: (context, index) {
                  var e = state.children[index];
                  var isActive = state.activeChildUid == e.uid;
                  return BlocProvider<RootTaskBloc>(
                    create: (context) => RootTaskBloc(),
                    child: BlocBuilder<RootTaskBloc, RootTaskState>(
                      key: ValueKey(e.uid),
                      builder: (context, state) {
                        return CompleteRootTaskWidget(
                          task: e,
                          isActive: isActive,
                          currentBloc: BlocProvider.of<RootTaskBloc>(context),
                          parentBloc: tasksTreesBloc,
                        );
                      },
                    ),
                  );
                },
              ),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
