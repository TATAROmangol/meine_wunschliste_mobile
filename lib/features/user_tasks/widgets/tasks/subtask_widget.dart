import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meine_wunschliste/domain/models/models.dart';
import 'package:meine_wunschliste/features/user_tasks/blocs/blocs.dart';
import 'package:meine_wunschliste/features/user_tasks/widgets/tasks/comment.dart';
import 'package:meine_wunschliste/features/user_tasks/widgets/tasks/more_buttons_widget.dart';
import 'package:meine_wunschliste/features/user_tasks/widgets/widgets.dart';

class SubtaskWidget extends StatefulWidget {
  const SubtaskWidget(
      {required this.task,
      required this.parentUid,
      required this.isActive,
      required this.currentBloc,
      required this.parentBloc,
      super.key});

  final Task task;
  final String parentUid;
  final bool isActive;
  final SubtaskBloc currentBloc;
  final RootTaskBloc parentBloc;

  @override
  SubtaskWidgetState createState() => SubtaskWidgetState();
}

class SubtaskWidgetState extends State<SubtaskWidget> {
  bool watchMoreButtons = false;

  bool showComment = false;

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return BlocListener<RootTaskBloc, RootTaskState>(
      bloc: widget.parentBloc,
      listener: (context, state) {
        if (state is ShowRootTaskChildrenState) {
          if (state.activeChildUid == widget.task.uid) {
            widget.currentBloc
                .add(ShowSubtaskChildrenEvent(parentUid: widget.task.uid));
          } else {
            widget.currentBloc.add(CloseSubtaskChildEvent());
            watchMoreButtons = false;
          }
        }
      },
      child: BlocBuilder<SubtaskBloc, SubtaskState>(
        bloc: widget.currentBloc,
        builder: (context, state) {
          if (state is ShowSubtaskChildrenState && state.activeChildUid != '') {
            watchMoreButtons = false;
          }
          return Column(children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                color: Color(0xFFF4E5).withOpacity(0.5),
              ),
              height: screenSize.height * 0.08,
              width: screenSize.width * 0.87,
              margin: EdgeInsets.only(bottom: screenSize.height * 0.013),
              child: Row(
                children: [
                  Expanded(
                    child: TextButton(
                        onPressed: () {
                          widget.isActive
                              ? widget.parentBloc.add(ShowRootTaskChildrenEvent(
                                  parentUid: widget.parentUid))
                              : widget.parentBloc.add(ShowRootTaskChildrenEvent(
                                  parentUid: widget.parentUid,
                                  activeChildUid: widget.task.uid));
                              showComment = !showComment;
                        },
                        child: Text(widget.task.name)),
                  ),
                  Container(
                      width: 50,
                      height: 50,
                      child: widget.isActive
                          ? IconButton(
                              onPressed: () {
                                setState(() {
                                  watchMoreButtons = !watchMoreButtons;
                                  widget.currentBloc.add(
                                      ShowSubtaskChildrenEvent(
                                          parentUid: widget.task.uid));
                                });
                              },
                              icon: const Icon(Icons.more))
                          : Container())
                ],
              ),
            ),
            if(showComment)
            Comment(task: widget.task),
            
            if (watchMoreButtons )
              MoreButtonsWidget(
                  parentUid: widget.parentUid,
                  task: widget.task,
                  parentBloc: widget.parentBloc,
                  currentBloc: widget.currentBloc),
            if (state is ShowSubtaskChildrenState)
              Column(
                children: state.children.map(
                  (e) {
                    var isActive = state.activeChildUid == e.uid;
                    return BlocProvider<SubSubtaskBloc>(
                      key: ValueKey(e.uid),
                      create: (context) => SubSubtaskBloc(),
                      child: BlocBuilder<SubSubtaskBloc, SubSubtaskState>(
                        builder: (context, state) {
                          return SubSubtaskWidget(
                            task: e,
                            parentUid: widget.task.uid,
                            isActive: isActive,
                            currentBloc:
                                BlocProvider.of<SubSubtaskBloc>(context),
                            parentBloc: widget.currentBloc,
                          );
                        },
                      ),
                    );
                  },
                ).toList(),
              ),
          ]);
        },
      ),
    );
  }
}
