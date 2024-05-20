import 'package:flutter/material.dart';
import 'package:meine_wunschliste/domain/models/models.dart';

class Comment extends StatelessWidget {
  const Comment({required this.task, super.key});

  final Task task;

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return Padding(
        padding: EdgeInsets.all(screenSize.width * 0.05),
        child: Text(task.comment));
  }
}
