import 'package:depi_flutter_3rd_task/models/task_model.dart';
import 'package:depi_flutter_3rd_task/widgets/task_item.dart';
import 'package:flutter/material.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';

class ToDoScreen extends StatelessWidget {
  ToDoScreen({super.key});
  static String title = "To Do Tasks";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "To Do Tasks",
          style: Theme.of(
            context,
          ).textTheme.headlineMedium!.copyWith(fontSize: 20),
        ),
      ),

      body: Column(
        children: [
          SizedBox(height: 20),
          ValueListenableBuilder(
            valueListenable: Hive.box<TaskModel>("Tasks").listenable(),
            builder: (context, value, child) {
              final unCompletedtasks = value.values
                  .where((element) => !element.isDone)
                  .toList();
              return Expanded(
                child: ListView.builder(
                  itemCount: unCompletedtasks.length,
                  itemBuilder: (context, index) {
                    
                      return TaskItem(taskModel: unCompletedtasks[index]);
                    
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
