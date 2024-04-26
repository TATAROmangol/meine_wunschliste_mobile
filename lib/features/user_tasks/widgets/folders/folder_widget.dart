import 'package:flutter/material.dart';
import 'package:meine_wunschliste/domain/models/models.dart';

class FolderWidget extends StatelessWidget {
  const FolderWidget({required this.folder, required this.last, super.key});

  final Folder folder;
  final bool last;

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return Container(
      margin: last != true
          ? const EdgeInsets.only(right: 3)
          : const EdgeInsets.all(0),
      padding: const EdgeInsets.symmetric(horizontal: 5),
      height: screenSize.height * 0.04,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(15),
          bottomRight: Radius.circular(15),
        ),
        color: Color(0xFFEEA434),
      ),
      child: Center(
        child: TextButton(
          onPressed: () {
          },
          child: Text(folder.name),
        ),
      ),
    );
  }
}
