import 'package:flutter/material.dart';
import 'package:meine_wunschliste/domain/models/models.dart';

class Comment extends StatelessWidget {
  const Comment({required this.task, super.key});

  final Task task;
  
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(task.comment));
  }
}
