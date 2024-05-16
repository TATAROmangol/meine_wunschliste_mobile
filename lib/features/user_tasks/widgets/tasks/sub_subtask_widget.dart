import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meine_wunschliste/domain/models/models.dart';
import 'package:meine_wunschliste/features/user_tasks/blocs/blocs.dart';
import 'package:meine_wunschliste/features/user_tasks/widgets/tasks/more_buttons_widget.dart';

class SubSubtaskWidget extends StatefulWidget {
  const SubSubtaskWidget(
      {required this.task,
      required this.parentUid,
      required this.isActive,
      required this.currentBloc,
      required this.parentBloc,
      super.key});

  final Task task;
  final String parentUid;
  final bool isActive;
  final SubSubtaskBloc currentBloc;
  final SubtaskBloc parentBloc;

  @override
  SubSubtaskWidgetState createState() => SubSubtaskWidgetState();
}

class SubSubtaskWidgetState extends State<SubSubtaskWidget> {
  bool watchMoreButtons = false;

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return BlocListener<SubtaskBloc, SubtaskState>(
      bloc: widget.parentBloc,
      listener: (context, state) {
        if (state is ShowSubtaskChildrenState) {
          if (state.activeChildUid != widget.task.uid) {
            watchMoreButtons = false;
          } else {
            watchMoreButtons = true;
          }
        }
      },
      child: BlocBuilder<SubSubtaskBloc, SubSubtaskState>(
        bloc: widget.currentBloc,
        builder: (context, state) {
          return Column(children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                color: Color(0xFFE0C3).withOpacity(0.5),
              ),
              height: screenSize.height * 0.07,
              width: screenSize.width * 0.84,
              margin: EdgeInsets.only(bottom: screenSize.height * 0.013),
              child: TextButton(
                  onPressed: () {
                    widget.isActive
                        ? widget.parentBloc.add(ShowSubtaskChildrenEvent(
                            parentUid: widget.parentUid))
                        : widget.parentBloc.add(ShowSubtaskChildrenEvent(
                            parentUid: widget.parentUid,
                            activeChildUid: widget.task.uid));

                  },
                  child: Text(widget.task.name)),
            ),
            if (watchMoreButtons)
              MoreButtonsWidget(
                  parentUid: widget.parentUid,
                  task: widget.task,
                  parentBloc: widget.parentBloc,
                  currentBloc: widget.currentBloc)
          ]);
        },
      ),
    );
  }
}
