import 'package:flutter/material.dart';
import 'package:meine_wunschliste/domain/models/models.dart';

class Comment extends StatelessWidget {
  const Comment({required this.task, super.key});

  final Task task;
  
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      child: Text(task.comment));
  }
}
