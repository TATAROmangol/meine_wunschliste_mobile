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

@RealmModel()
class _RootTasks {
  @PrimaryKey()
  late String uid;
  late List<_Task> tasks;
}

@RealmModel()
class _Subtasks {
  @PrimaryKey()
  late String uid;
  late List<_Task> tasks;
}

@RealmModel()
class _SubSubtasks {
  @PrimaryKey()
  late String uid;
  late List<_Task> tasks;
}

@RealmModel()
class _Task {
  @PrimaryKey()
  late String uid;
  late String name;
  late String comment;
}
