import 'package:hive_example/model/catigory_model.dart';
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
  @HiveField(3)
  Category catigory;

  @HiveField(4)
  List<int> count;
  Task({
    required this.taskName,
    required this.dateTime,
    this.favorite = false,
    required this.catigory,required this.count
  });
}
