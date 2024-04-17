import 'package:flutter/material.dart';
import '../../domain/models/models.dart';
import 'widgets.dart';

class TaskListViev extends StatelessWidget {
  TaskListViev({super.key});

  final List<Folder> items = FolderList().children;

  @override
  Widget build(BuildContext context) {
    final List<TaskTree> tasks = TaskTreeList().tasks;

    return Expanded(
      child: ReorderableListView.builder(
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          final folder = items[index];
          return FolderViev(key: ValueKey(folder.name), folder: folder);
        },
        itemCount: items.length,
        onReorder: (oldIndex, newIndex) {
          if (newIndex > oldIndex) {
            newIndex -= 1;
          }
          final Folder folder = items.removeAt(oldIndex);
          items.insert(newIndex, folder);
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
