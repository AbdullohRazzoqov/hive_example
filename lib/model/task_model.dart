import 'package:hive_flutter/adapters.dart';
part 'task_model.g.dart';

@HiveType(typeId: 1)
class Task extends HiveObject {
  @HiveField(0)
  String taskName;

  @HiveField(1)
  DateTime dateTime;

  @HiveField(2)
  bool favorite;

  Task({
    required this.taskName,
    required this.dateTime,
    this.favorite = false,
  });
}
