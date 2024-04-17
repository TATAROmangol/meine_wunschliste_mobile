import 'package:flutter/material.dart';
import 'package:meine_wunschliste/domain/models/models.dart';

class FolderListViev extends StatelessWidget {
  FolderListViev({super.key});

  final List<Folder> items = FolderList().children;

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return SizedBox(
      height: screenSize.height * 0.04,
      child: ReorderableListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final folder = items[index];
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 3),
            height: screenSize.height * 0.04,
            width: screenSize.width * 0.3,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10.0),
                bottomRight: Radius.circular(10.0),
              ),
              color: Color(0xFFEEA434),
            ),
            key: Key(folder.name),
            child: TextButton(
              onPressed: () {},
              child: Text(folder.name),
            ),
          );
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
