import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meine_wunschliste/domain/models/models.dart';
import 'package:meine_wunschliste/features/tasks_and_folders/blocs/blocs.dart';
import 'package:meine_wunschliste/features/tasks_and_folders/user_tasks_folders/widgets/widgets.dart';

class CompleteTaskTreeView extends StatefulWidget {
  const CompleteTaskTreeView({super.key});

  @override
  CompleteTaskTreeViewState createState() => CompleteTaskTreeViewState();
}

class CompleteTaskTreeViewState extends State<CompleteTaskTreeView> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<TasksTreesBloc>(context).add(ShowTasksTreesEvent());
  }

  List<Widget> getRootTasksWidgets(
      ShowTasksTreesState state, TasksTreesBloc tasksTreesBloc) {
    return state.children.map(
      (e) {
        var isActive = state.activeChildUid == e.uid;
        var parentUid = state.parentUid;
        return BlocProvider<RootTaskBloc>(
          key: ValueKey(e.uid),
          create: (context) => RootTaskBloc(),
          child: BlocBuilder<RootTaskBloc, RootTaskState>(
            key: ValueKey(e.uid),
            builder: (context, state) {
              return RootTaskWidget(
                task: e,
                parentUid: parentUid,
                isActive: isActive,
                currentBloc: BlocProvider.of<RootTaskBloc>(context),
                parentBloc: tasksTreesBloc,
              );
            },
          ),
        );
      },
    ).toList();
  }

  @override
  Widget build(BuildContext context) {
    final tasksTreesBloc = BlocProvider.of<TasksTreesBloc>(context);

    return BlocBuilder<TasksTreesBloc, TasksTreesState>(
      bloc: tasksTreesBloc,
      builder: (context, state) {
        if (state is ShowTasksTreesState) {
          return Flexible(
            child: Column(
              children: state.children.map(
                (e) {
                  var isActive = state.activeChildUid == e.uid;
                  var parentUid = state.parentUid;
                  return BlocProvider<RootTaskBloc>(
                    create: (context) => RootTaskBloc(),
                    child: BlocBuilder<RootTaskBloc, RootTaskState>(
                      key: ValueKey(e.uid),
                      builder: (context, state) {
                        return RootTaskWidget(
                          task: e,
                          parentUid: parentUid,
                          isActive: isActive,
                          currentBloc: BlocProvider.of<RootTaskBloc>(context),
                          parentBloc: tasksTreesBloc,
                        );
                      },
                    ),
                  );
                },
              ).toList(),
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
