import 'package:flutter/material.dart';
import 'package:meine_wunschliste/presentation/widgets/micro_components/micro_components.dart';
import '../../../domain/models/models.dart';

class TaskTreeListViev extends StatelessWidget {
  TaskTreeListViev({super.key});

  final List<TaskTree> items = TaskInFolderList().children;

  @override
  Widget build(BuildContext context) {
    //final List<TaskTree> tasks = TaskTreeList().tasks;

    return Expanded(
      child: ReorderableListView.builder(
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          final taskChild = items[index];
          return TaskTreeViev(key: ValueKey(taskChild.name), task: taskChild);
        },
        itemCount: items.length,
        onReorder: (oldIndex, newIndex) {
          if (newIndex > oldIndex) {
            newIndex -= 1;
          }
          final TaskTree taskChild = items.removeAt(oldIndex);
          items.insert(newIndex, taskChild);
        },
        proxyDecorator: (Widget child, int index, Animation<double> animation) {
          return Material(
            color: Colors.transparent,
            child: child,
          );
        },
      ),
    );
  }
}
