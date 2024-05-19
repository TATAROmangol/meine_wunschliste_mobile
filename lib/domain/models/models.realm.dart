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
    String name,
  ) {
    RealmObjectBase.set(this, 'uid', uid);
    RealmObjectBase.set(this, 'order', order);
    RealmObjectBase.set(this, 'name', name);
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
  Stream<RealmObjectChanges<Folder>> get changes =>
      RealmObjectBase.getChanges<Folder>(this);

  @override
  Folder freeze() => RealmObjectBase.freezeObject<Folder>(this);

  EJsonValue toEJson() {
    return <String, dynamic>{
      'uid': uid.toEJson(),
      'order': order.toEJson(),
      'name': name.toEJson(),
    };
  }

  static EJsonValue _toEJson(Folder value) => value.toEJson();
  static Folder _fromEJson(EJsonValue ejson) {
    return switch (ejson) {
      {
        'uid': EJsonValue uid,
        'order': EJsonValue order,
        'name': EJsonValue name,
      } =>
        Folder(
          fromEJson(uid),
          fromEJson(order),
          fromEJson(name),
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
    ]);
  }();

  @override
  SchemaObject get objectSchema => RealmObjectBase.getSchema(this) ?? schema;
}

class RootTasks extends _RootTasks
    with RealmEntity, RealmObjectBase, RealmObject {
  RootTasks(
    String uid, {
    Iterable<Task> tasks = const [],
  }) {
    RealmObjectBase.set(this, 'uid', uid);
    RealmObjectBase.set<RealmList<Task>>(this, 'tasks', RealmList<Task>(tasks));
  }

  RootTasks._();

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
  Stream<RealmObjectChanges<RootTasks>> get changes =>
      RealmObjectBase.getChanges<RootTasks>(this);

  @override
  RootTasks freeze() => RealmObjectBase.freezeObject<RootTasks>(this);

  EJsonValue toEJson() {
    return <String, dynamic>{
      'uid': uid.toEJson(),
      'tasks': tasks.toEJson(),
    };
  }

  static EJsonValue _toEJson(RootTasks value) => value.toEJson();
  static RootTasks _fromEJson(EJsonValue ejson) {
    return switch (ejson) {
      {
        'uid': EJsonValue uid,
        'tasks': EJsonValue tasks,
      } =>
        RootTasks(
          fromEJson(uid),
          tasks: fromEJson(tasks),
        ),
      _ => raiseInvalidEJson(ejson),
    };
  }

  static final schema = () {
    RealmObjectBase.registerFactory(RootTasks._);
    register(_toEJson, _fromEJson);
    return SchemaObject(ObjectType.realmObject, RootTasks, 'RootTasks', [
      SchemaProperty('uid', RealmPropertyType.string, primaryKey: true),
      SchemaProperty('tasks', RealmPropertyType.object,
          linkTarget: 'Task', collectionType: RealmCollectionType.list),
    ]);
  }();

  @override
  SchemaObject get objectSchema => RealmObjectBase.getSchema(this) ?? schema;
}

class Subtasks extends _Subtasks
    with RealmEntity, RealmObjectBase, RealmObject {
  Subtasks(
    String uid,
    bool allComplete, {
    Iterable<Task> tasks = const [],
  }) {
    RealmObjectBase.set(this, 'uid', uid);
    RealmObjectBase.set(this, 'allComplete', allComplete);
    RealmObjectBase.set<RealmList<Task>>(this, 'tasks', RealmList<Task>(tasks));
  }

  Subtasks._();

  @override
  String get uid => RealmObjectBase.get<String>(this, 'uid') as String;
  @override
  set uid(String value) => RealmObjectBase.set(this, 'uid', value);

  @override
  bool get allComplete =>
      RealmObjectBase.get<bool>(this, 'allComplete') as bool;
  @override
  set allComplete(bool value) =>
      RealmObjectBase.set(this, 'allComplete', value);

  @override
  RealmList<Task> get tasks =>
      RealmObjectBase.get<Task>(this, 'tasks') as RealmList<Task>;
  @override
  set tasks(covariant RealmList<Task> value) =>
      throw RealmUnsupportedSetError();

  @override
  Stream<RealmObjectChanges<Subtasks>> get changes =>
      RealmObjectBase.getChanges<Subtasks>(this);

  @override
  Subtasks freeze() => RealmObjectBase.freezeObject<Subtasks>(this);

  EJsonValue toEJson() {
    return <String, dynamic>{
      'uid': uid.toEJson(),
      'allComplete': allComplete.toEJson(),
      'tasks': tasks.toEJson(),
    };
  }

  static EJsonValue _toEJson(Subtasks value) => value.toEJson();
  static Subtasks _fromEJson(EJsonValue ejson) {
    return switch (ejson) {
      {
        'uid': EJsonValue uid,
        'allComplete': EJsonValue allComplete,
        'tasks': EJsonValue tasks,
      } =>
        Subtasks(
          fromEJson(uid),
          fromEJson(allComplete),
          tasks: fromEJson(tasks),
        ),
      _ => raiseInvalidEJson(ejson),
    };
  }

  static final schema = () {
    RealmObjectBase.registerFactory(Subtasks._);
    register(_toEJson, _fromEJson);
    return SchemaObject(ObjectType.realmObject, Subtasks, 'Subtasks', [
      SchemaProperty('uid', RealmPropertyType.string, primaryKey: true),
      SchemaProperty('allComplete', RealmPropertyType.bool),
      SchemaProperty('tasks', RealmPropertyType.object,
          linkTarget: 'Task', collectionType: RealmCollectionType.list),
    ]);
  }();

  @override
  SchemaObject get objectSchema => RealmObjectBase.getSchema(this) ?? schema;
}

class SubSubtasks extends _SubSubtasks
    with RealmEntity, RealmObjectBase, RealmObject {
  SubSubtasks(
    String uid,
    bool allComplete, {
    Iterable<Task> tasks = const [],
  }) {
    RealmObjectBase.set(this, 'uid', uid);
    RealmObjectBase.set(this, 'allComplete', allComplete);
    RealmObjectBase.set<RealmList<Task>>(this, 'tasks', RealmList<Task>(tasks));
  }

  SubSubtasks._();

  @override
  String get uid => RealmObjectBase.get<String>(this, 'uid') as String;
  @override
  set uid(String value) => RealmObjectBase.set(this, 'uid', value);

  @override
  bool get allComplete =>
      RealmObjectBase.get<bool>(this, 'allComplete') as bool;
  @override
  set allComplete(bool value) =>
      RealmObjectBase.set(this, 'allComplete', value);

  @override
  RealmList<Task> get tasks =>
      RealmObjectBase.get<Task>(this, 'tasks') as RealmList<Task>;
  @override
  set tasks(covariant RealmList<Task> value) =>
      throw RealmUnsupportedSetError();

  @override
  Stream<RealmObjectChanges<SubSubtasks>> get changes =>
      RealmObjectBase.getChanges<SubSubtasks>(this);

  @override
  SubSubtasks freeze() => RealmObjectBase.freezeObject<SubSubtasks>(this);

  EJsonValue toEJson() {
    return <String, dynamic>{
      'uid': uid.toEJson(),
      'allComplete': allComplete.toEJson(),
      'tasks': tasks.toEJson(),
    };
  }

  static EJsonValue _toEJson(SubSubtasks value) => value.toEJson();
  static SubSubtasks _fromEJson(EJsonValue ejson) {
    return switch (ejson) {
      {
        'uid': EJsonValue uid,
        'allComplete': EJsonValue allComplete,
        'tasks': EJsonValue tasks,
      } =>
        SubSubtasks(
          fromEJson(uid),
          fromEJson(allComplete),
          tasks: fromEJson(tasks),
        ),
      _ => raiseInvalidEJson(ejson),
    };
  }

  static final schema = () {
    RealmObjectBase.registerFactory(SubSubtasks._);
    register(_toEJson, _fromEJson);
    return SchemaObject(ObjectType.realmObject, SubSubtasks, 'SubSubtasks', [
      SchemaProperty('uid', RealmPropertyType.string, primaryKey: true),
      SchemaProperty('allComplete', RealmPropertyType.bool),
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
    String name,
    String comment,
    bool isComplete,
  ) {
    RealmObjectBase.set(this, 'uid', uid);
    RealmObjectBase.set(this, 'name', name);
    RealmObjectBase.set(this, 'comment', comment);
    RealmObjectBase.set(this, 'isComplete', isComplete);
  }

  Task._();

  @override
  String get uid => RealmObjectBase.get<String>(this, 'uid') as String;
  @override
  set uid(String value) => RealmObjectBase.set(this, 'uid', value);

  @override
  String get name => RealmObjectBase.get<String>(this, 'name') as String;
  @override
  set name(String value) => RealmObjectBase.set(this, 'name', value);

  @override
  String get comment => RealmObjectBase.get<String>(this, 'comment') as String;
  @override
  set comment(String value) => RealmObjectBase.set(this, 'comment', value);

  @override
  bool get isComplete => RealmObjectBase.get<bool>(this, 'isComplete') as bool;
  @override
  set isComplete(bool value) => RealmObjectBase.set(this, 'isComplete', value);

  @override
  Stream<RealmObjectChanges<Task>> get changes =>
      RealmObjectBase.getChanges<Task>(this);

  @override
  Task freeze() => RealmObjectBase.freezeObject<Task>(this);

  EJsonValue toEJson() {
    return <String, dynamic>{
      'uid': uid.toEJson(),
      'name': name.toEJson(),
      'comment': comment.toEJson(),
      'isComplete': isComplete.toEJson(),
    };
  }

  static EJsonValue _toEJson(Task value) => value.toEJson();
  static Task _fromEJson(EJsonValue ejson) {
    return switch (ejson) {
      {
        'uid': EJsonValue uid,
        'name': EJsonValue name,
        'comment': EJsonValue comment,
        'isComplete': EJsonValue isComplete,
      } =>
        Task(
          fromEJson(uid),
          fromEJson(name),
          fromEJson(comment),
          fromEJson(isComplete),
        ),
      _ => raiseInvalidEJson(ejson),
    };
  }

  static final schema = () {
    RealmObjectBase.registerFactory(Task._);
    register(_toEJson, _fromEJson);
    return SchemaObject(ObjectType.realmObject, Task, 'Task', [
      SchemaProperty('uid', RealmPropertyType.string, primaryKey: true),
      SchemaProperty('name', RealmPropertyType.string),
      SchemaProperty('comment', RealmPropertyType.string),
      SchemaProperty('isComplete', RealmPropertyType.bool),
    ]);
  }();

  @override
  SchemaObject get objectSchema => RealmObjectBase.getSchema(this) ?? schema;
}
