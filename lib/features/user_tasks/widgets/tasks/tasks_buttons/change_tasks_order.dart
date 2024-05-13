import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meine_wunschliste/domain/models/models.dart';
import 'package:meine_wunschliste/features/user_tasks/blocs/blocs.dart';

class ChangeTasksOrderButton extends StatefulWidget {
  const ChangeTasksOrderButton(
      {required this.task, required this.bloc, super.key});

  final Task task;
  final Bloc bloc;

  @override
  ChangeTasksOrderButtonState createState() => ChangeTasksOrderButtonState();
}

class ChangeTasksOrderButtonState extends State<ChangeTasksOrderButton> {
  final TextEditingController textController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return SizedBox(
      height: 50,
      child: IconButton(
        icon: const Icon(Icons.numbers),
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              
              return AlertDialog(
                  title: Container(
                      child: Row(children: [
                    IconButton(
                        onPressed: () {
                          widget.bloc is RootTaskBloc
                          ? widget.bloc.add(EndChangeRootTaskOrderChildrenEvent(
                              children: widget.bloc.state.children,
                              parentUid: widget.task.uid))
                          :widget.bloc.add(EndChangeSubtaskOrderChildrenEvent(
                              children: widget.bloc.state.children,
                              parentUid: widget.task.uid));
                          Navigator.of(context).pop();
                        },
                        icon: const Icon(Icons.edit_note)),
                    IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: const Icon(Icons.close))
                  ])),
                  content: Container(
                    height: screenSize.height * 0.8,
                    width: screenSize.width * 0.9,
                    child: ReorderableListView.builder(
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) {
                        final task = widget.bloc.state.children[index];
                        return Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.0),
                            color: Color(0xFFFFFF).withOpacity(0.5),
                          ),
                          height: screenSize.height * 0.09,
                          width: screenSize.width * 0.87,
                          margin: EdgeInsets.only(
                              bottom: screenSize.height * 0.013),
                          key: ValueKey(task.uid),
                          child: Text(task.name),
                        );
                      },
                      itemCount: widget.bloc.state.children.length,
                      onReorder: (oldIndex, newIndex) {
                        if (newIndex > oldIndex) {
                          newIndex -= 1;
                        }
                        final Task topTask =
                            widget.bloc.state.children.removeAt(oldIndex);
                        widget.bloc.state.children.insert(newIndex, topTask);
                      },
                      proxyDecorator: (Widget child, int index,
                          Animation<double> animation) {
                        return Material(
                          color: Colors.transparent,
                          child: child,
                        );
                      },
                    ),
                  ));
            },
          );
        },
      ),
    );
  }
}
