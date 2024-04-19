import 'package:meine_wunschliste/domain/models/enum/enum.dart';
import 'package:meine_wunschliste/domain/models/task_tree.dart';

class Folder {
  Folder(this.name);

  String name;
  List<TaskTree> tasks = [];

  void add(String nameTask) {
    tasks.add(TaskTree(name: nameTask));
  }
}

class TaskInFolderList {
  List<TaskTree> children = [
    TaskTree(name: 'me', children: [
      TaskTree(name: 'text', step: Levels.center),
      TaskTree(name: 'task', step: Levels.center, children: [
        TaskTree(name: 'bottest', step: Levels.bottom),
        TaskTree(name: 'botbl', step: Levels.bottom)
      ]),
      TaskTree(name: 'tree', step: Levels.center)
    ]),
    TaskTree(name: 'super'),
    TaskTree(name: 'puper'),
    TaskTree(name: 'big'),
    TaskTree(name: 'boy')
  ];
}

class FolderList {
  List<Folder> children = [
    Folder('me'),
    Folder('super'),
    Folder('puper'),
    Folder('big'),
    Folder('boy'),
    Folder('ema'),
    Folder('yo'),
    Folder('blin'),
    Folder('a eto chisto radi pricola'),
    Folder('tests')
  ];
}
