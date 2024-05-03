import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meine_wunschliste/domain/models/models.dart';
import 'package:meine_wunschliste/features/user_tasks/blocs/root_tasks_bloc/root_tasks_bloc.dart';
import 'package:meine_wunschliste/features/user_tasks/blocs/subtasks_bloc/subtasks_bloc.dart';
import 'package:meine_wunschliste/features/user_tasks/widgets/widgets.dart';

import '../../blocs/sub_subtasks_bloc/sub_subtasks_bloc.dart';

class TaskTreeView extends StatefulWidget {
  @override
  _TaskTreeViewState createState() => _TaskTreeViewState();
}

class _TaskTreeViewState extends State<TaskTreeView> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<RootTasksBloc>(context).add(ShowRootTasksEvent());
  }

  @override
  Widget build(BuildContext context) {
    final RootTasksBloc rootTasksBloc = BlocProvider.of<RootTasksBloc>(context);
    final subtasksBloc = BlocProvider.of<SubtasksBloc>(context);
    final subSubtasksBloc = BlocProvider.of<SubSubtasksBloc>(context);

    return BlocBuilder<RootTasksBloc, RootTasksState>(
      builder: (context, state) {
        return Flexible(
          child: state is ShowRootTasksState
              ? ReorderableListView.builder(
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    final task = state.tasks[index];
                    return RootTaskWidget(
                      key: ValueKey(task.uid),
                      task: task,
                      subSubtasksBloc: subSubtasksBloc,
                      subtasksBloc: subtasksBloc,
                    );
                  },
                  itemCount: state.tasks.length,
                  onReorder: (oldIndex, newIndex) {
                    if (newIndex > oldIndex) {
                      newIndex -= 1;
                    }
                    final Task topTask = state.tasks.removeAt(oldIndex);
                    state.tasks.insert(newIndex, topTask);

                    rootTasksBloc.add(ChangeOrderRootTaskEvent(tasks: state.tasks));
                  },
                  proxyDecorator:
                      (Widget child, int index, Animation<double> animation) {
                    return Material(
                      color: Colors.transparent,
                      child: child,
                    );
                  },
                )
              : Container(
                  height: 100, color: Colors.white, child: Text('hello')),
        );
      },
    );
  }
}
