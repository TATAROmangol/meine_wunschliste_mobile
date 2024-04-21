import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:meine_wunschliste/domain/models/enum/enum.dart';
import 'package:meine_wunschliste/domain/models/models.dart';

class TaskTreeViev extends StatefulWidget {
  const TaskTreeViev({required this.task, super.key});

  final TaskTree task;

  @override
  State<StatefulWidget> createState() {
    return _TaskTreeVievState(task: task);
  }
}

class _TaskTreeVievState extends State<TaskTreeViev> {
  _TaskTreeVievState({required this.task});

  final TaskTree task;
  bool _showChildren = false;

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return Column(
      children: [
        Container(
          height: screenSize.height * 0.09,
          width: (task.step == Levels.top)
              ? screenSize.width * 0.91
              : (task.step == Levels.center)
                  ? screenSize.width * 0.87
                  : screenSize.width * 0.84,
          margin: EdgeInsets.only(bottom: screenSize.height * 0.013),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: (task.step == Levels.top)
                ? const Color(0x70FFFFFF)
                : (task.step == Levels.center)
                    ? const Color(0x70FFF4E5)
                    : const Color(0x70FFE0C3),
          ),
          child: TextButton(
            child: Text(task.name),
            onPressed: () {
              setState(
                () {
                  _showChildren = !_showChildren;
                },
              );
            },
          ),
        ),
        if (_showChildren) TaskChildrenViev(task: task)
      ],
    );
  }
}

class TaskChildrenViev extends StatelessWidget {
  TaskChildrenViev({required this.task, Key? key}) : super(key: key);

  final TaskTree task;

  @override
  Widget build(BuildContext context) {
    final items = task.children;
    final Size screenSize = MediaQuery.of(context).size;

    return Container(
      height: screenSize.height * 0.5, // Установите желаемую высоту
      child: ReorderableListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          final taskChild = items[index];
          return TaskTreeViev(key: ValueKey(taskChild.name), task: taskChild);
        },
        itemCount: items.length,
        onReorder: (oldIndex, newIndex) {
          if (newIndex > oldIndex) {
            newIndex -= 1;
          }
          final TaskTree taskChild = items.removeAt(oldIndex);
          items.insert(newIndex, taskChild);
        },
        proxyDecorator: (Widget child, int index, Animation<double> animation) {
          return Material(
            color: Colors.transparent,
            child: child,
          );
        },
      ),
    );
  }
}
