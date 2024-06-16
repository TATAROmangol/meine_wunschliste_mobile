import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meine_wunschliste/domain/repository_models/realm_models.dart';
import 'package:meine_wunschliste/features/tasks_and_folders/blocs/blocs.dart';

class ChangeChildrenTasksOrderButton extends StatefulWidget {
  const ChangeChildrenTasksOrderButton({
    required this.task,
    required this.currentBloc,
    super.key,
  });

  final Task task;
  final Bloc currentBloc;

  @override
  ChangeChildrenTasksOrderButtonState createState() =>
      ChangeChildrenTasksOrderButtonState();
}

class ChangeChildrenTasksOrderButtonState
    extends State<ChangeChildrenTasksOrderButton> {
  final TextEditingController textController = TextEditingController();

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return GestureDetector(
      child: SizedBox(
        width: screenSize.height * 0.04,
        height: screenSize.height * 0.04,
        child: Center(
          child: Image.asset(
            'assets/icons/order.png',
            width: screenSize.height * 0.04,
            height: screenSize.height * 0.04,
            fit: BoxFit.contain,
          ),
        ),
      ),
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      if (widget.currentBloc is RootTaskBloc) {
                        widget.currentBloc.add(
                          EndChangeRootTaskOrderChildrenEvent(
                            children: widget.currentBloc.state.children,
                            parentUid: widget.task.uid,
                          ),
                        );
                      } else {
                        widget.currentBloc.add(
                          EndChangeSubtaskOrderChildrenEvent(
                            children: widget.currentBloc.state.children,
                            parentUid: widget.task.uid,
                          ),
                        );
                      }
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(Icons.edit_note),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),
              content: Container(
                height: screenSize.height * 0.8,
                width: screenSize.width * 0.9,
                child: ReorderableListView.builder(
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    final task = widget.currentBloc.state.children[index];
                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                        color: const Color(0xFFFFFF).withOpacity(0.5),
                      ),
                      height: screenSize.height * 0.09,
                      width: screenSize.width * 0.87,
                      margin:
                          EdgeInsets.only(bottom: screenSize.height * 0.013),
                      key: ValueKey(task.uid),
                      child: Text(task.name),
                    );
                  },
                  itemCount: widget.currentBloc.state.children.length,
                  onReorder: (oldIndex, newIndex) {
                    if (newIndex > oldIndex) {
                      newIndex -= 1;
                    }
                    final Task topTask =
                        widget.currentBloc.state.children.removeAt(oldIndex);
                    widget.currentBloc.state.children.insert(newIndex, topTask);
                  },
                  proxyDecorator:
                      (Widget child, int index, Animation<double> animation) {
                    return Material(
                      color: Colors.transparent,
                      child: child,
                    );
                  },
                ),
              ),
            );
          },
        );
      },
    );
  }
}
