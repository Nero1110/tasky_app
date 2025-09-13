import 'package:depi_flutter_3rd_task/database/app_database.dart';
import 'package:depi_flutter_3rd_task/models/task_model.dart';
import 'package:depi_flutter_3rd_task/widgets/task_item.dart';
import 'package:flutter/material.dart';

class CompletedTasks extends StatefulWidget {
  const CompletedTasks({super.key});
  static String title = "Completed Tasks";
  @override
  State<CompletedTasks> createState() => _CompletedTasksState();
}

class _CompletedTasksState extends State<CompletedTasks> {


  List<TaskModel> tasks = [];
  @override
  void showlist() async {
    tasks = await AppDatabase().showdata();
    setState(() {
      tasks;
    });
  }

  @override
  void initState() {
    super.initState();
    showlist();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title: Text(
          "To Do Tasks",
          style: Theme.of(
            context,
          ).textTheme.headlineMedium!.copyWith(fontSize: 20),
        ),
      ),
 body:Column(
        children: [
          SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                if (tasks[index].isDone==true) {
                  return TaskItem(taskModel: tasks[index]);
                }
              },
            ),
          ),
        ],
      ), 
    );
  }
}
