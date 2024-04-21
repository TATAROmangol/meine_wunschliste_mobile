import 'package:flutter/material.dart';
import 'package:meine_wunschliste/domain/models/folder.dart';

class FolderViev extends StatelessWidget {
  const FolderViev({required this.folder, super.key});

  final Folder folder;

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 3),
      height: screenSize.height * 0.04,
      width: screenSize.width * 0.3,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(15),
          bottomRight: Radius.circular(15),
        ),
        color: Color(0xFFEEA434),
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
