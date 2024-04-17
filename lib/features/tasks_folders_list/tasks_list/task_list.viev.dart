import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meine_wunschliste/features/tasks_folders_list/folder_list/folder.dart';

class TaskListViev extends StatelessWidget {
  
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
            }));
  }
}
