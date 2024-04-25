class Task{
  late String uid;
  late int order;
  late String name;
  late String? childrenUid;

  Task({
    required this.uid,
    required this.order,
    required this.name,
    required this.childrenUid,
  }) ;
}