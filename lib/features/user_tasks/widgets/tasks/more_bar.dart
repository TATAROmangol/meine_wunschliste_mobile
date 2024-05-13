import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meine_wunschliste/domain/models/models.dart';
import 'package:meine_wunschliste/features/user_tasks/blocs/blocs.dart';
import 'package:meine_wunschliste/features/user_tasks/widgets/widgets.dart';

class MainBar extends StatefulWidget {
  const MainBar({required this.currentBloc, required this.currentTask, super.key});

  final Bloc currentBloc;
  final Task currentTask;

  @override
  MainBarState createState() => MainBarState();
}

class MainBarState extends State<MainBar> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        AddTaskButton(bloc: widget.currentBloc, task: widget.currentTask)
      ],
    );
  }
}
