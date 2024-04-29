// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

// ignore_for_file: type=lint
class ActiveFolder extends _ActiveFolder
    with RealmEntity, RealmObjectBase, RealmObject {
  ActiveFolder({
    Folder? folder,
  }) {
    RealmObjectBase.set(this, 'folder', folder);
  }

  ActiveFolder._();

  @override
  Folder? get folder => RealmObjectBase.get<Folder>(this, 'folder') as Folder?;
  @override
  set folder(covariant Folder? value) =>
      RealmObjectBase.set(this, 'folder', value);

  @override
  Stream<RealmObjectChanges<ActiveFolder>> get changes =>
      RealmObjectBase.getChanges<ActiveFolder>(this);

  @override
  ActiveFolder freeze() => RealmObjectBase.freezeObject<ActiveFolder>(this);

  EJsonValue toEJson() {
    return <String, dynamic>{
      'folder': folder.toEJson(),
    };
  }

  static EJsonValue _toEJson(ActiveFolder value) => value.toEJson();
  static ActiveFolder _fromEJson(EJsonValue ejson) {
    return switch (ejson) {
      {
        'folder': EJsonValue folder,
      } =>
        ActiveFolder(
          folder: fromEJson(folder),
        ),
      _ => raiseInvalidEJson(ejson),
    };
  }

  static final schema = () {
    RealmObjectBase.registerFactory(ActiveFolder._);
    register(_toEJson, _fromEJson);
    return SchemaObject(ObjectType.realmObject, ActiveFolder, 'ActiveFolder', [
      SchemaProperty('folder', RealmPropertyType.object,
          optional: true, linkTarget: 'Folder'),
    ]);
  }();

  @override
  SchemaObject get objectSchema => RealmObjectBase.getSchema(this) ?? schema;
}

class Folder extends _Folder with RealmEntity, RealmObjectBase, RealmObject {
  Folder(
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

  Folder._();

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
  Stream<RealmObjectChanges<Folder>> get changes =>
      RealmObjectBase.getChanges<Folder>(this);

  @override
  Folder freeze() => RealmObjectBase.freezeObject<Folder>(this);

  EJsonValue toEJson() {
    return <String, dynamic>{
      'uid': uid.toEJson(),
      'order': order.toEJson(),
      'name': name.toEJson(),
      'tasksUid': tasksUid.toEJson(),
    };
  }

  static EJsonValue _toEJson(Folder value) => value.toEJson();
  static Folder _fromEJson(EJsonValue ejson) {
    return switch (ejson) {
      {
        'uid': EJsonValue uid,
        'order': EJsonValue order,
        'name': EJsonValue name,
        'tasksUid': EJsonValue tasksUid,
      } =>
        Folder(
          fromEJson(uid),
          fromEJson(order),
          fromEJson(name),
          tasksUid: fromEJson(tasksUid),
        ),
      _ => raiseInvalidEJson(ejson),
    };
  }

  static final schema = () {
    RealmObjectBase.registerFactory(Folder._);
    register(_toEJson, _fromEJson);
    return SchemaObject(ObjectType.realmObject, Folder, 'Folder', [
      SchemaProperty('uid', RealmPropertyType.string, primaryKey: true),
      SchemaProperty('order', RealmPropertyType.int),
      SchemaProperty('name', RealmPropertyType.string),
      SchemaProperty('tasksUid', RealmPropertyType.string, optional: true),
    ]);
  }();

  @override
  SchemaObject get objectSchema => RealmObjectBase.getSchema(this) ?? schema;
}

class TasksTop extends _TasksTop
    with RealmEntity, RealmObjectBase, RealmObject {
  TasksTop(
    String uid, {
    Iterable<Task> tasks = const [],
  }) {
    RealmObjectBase.set(this, 'uid', uid);
    RealmObjectBase.set<RealmList<Task>>(this, 'tasks', RealmList<Task>(tasks));
  }

  TasksTop._();

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
  Stream<RealmObjectChanges<TasksTop>> get changes =>
      RealmObjectBase.getChanges<TasksTop>(this);

  @override
  TasksTop freeze() => RealmObjectBase.freezeObject<TasksTop>(this);

  EJsonValue toEJson() {
    return <String, dynamic>{
      'uid': uid.toEJson(),
      'tasks': tasks.toEJson(),
    };
  }

  static EJsonValue _toEJson(TasksTop value) => value.toEJson();
  static TasksTop _fromEJson(EJsonValue ejson) {
    return switch (ejson) {
      {
        'uid': EJsonValue uid,
        'tasks': EJsonValue tasks,
      } =>
        TasksTop(
          fromEJson(uid),
          tasks: fromEJson(tasks),
        ),
      _ => raiseInvalidEJson(ejson),
    };
  }

  static final schema = () {
    RealmObjectBase.registerFactory(TasksTop._);
    register(_toEJson, _fromEJson);
    return SchemaObject(ObjectType.realmObject, TasksTop, 'TasksTop', [
      SchemaProperty('uid', RealmPropertyType.string, primaryKey: true),
      SchemaProperty('tasks', RealmPropertyType.object,
          linkTarget: 'Task', collectionType: RealmCollectionType.list),
    ]);
  }();

  @override
  SchemaObject get objectSchema => RealmObjectBase.getSchema(this) ?? schema;
}

class TasksCenter extends _TasksCenter
    with RealmEntity, RealmObjectBase, RealmObject {
  TasksCenter(
    String uid, {
    Iterable<Task> tasks = const [],
  }) {
    RealmObjectBase.set(this, 'uid', uid);
    RealmObjectBase.set<RealmList<Task>>(this, 'tasks', RealmList<Task>(tasks));
  }

  TasksCenter._();

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
  Stream<RealmObjectChanges<TasksCenter>> get changes =>
      RealmObjectBase.getChanges<TasksCenter>(this);

  @override
  TasksCenter freeze() => RealmObjectBase.freezeObject<TasksCenter>(this);

  EJsonValue toEJson() {
    return <String, dynamic>{
      'uid': uid.toEJson(),
      'tasks': tasks.toEJson(),
    };
  }

  static EJsonValue _toEJson(TasksCenter value) => value.toEJson();
  static TasksCenter _fromEJson(EJsonValue ejson) {
    return switch (ejson) {
      {
        'uid': EJsonValue uid,
        'tasks': EJsonValue tasks,
      } =>
        TasksCenter(
          fromEJson(uid),
          tasks: fromEJson(tasks),
        ),
      _ => raiseInvalidEJson(ejson),
    };
  }

  static final schema = () {
    RealmObjectBase.registerFactory(TasksCenter._);
    register(_toEJson, _fromEJson);
    return SchemaObject(ObjectType.realmObject, TasksCenter, 'TasksCenter', [
      SchemaProperty('uid', RealmPropertyType.string, primaryKey: true),
      SchemaProperty('tasks', RealmPropertyType.object,
          linkTarget: 'Task', collectionType: RealmCollectionType.list),
    ]);
  }();

  @override
  SchemaObject get objectSchema => RealmObjectBase.getSchema(this) ?? schema;
}

class TasksBottom extends _TasksBottom
    with RealmEntity, RealmObjectBase, RealmObject {
  TasksBottom(
    String uid, {
    Iterable<Task> tasks = const [],
  }) {
    RealmObjectBase.set(this, 'uid', uid);
    RealmObjectBase.set<RealmList<Task>>(this, 'tasks', RealmList<Task>(tasks));
  }

  TasksBottom._();

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
  Stream<RealmObjectChanges<TasksBottom>> get changes =>
      RealmObjectBase.getChanges<TasksBottom>(this);

  @override
  TasksBottom freeze() => RealmObjectBase.freezeObject<TasksBottom>(this);

  EJsonValue toEJson() {
    return <String, dynamic>{
      'uid': uid.toEJson(),
      'tasks': tasks.toEJson(),
    };
  }

  static EJsonValue _toEJson(TasksBottom value) => value.toEJson();
  static TasksBottom _fromEJson(EJsonValue ejson) {
    return switch (ejson) {
      {
        'uid': EJsonValue uid,
        'tasks': EJsonValue tasks,
      } =>
        TasksBottom(
          fromEJson(uid),
          tasks: fromEJson(tasks),
        ),
      _ => raiseInvalidEJson(ejson),
    };
  }

  static final schema = () {
    RealmObjectBase.registerFactory(TasksBottom._);
    register(_toEJson, _fromEJson);
    return SchemaObject(ObjectType.realmObject, TasksBottom, 'TasksBottom', [
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
    int step,
    String name, {
    String? childrenUid,
  }) {
    RealmObjectBase.set(this, 'uid', uid);
    RealmObjectBase.set(this, 'order', order);
    RealmObjectBase.set(this, 'step', step);
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
  int get step => RealmObjectBase.get<int>(this, 'step') as int;
  @override
  set step(int value) => RealmObjectBase.set(this, 'step', value);

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
      'step': step.toEJson(),
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
        'step': EJsonValue step,
        'name': EJsonValue name,
        'childrenUid': EJsonValue childrenUid,
      } =>
        Task(
          fromEJson(uid),
          fromEJson(order),
          fromEJson(step),
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
      SchemaProperty('step', RealmPropertyType.int),
      SchemaProperty('name', RealmPropertyType.string),
      SchemaProperty('childrenUid', RealmPropertyType.string, optional: true),
    ]);
  }();

  @override
  SchemaObject get objectSchema => RealmObjectBase.getSchema(this) ?? schema;
}
