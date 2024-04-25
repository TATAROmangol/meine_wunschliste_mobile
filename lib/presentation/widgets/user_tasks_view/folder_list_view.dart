import 'package:flutter/material.dart';
import 'package:meine_wunschliste/repository/repository.dart';
import 'package:meine_wunschliste/services/database.dart';
import 'package:meine_wunschliste/domain/models/models.dart';
import 'package:meine_wunschliste/presentation/widgets/user_tasks_view/user_tasks_view.dart';
import 'package:realm/realm.dart';

class FolderListView extends StatefulWidget {
  const FolderListView({required this.realmRepository, Key? key})
      : super(key: key);

  final Repository realmRepository;

  @override
  _FolderListViewState createState() => _FolderListViewState();
}

class _FolderListViewState extends State<FolderListView> {
  late List<FolderNavigation> foldersNavigation;

  @override
  void initState() {
    super.initState();
    foldersNavigation = [];
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: widget.realmRepository.getFoldersNavigatin(),
      builder: (context, snapshot) {
        final items = snapshot.data ?? [];
        foldersNavigation =
            items.map((item) => FolderNavigation.fromRepository(item)).toList();
        foldersNavigation.sort((a, b) => a.order.compareTo(b.order));

        final Size screenSize = MediaQuery.of(context).size;

        return Container(
          margin: EdgeInsets.only(bottom: screenSize.height * 0.02),
          height: screenSize.height * 0.04,
          child: ReorderableListView.builder(
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              final folder = foldersNavigation[index];
              return FolderNavigationView(
                  key: ValueKey(folder.name), folderNavigation: folder);
            },
            itemCount: foldersNavigation.length,
            onReorder: (oldIndex, newIndex) {
              if (newIndex > oldIndex) {
                newIndex -= 1;
              }
              setState(() {
                final FolderNavigation folderNavigation =
                    foldersNavigation.removeAt(oldIndex);
                foldersNavigation.insert(newIndex, folderNavigation);

                for (var i = 0; i < foldersNavigation.length; i++) {
                  widget.realmRepository
                      .updateFolderNavigationOrder(foldersNavigation[i], i);
                }
              });
            },
            proxyDecorator:
                (Widget child, int index, Animation<double> animation) {
              return Material(
                color: Colors.transparent,
                child: child,
              );
            },
          ),
        );
      },
    );
  }
}
