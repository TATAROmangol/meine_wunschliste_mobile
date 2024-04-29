import 'package:flutter/material.dart';
import 'package:meine_wunschliste/domain/models/models.dart';

class TaskWidget extends StatefulWidget {
  TaskWidget({required this.task, super.key});

  final Task task;

  @override
  _TaskWidgetState createState() => _TaskWidgetState(task: task);
}

class _TaskWidgetState extends State<TaskWidget> {
  _TaskWidgetState({required this.task});
  final task;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
              height: 20,
              child: TextButton(
                child: Text(task.name),
                onPressed: () {},
              )),
          // ReorderableListView.builder(
          //   physics: const NeverScrollableScrollPhysics(),
          //   scrollDirection: Axis.vertical,
          //   itemBuilder: (context, index) {
          //     final folder = folders[index];
          //     return ;
          //   },
          //   itemCount: folders.length,
          //   onReorder: (oldIndex, newIndex) {
          //     if (newIndex > oldIndex) {
          //       newIndex -= 1;
          //     }
          //     final Folder folderNavigation = folders.removeAt(oldIndex);
          //     folders.insert(newIndex, folderNavigation);

          //     foldersBloc.add(ChangeOrderFolderEvent(folders: folders));
          //   },
          //   proxyDecorator:
          //       (Widget child, int index, Animation<double> animation) {
          //     return Material(
          //       color: Colors.transparent,
          //       child: child,
          //     );
          //   },
          // ),
        ],
      ),
    );
  }
}
