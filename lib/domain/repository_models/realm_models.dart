import 'package:realm/realm.dart';

part 'realm_models.realm.dart';

@RealmModel()
class _CustomUserTheme{
  late int? blocsColor;
  late int? borderColor;
  late int? backgroundColor;
  late int? textColor;
  late int? accentColor;
}

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
class _CompleteTasks {
  late List<_Task> tasks;
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
  late int countCompleteTasks;
  late List<_Task> tasks;
}

@RealmModel()
class _SubSubtasks {
  @PrimaryKey()
  late String uid;
  late int countCompleteTasks;
  late List<_Task> tasks;
}

@RealmModel()
class _Task {
  @PrimaryKey()
  late String uid;
  late String name;
  late String comment;
  late bool isComplete;
}
