import 'package:realm/realm.dart';

part 'repository_models.realm.dart';

@RealmModel()
class _FolderNavigationRepository {
  @PrimaryKey()
  late String uid;
  late int order;
  late String name;
  late String? tasksUid;
}

@RealmModel()
class _TasksTopRepository {
  @PrimaryKey()
  late String uid;
  late List<_Task> tasks;
}

@RealmModel()
class _TasksCenterRepository {
  @PrimaryKey()
  late String uid;
  late List<_Task> tasks;
}

@RealmModel()
class _TasksBottomRepository {
  @PrimaryKey()
  late String uid;
  late List<_Task> tasks;
}

@RealmModel()
class _Task {
  @PrimaryKey()
  late String uid;
  late int order;
  late String name;
  late String? childrenUid;
}