import 'package:flutter/material.dart';
import 'package:hive_example/model/task_model.dart';
import 'package:hive_example/services/hive_service.dart';

class MyHomeScreen extends StatefulWidget {
  const MyHomeScreen({super.key});

  @override
  State<MyHomeScreen> createState() => _MyHomeScreenState();
}

class _MyHomeScreenState extends State<MyHomeScreen> {
  List<Task?> task = [];
  TextEditingController taskController = TextEditingController();
  DateTime? dateTime;
  late HiveService hiveService;
  @override
  void initState() {
    initHive();
    super.initState();
  }

  void initHive() async {
    hiveService = await HiveService.create();
    task = hiveService.getTaskAll();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Hive"),
      ),
      body: task.isEmpty
          ? const Center(
              child: Text(
                "Malumot yo'q",
                style: TextStyle(fontSize: 24, color: Colors.cyan),
              ),
            )
          : ListView.builder(
              itemBuilder: (ctx, index) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  child: Card(
                    child: ListTile(
                      title: Text(task[index]!.taskName),
                      subtitle: Text('${task[index]!.dateTime} vaqt'),
                    ),
                  ),
                );
              },
              itemCount: task.length,
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24)),
                  content: SizedBox(
                    height: MediaQuery.sizeOf(context).width * 0.6,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 10),
                      child: Column(
                        children: [
                          TextFormField(
                            controller: taskController,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                hintText: 'task'),
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          GestureDetector(
                            onTap: () {
                              dateTime = DateTime.now();
                            },
                            child: Container(
                              width: MediaQuery.sizeOf(context).width * 0.4,
                              height: 44,
                              decoration: BoxDecoration(
                                  color: Colors.cyan,
                                  borderRadius: BorderRadius.circular(22)),
                              child: const Center(
                                child: Text('Current Time'),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  actions: [
                    GestureDetector(
                      onTap: () {
                        if (taskController.text.isNotEmpty &&
                            dateTime != null) {
                          hiveService.addTask(Task(
                              taskName: taskController.text,
                              dateTime: dateTime!));
                          setState(() {});
                          Navigator.pop(context);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Malumotlar bo\'sh')));
                        }
                      },
                      child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.cyan),
                          width: 100,
                          height: 40,
                          child: const Center(
                              child: Text(
                            'Save',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w600),
                          ))),
                    )
                  ],
                );
              });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
