import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:meine_wunschliste/domain/models/models.dart';
import 'package:meine_wunschliste/repository/repository.dart';

class FolderWidget extends StatelessWidget {
  FolderWidget(
      {required this.folder,
      required this.last,
      required this.active,
      super.key});

  final Folder folder;
  final bool last;
  final String active;
  final Repository repository = GetIt.I.get<Repository>();

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return (folder.uid == active)
        ? Container(
            margin: last != true
                ? const EdgeInsets.only(right: 3)
                : const EdgeInsets.all(0),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(15),
                bottomRight: Radius.circular(15),
              ),
              color: Color(0xFFFF9648),
              border: Border(
                left: BorderSide(
                  color: Color.fromRGBO(0, 0, 0, 0.5),
                  width: 1.0,
                ),
                right: BorderSide(
                  color: Color.fromRGBO(0, 0, 0, 0.5),
                  width: 1.0,
                ),
                bottom: BorderSide(
                  color: Color.fromRGBO(0, 0, 0, 0.5),
                  width: 1.0,
                ),
              ),
            ),
            child: Center(
                child: TextButton(onPressed: () {}, child: Text(folder.name))))
        : Container(
            margin: last != true
                ? const EdgeInsets.only(right: 3)
                : const EdgeInsets.all(0),
            padding: const EdgeInsets.symmetric(horizontal: 5),
            height: screenSize.height * 0.04,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(15),
                bottomRight: Radius.circular(15),
              ),
              color: Color(0xFFFFB26A),
              border: Border.all(color: Color.fromRGBO(0, 0, 0, 0.5), width: 1),
            ),
            child: Center(
              child: TextButton(
                onPressed: () {},
                child: Text(folder.name),
              ),
            ),
          );
  }
}
