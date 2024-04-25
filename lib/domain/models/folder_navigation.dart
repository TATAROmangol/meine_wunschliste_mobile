import 'package:meine_wunschliste/repository/models/repository_models.dart';

class FolderNavigation {
  late String uid;
  late int order;
  late String name;
  late String? tasksUid;

  FolderNavigation({
    required this.uid,
    required this.order,
    required this.name,
    required this.tasksUid,
  }); 

  FolderNavigationRepository toRepository(){
    return FolderNavigationRepository(uid, order, name, tasksUid: tasksUid);
  }

  static FolderNavigation fromRepository(FolderNavigationRepository repository) {
  return FolderNavigation(
    uid: repository.uid,
    order: repository.order,
    name: repository.name,
    tasksUid: repository.tasksUid,
  );
  }

  // Folder.fromJson(this.uid, Map<String, dynamic> data) {
  //   order = data['order'];
  //   name = data['name'];
  //   tasks = (data['tasks'] != null)
  //       ? data['tasks'].map((task) => TaskTree.fromJson(task)).toList()
  //       : [];
  // }

  // Map<String, dynamic> toMap() {
  //   return {
  //     "uid": uid,
  //     "order": order,
  //     "name": name,
  //     "tasks": tasks.map((task) => task.toMap()).toList()
  //   };
  // }
}

class FolderRepository {
}
