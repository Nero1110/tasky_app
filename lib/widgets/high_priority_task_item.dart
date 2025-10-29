import 'package:depi_flutter_3rd_task/light_dark_controller/light_dark_cubit.dart';
import 'package:depi_flutter_3rd_task/light_dark_controller/light_dark_states.dart';
import 'package:depi_flutter_3rd_task/models/task_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';

class HighPriorityTaskItem extends StatelessWidget {
  const HighPriorityTaskItem({super.key, required this.taskModel});
  final TaskModel taskModel;
  final isdone = true;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LightDarkCubit, ThemeState>(
      builder: (context, state) {
        return SizedBox(
          height: 40,
          child: ListTile(
            horizontalTitleGap: 0,
            contentPadding: const EdgeInsets.only(right: 15),
            tileColor: state.backgroundcolor,
            leading: IconButton(
              onPressed: () async {
                taskModel.isDone = !taskModel.isDone;
                await taskModel.save();
              },
              icon: taskModel.isDone
                  ? const Icon(Icons.check_box, color: Color(0xff15B86C))
                  : const Icon(
                      Icons.check_box_outline_blank,
                      color: Colors.grey,
                    ),
            ),
            title: Text(
              taskModel.title,
              style: TextStyle(
                decoration: taskModel.isDone
                    ? TextDecoration.lineThrough
                    : TextDecoration.none,
                decorationThickness: 2,
                decorationColor: Colors.grey[600],
                color: state.textcolor,
                fontSize: 15,
                fontFamily: "Poppins",
              ),
            ),
          ),
        );
      },
    );
  }
}
