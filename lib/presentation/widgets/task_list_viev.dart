import 'package:flutter/material.dart';
import 'package:meine_wunschliste/domain/models/folder.dart';

class TaskListViev extends StatelessWidget {
  TaskListViev({super.key});

  final List<Folder> items = FolderList().children;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: items.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(items[index].name),
          );
        },
      ),
    );
  }
}
