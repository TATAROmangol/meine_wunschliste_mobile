import 'package:flutter/material.dart';
import 'package:meine_wunschliste/domain/models/models.dart';
import 'package:meine_wunschliste/presentation/widgets/user_tasks_viev/folder_viev.dart';


class FolderListViev extends StatelessWidget {
  FolderListViev({super.key});

  final List<Folder> items = FolderList().children;

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return Container(
      margin:EdgeInsets.only(bottom: screenSize.height * 0.02),
      height: screenSize.height * 0.04,
      child: ReorderableListView.builder(
        scrollDirection: Axis.horizontal,
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
