// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'repository_models.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

// ignore_for_file: type=lint
class FoldersRepository extends _FoldersRepository
    with RealmEntity, RealmObjectBase, RealmObject {
  FoldersRepository(
    String uid,
    int order,
    String name, {
    String? tasksUid,
  }) {
    RealmObjectBase.set(this, 'uid', uid);
    RealmObjectBase.set(this, 'order', order);
    RealmObjectBase.set(this, 'name', name);
    RealmObjectBase.set(this, 'tasksUid', tasksUid);
  }

  FoldersRepository._();

  @override
  String get uid => RealmObjectBase.get<String>(this, 'uid') as String;
  @override
  set uid(String value) => RealmObjectBase.set(this, 'uid', value);

  @override
  int get order => RealmObjectBase.get<int>(this, 'order') as int;
  @override
  set order(int value) => RealmObjectBase.set(this, 'order', value);

  @override
  String get name => RealmObjectBase.get<String>(this, 'name') as String;
  @override
  set name(String value) => RealmObjectBase.set(this, 'name', value);

  @override
  String? get tasksUid =>
      RealmObjectBase.get<String>(this, 'tasksUid') as String?;
  @override
  set tasksUid(String? value) => RealmObjectBase.set(this, 'tasksUid', value);

  @override
  Stream<RealmObjectChanges<FoldersRepository>> get changes =>
      RealmObjectBase.getChanges<FoldersRepository>(this);

  @override
  FoldersRepository freeze() =>
      RealmObjectBase.freezeObject<FoldersRepository>(this);

  EJsonValue toEJson() {
    return <String, dynamic>{
      'uid': uid.toEJson(),
      'order': order.toEJson(),
      'name': name.toEJson(),
      'tasksUid': tasksUid.toEJson(),
    };
  }

  static EJsonValue _toEJson(FoldersRepository value) => value.toEJson();
  static FoldersRepository _fromEJson(EJsonValue ejson) {
    return switch (ejson) {
      {
        'uid': EJsonValue uid,
        'order': EJsonValue order,
        'name': EJsonValue name,
        'tasksUid': EJsonValue tasksUid,
      } =>
        FoldersRepository(
          fromEJson(uid),
          fromEJson(order),
          fromEJson(name),
          tasksUid: fromEJson(tasksUid),
        ),
      _ => raiseInvalidEJson(ejson),
    };
  }

  static final schema = () {
    RealmObjectBase.registerFactory(FoldersRepository._);
    register(_toEJson, _fromEJson);
    return SchemaObject(
        ObjectType.realmObject, FoldersRepository, 'FoldersRepository', [
      SchemaProperty('uid', RealmPropertyType.string, primaryKey: true),
      SchemaProperty('order', RealmPropertyType.int),
      SchemaProperty('name', RealmPropertyType.string),
      SchemaProperty('tasksUid', RealmPropertyType.string, optional: true),
    ]);
  }();

  @override
  SchemaObject get objectSchema => RealmObjectBase.getSchema(this) ?? schema;
}

class TasksTopRepository extends _TasksTopRepository
    with RealmEntity, RealmObjectBase, RealmObject {
  TasksTopRepository(
    String uid, {
    Iterable<Task> tasks = const [],
  }) {
    RealmObjectBase.set(this, 'uid', uid);
    RealmObjectBase.set<RealmList<Task>>(this, 'tasks', RealmList<Task>(tasks));
  }

  TasksTopRepository._();

  @override
  String get uid => RealmObjectBase.get<String>(this, 'uid') as String;
  @override
  set uid(String value) => RealmObjectBase.set(this, 'uid', value);

  @override
  RealmList<Task> get tasks =>
      RealmObjectBase.get<Task>(this, 'tasks') as RealmList<Task>;
  @override
  set tasks(covariant RealmList<Task> value) =>
      throw RealmUnsupportedSetError();

  @override
  Stream<RealmObjectChanges<TasksTopRepository>> get changes =>
      RealmObjectBase.getChanges<TasksTopRepository>(this);

  @override
  TasksTopRepository freeze() =>
      RealmObjectBase.freezeObject<TasksTopRepository>(this);

  EJsonValue toEJson() {
    return <String, dynamic>{
      'uid': uid.toEJson(),
      'tasks': tasks.toEJson(),
    };
  }

  static EJsonValue _toEJson(TasksTopRepository value) => value.toEJson();
  static TasksTopRepository _fromEJson(EJsonValue ejson) {
    return switch (ejson) {
      {
        'uid': EJsonValue uid,
        'tasks': EJsonValue tasks,
      } =>
        TasksTopRepository(
          fromEJson(uid),
          tasks: fromEJson(tasks),
        ),
      _ => raiseInvalidEJson(ejson),
    };
  }

  static final schema = () {
    RealmObjectBase.registerFactory(TasksTopRepository._);
    register(_toEJson, _fromEJson);
    return SchemaObject(
        ObjectType.realmObject, TasksTopRepository, 'TasksTopRepository', [
      SchemaProperty('uid', RealmPropertyType.string, primaryKey: true),
      SchemaProperty('tasks', RealmPropertyType.object,
          linkTarget: 'Task', collectionType: RealmCollectionType.list),
    ]);
  }();

  @override
  SchemaObject get objectSchema => RealmObjectBase.getSchema(this) ?? schema;
}

class TasksCenterRepository extends _TasksCenterRepository
    with RealmEntity, RealmObjectBase, RealmObject {
  TasksCenterRepository(
    String uid, {
    Iterable<Task> tasks = const [],
  }) {
    RealmObjectBase.set(this, 'uid', uid);
    RealmObjectBase.set<RealmList<Task>>(this, 'tasks', RealmList<Task>(tasks));
  }

  TasksCenterRepository._();

  @override
  String get uid => RealmObjectBase.get<String>(this, 'uid') as String;
  @override
  set uid(String value) => RealmObjectBase.set(this, 'uid', value);

  @override
  RealmList<Task> get tasks =>
      RealmObjectBase.get<Task>(this, 'tasks') as RealmList<Task>;
  @override
  set tasks(covariant RealmList<Task> value) =>
      throw RealmUnsupportedSetError();

  @override
  Stream<RealmObjectChanges<TasksCenterRepository>> get changes =>
      RealmObjectBase.getChanges<TasksCenterRepository>(this);

  @override
  TasksCenterRepository freeze() =>
      RealmObjectBase.freezeObject<TasksCenterRepository>(this);

  EJsonValue toEJson() {
    return <String, dynamic>{
      'uid': uid.toEJson(),
      'tasks': tasks.toEJson(),
    };
  }

  static EJsonValue _toEJson(TasksCenterRepository value) => value.toEJson();
  static TasksCenterRepository _fromEJson(EJsonValue ejson) {
    return switch (ejson) {
      {
        'uid': EJsonValue uid,
        'tasks': EJsonValue tasks,
      } =>
        TasksCenterRepository(
          fromEJson(uid),
          tasks: fromEJson(tasks),
        ),
      _ => raiseInvalidEJson(ejson),
    };
  }

  static final schema = () {
    RealmObjectBase.registerFactory(TasksCenterRepository._);
    register(_toEJson, _fromEJson);
    return SchemaObject(ObjectType.realmObject, TasksCenterRepository,
        'TasksCenterRepository', [
      SchemaProperty('uid', RealmPropertyType.string, primaryKey: true),
      SchemaProperty('tasks', RealmPropertyType.object,
          linkTarget: 'Task', collectionType: RealmCollectionType.list),
    ]);
  }();

  @override
  SchemaObject get objectSchema => RealmObjectBase.getSchema(this) ?? schema;
}

class TasksBottomRepository extends _TasksBottomRepository
    with RealmEntity, RealmObjectBase, RealmObject {
  TasksBottomRepository(
    String uid, {
    Iterable<Task> tasks = const [],
  }) {
    RealmObjectBase.set(this, 'uid', uid);
    RealmObjectBase.set<RealmList<Task>>(this, 'tasks', RealmList<Task>(tasks));
  }

  TasksBottomRepository._();

  @override
  String get uid => RealmObjectBase.get<String>(this, 'uid') as String;
  @override
  set uid(String value) => RealmObjectBase.set(this, 'uid', value);

  @override
  RealmList<Task> get tasks =>
      RealmObjectBase.get<Task>(this, 'tasks') as RealmList<Task>;
  @override
  set tasks(covariant RealmList<Task> value) =>
      throw RealmUnsupportedSetError();

  @override
  Stream<RealmObjectChanges<TasksBottomRepository>> get changes =>
      RealmObjectBase.getChanges<TasksBottomRepository>(this);

  @override
  TasksBottomRepository freeze() =>
      RealmObjectBase.freezeObject<TasksBottomRepository>(this);

  EJsonValue toEJson() {
    return <String, dynamic>{
      'uid': uid.toEJson(),
      'tasks': tasks.toEJson(),
    };
  }

  static EJsonValue _toEJson(TasksBottomRepository value) => value.toEJson();
  static TasksBottomRepository _fromEJson(EJsonValue ejson) {
    return switch (ejson) {
      {
        'uid': EJsonValue uid,
        'tasks': EJsonValue tasks,
      } =>
        TasksBottomRepository(
          fromEJson(uid),
          tasks: fromEJson(tasks),
        ),
      _ => raiseInvalidEJson(ejson),
    };
  }

  static final schema = () {
    RealmObjectBase.registerFactory(TasksBottomRepository._);
    register(_toEJson, _fromEJson);
    return SchemaObject(ObjectType.realmObject, TasksBottomRepository,
        'TasksBottomRepository', [
      SchemaProperty('uid', RealmPropertyType.string, primaryKey: true),
      SchemaProperty('tasks', RealmPropertyType.object,
          linkTarget: 'Task', collectionType: RealmCollectionType.list),
    ]);
  }();

  @override
  SchemaObject get objectSchema => RealmObjectBase.getSchema(this) ?? schema;
}

class Task extends _Task with RealmEntity, RealmObjectBase, RealmObject {
  Task(
    String uid,
    int order,
    String name, {
    String? childrenUid,
  }) {
    RealmObjectBase.set(this, 'uid', uid);
    RealmObjectBase.set(this, 'order', order);
    RealmObjectBase.set(this, 'name', name);
    RealmObjectBase.set(this, 'childrenUid', childrenUid);
  }

  Task._();

  @override
  String get uid => RealmObjectBase.get<String>(this, 'uid') as String;
  @override
  set uid(String value) => RealmObjectBase.set(this, 'uid', value);

  @override
  int get order => RealmObjectBase.get<int>(this, 'order') as int;
  @override
  set order(int value) => RealmObjectBase.set(this, 'order', value);

  @override
  String get name => RealmObjectBase.get<String>(this, 'name') as String;
  @override
  set name(String value) => RealmObjectBase.set(this, 'name', value);

  @override
  String? get childrenUid =>
      RealmObjectBase.get<String>(this, 'childrenUid') as String?;
  @override
  set childrenUid(String? value) =>
      RealmObjectBase.set(this, 'childrenUid', value);

  @override
  Stream<RealmObjectChanges<Task>> get changes =>
      RealmObjectBase.getChanges<Task>(this);

  @override
  Task freeze() => RealmObjectBase.freezeObject<Task>(this);

  EJsonValue toEJson() {
    return <String, dynamic>{
      'uid': uid.toEJson(),
      'order': order.toEJson(),
      'name': name.toEJson(),
      'childrenUid': childrenUid.toEJson(),
    };
  }

  static EJsonValue _toEJson(Task value) => value.toEJson();
  static Task _fromEJson(EJsonValue ejson) {
    return switch (ejson) {
      {
        'uid': EJsonValue uid,
        'order': EJsonValue order,
        'name': EJsonValue name,
        'childrenUid': EJsonValue childrenUid,
      } =>
        Task(
          fromEJson(uid),
          fromEJson(order),
          fromEJson(name),
          childrenUid: fromEJson(childrenUid),
        ),
      _ => raiseInvalidEJson(ejson),
    };
  }

  static final schema = () {
    RealmObjectBase.registerFactory(Task._);
    register(_toEJson, _fromEJson);
    return SchemaObject(ObjectType.realmObject, Task, 'Task', [
      SchemaProperty('uid', RealmPropertyType.string, primaryKey: true),
      SchemaProperty('order', RealmPropertyType.int),
      SchemaProperty('name', RealmPropertyType.string),
      SchemaProperty('childrenUid', RealmPropertyType.string, optional: true),
    ]);
  }();

  @override
  SchemaObject get objectSchema => RealmObjectBase.getSchema(this) ?? schema;
}
