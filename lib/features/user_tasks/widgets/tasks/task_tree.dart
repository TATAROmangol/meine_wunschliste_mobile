import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meine_wunschliste/domain/models/models.dart';
import 'package:meine_wunschliste/features/user_tasks/blocs/tasks_bloc/tasks_bloc.dart';
import 'package:meine_wunschliste/features/user_tasks/widgets/widgets.dart';

class TaskTreeView extends StatefulWidget {
  @override
  _TaskTreeViewState createState() => _TaskTreeViewState();
}

class _TaskTreeViewState extends State<TaskTreeView> {

  @override
    void initState() {
      super.initState();
      BlocProvider.of<TasksBloc>(context).add(ShowTopTasksEvent());
    }

  @override
  Widget build(BuildContext context) {
    final TasksBloc tasksBloc = BlocProvider.of<TasksBloc>(context);

    return BlocBuilder<TasksBloc, TasksState>(
      builder: (context, state) {
        return Flexible(
          child: state is ShowTopTasksState
              ? ReorderableListView.builder(
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    final task = state.tasks[index];
                    return TaskWidget(key: ValueKey(task.uid), task: task);
                  },
                  itemCount: state.tasks.length,
                  onReorder: (oldIndex, newIndex) {
                    if (newIndex > oldIndex) {
                      newIndex -= 1;
                    }
                    final Task topTask =
                        state.tasks.removeAt(oldIndex);
                    state.tasks.insert(newIndex, topTask);

                    tasksBloc.add(ChangeOrderTopTaskEvent(tasks: state.tasks));
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
