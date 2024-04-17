class TaskTree{
  TaskTree(this.name);

  String name;
  List<TaskTree> children = [];
}