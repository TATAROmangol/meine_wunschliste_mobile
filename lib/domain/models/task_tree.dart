import 'package:meine_wunschliste/domain/models/enum/enum.dart';

class TaskTree {
  TaskTree({
    required this.name,
    this.step = Levels.top,
    List<TaskTree>? children,
  }) : children = children ?? [];

  Levels step;
  String name;
  List<TaskTree> children;

  void addChildren(String shildName) {
    if (step == Levels.bottom) throw Exception('no steps');
    if (step == Levels.top) {
      children.add(TaskTree(name: shildName, step: Levels.bottom));
    } else {
      children.add(TaskTree(name: shildName, step: Levels.center));
    }
  }
}
