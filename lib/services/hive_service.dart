import 'package:hive_example/model/catigory_model.dart';
import 'package:hive_example/model/task_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveService {
  List<Task?> task = [];
  late Box<Task> taskBox;

  static Future<HiveService> create() async {
    await Hive.initFlutter();
    Hive.registerAdapter<Task>(
        TaskAdapter()); 
        Hive.registerAdapter<Category>(CategoryAdapter()); 

    final box = await Hive.openBox<Task>('taskBox');
    return HiveService._create(box);
  }

  HiveService._create(this.taskBox) {
    taskBox = taskBox;
  }

  void addTask(Task task) {
    taskBox.add(task);
  }

  void deleteTask(int index) {
    taskBox.deleteAt(index);
  }

  List<Task?> getTaskAll() {
    print(taskBox.length);
    for (int i = 0; i < taskBox.length; i++) {
      task.add(taskBox.getAt(i));
    }
    return task;
  }
}
