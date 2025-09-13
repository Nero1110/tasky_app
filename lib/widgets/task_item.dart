import 'package:depi_flutter_3rd_task/database/app_database.dart';
import 'package:depi_flutter_3rd_task/light_dark_controller/light_dark_cubit.dart';
import 'package:depi_flutter_3rd_task/light_dark_controller/light_dark_states.dart';
import 'package:depi_flutter_3rd_task/models/task_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TaskItem extends StatefulWidget {
  const TaskItem({super.key, required this.taskModel});
  final TaskModel taskModel;

  @override
  State<TaskItem> createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  late bool isDone; // حالة محلية

  @override
  void initState() {
    super.initState();
    isDone = widget.taskModel.isDone; // ناخد القيمة الأولية من الموديل
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LightDarkCubit, ThemeState>(
      builder: (context, state) {
        return Card(
          shape: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent),
            borderRadius: BorderRadius.circular(20),
          ),
          child: ListTile(
            horizontalTitleGap: 1,
            contentPadding: const EdgeInsets.only(right: 15),
            shape: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent),
              borderRadius: BorderRadius.circular(20),
            ),
            tileColor: state.backgroundcolor,
            leading: IconButton(
              onPressed: () async {
                setState(() {
                  isDone = !isDone; 
                });

          
                widget.taskModel.isDone = isDone;

          
                await AppDatabase().updateTask(widget.taskModel);
              },
              icon: isDone
                  ? const Icon(Icons.check_box, color: Color(0xff15B86C))
                  : const Icon(Icons.check_box_outline_blank,
                      color: Colors.grey),
            ),
            title: Text(
              widget.taskModel.title,
              style: TextStyle(
                decoration:
                    isDone ? TextDecoration.lineThrough : TextDecoration.none,
                decorationThickness: 2,
                decorationColor: Colors.grey[600],
                color: state.textcolor,
                fontSize: 16,
                fontFamily: "Poppins",
              ),
            ),
            subtitle: Text(
              widget.taskModel.description,
              style: TextStyle(
                decoration:
                    isDone ? TextDecoration.lineThrough : TextDecoration.none,
                decorationThickness: 2,
                decorationColor: Colors.grey[600],
                color: isDone ? Colors.grey[600] : Colors.grey[600],
                fontSize: 13,
                fontFamily: "Poppins",
              ),
            ),
            trailing: IconButton(
                onPressed: () {}, icon: const Icon(Icons.settings)),
            isThreeLine: true,
          ),
        );
      },
    );
  }
}
