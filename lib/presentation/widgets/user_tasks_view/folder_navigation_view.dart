import 'package:flutter/material.dart';
import 'package:meine_wunschliste/domain/models/models.dart';

class FolderNavigationView extends StatelessWidget {
  const FolderNavigationView({required this.folderNavigation, super.key});

  final FolderNavigation folderNavigation;

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 3),
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
        child: GestureDetector(
          onTap: () {},
          child: Text(folderNavigation.name),
        ),
      ),
    );
  }
}
