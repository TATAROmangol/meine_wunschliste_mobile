import 'package:meine_wunschliste/domain/models/task_tree.dart';

class Folder {
  Folder(this.name);

  String name;
  List<TaskTree> tasks = [];
}

class FolderList {
  List<Folder> children = [
    Folder('me'),
    Folder('super'),
    Folder('puper'),
    Folder('sexy'),
    Folder('boy'),
    Folder('epta'),
    Folder('naxou'),
    Folder('blya'),
    Folder('a eto chisto radi pricola'),
    Folder('tests')
  ];
}
