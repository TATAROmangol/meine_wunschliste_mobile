import 'package:realm/realm.dart';

part 'models.realm.dart';

@RealmModel()
class _ActiveFolder {
  _Folder? folder;
}

@RealmModel()
class _Folder {
  @PrimaryKey()
  late String uid;
  late int order;
  late String name;
}

abstract class TaskTree {
  String get uid;
  List<_Task> get tasks;
}


@RealmModel()
class _RootTasks implements TaskTree {
  @PrimaryKey()
  late String uid;
  late List<_Task> tasks;
}

@RealmModel()
class _Subtasks implements TaskTree {
  @PrimaryKey()
  late String uid;
  late List<_Task> tasks;
}

@RealmModel()
class _SubSubtasks implements TaskTree {
  @PrimaryKey()
  late String uid;
  late List<_Task> tasks;
}

@RealmModel()
class _Task {
  @PrimaryKey()
  late String uid;
  late int step;
  late String name;
  late String? childrenUid;
}
