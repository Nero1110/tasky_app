import 'dart:convert';

import 'package:depi_flutter_3rd_task/light_dark_controller/light_dark_cubit.dart';
import 'package:depi_flutter_3rd_task/light_dark_controller/light_dark_states.dart';
import 'package:depi_flutter_3rd_task/models/task_model.dart';
import 'package:depi_flutter_3rd_task/models/user_details_model.dart';
import 'package:depi_flutter_3rd_task/screens/adding_task_screen.dart';
import 'package:depi_flutter_3rd_task/screens/completed_tasks.dart';
import 'package:depi_flutter_3rd_task/screens/profile_screen.dart';
import 'package:depi_flutter_3rd_task/screens/to_do_screen.dart';
import 'package:depi_flutter_3rd_task/widgets/custom_elevated_button.dart';
import 'package:depi_flutter_3rd_task/widgets/high_priority_task_item.dart';
import 'package:depi_flutter_3rd_task/widgets/task_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:moon_icons/moon_icons.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  SvgPicture wavinghand = SvgPicture.asset(
    "assets/waving-hand-medium-light-skin-tone-svgrepo-com 1 (1).svg",
  );

  final tasksbox = Hive.box<TaskModel>("Tasks");
  final usersbox = Hive.box<UserDetailsModel>("Users");
  final themebox = Hive.box("ThemeBox");

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocBuilder<LightDarkCubit, ThemeState>(
        builder: (context, state) {
          return Scaffold(
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 16, bottom: 0),
                    child: ValueListenableBuilder(
                      valueListenable: Hive.box("ImageBox").listenable(),
                      builder: (context, value, child) {
                        return Row(
                          children: [
                            CircleAvatar(
                              radius: 35,
                              backgroundImage: value.get("profileImage")== null
                                  ? AssetImage("assets/whatsapp_image.jpg")
                                  : MemoryImage(base64Decode(value.get("profileImage"))) 
                            ),
                            SizedBox(width: 13),
                            ValueListenableBuilder(
                              valueListenable: usersbox.listenable(),
                              builder: (context, value, child) {
                                return Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Good Evening, ${value.values.toList()[0].name}",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineLarge!
                                            .copyWith(
                                              fontSize: 18,
                                              fontFamily: "Poppins",
                                            ),
                                      ),
                                      SizedBox(height: 6),

                                      Text(
                                        value.values
                                            .toList()[0]
                                            .motivationQuote,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineLarge!
                                            .copyWith(
                                              fontSize: 15,
                                              color: Colors.grey[600],
                                            ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),

                            BlocBuilder<LightDarkCubit, ThemeState>(
                              builder: (context, state) {
                                return Padding(
                                  padding: const EdgeInsets.only(
                                    bottom: 15,
                                    left: 0,
                                  ),
                                  child: GestureDetector(
                                    onTap: () async {
                                      if (themebox.get(
                                            "islight",
                                            defaultValue: true,
                                          ) ==
                                          true) {
                                        await themebox.put("islight", false);
                                        context
                                            .read<LightDarkCubit>()
                                            .darkTheming();
                                      } else {
                                        await themebox.put("islight", true);
                                        context
                                            .read<LightDarkCubit>()
                                            .lightTheming();
                                      }
                                    },
                                    child: CircleAvatar(
                                      radius: 20,
                                      backgroundColor: state.backgroundcolor,
                                      child: state.icon,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Yuhuu ,Your work Is ",
                        style: TextStyle(color: state.textcolor, fontSize: 35),
                      ),
                      Row(
                        children: [
                          Text(
                            "almost done ! ",
                            style: TextStyle(
                              color: state.textcolor,
                              fontSize: 35,
                            ),
                          ),
                          SvgPicture.asset(
                            "assets/waving-hand-medium-light-skin-tone-svgrepo-com 1 (1).svg",
                            height: 40,
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  ValueListenableBuilder(
                    valueListenable: tasksbox.listenable(),
                    builder: (context, value, child) {
                      final CompletedTasks = value.values
                          .where((element) => element.isDone)
                          .toList();
                      final tasks = value.values.toList();
                      final percent = tasks.isEmpty
                          ? 0.0
                          : CompletedTasks.length / tasks.length;
                      return Container(
                        decoration: BoxDecoration(
                          color: state.backgroundcolor,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        height: 72,
                        width: 343,
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 10,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Achieved Tasks",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineMedium!
                                        .copyWith(
                                          fontSize: 18,
                                          fontFamily: "Poppins",
                                        ),
                                  ),
                                  Text(
                                    "${CompletedTasks.length} out of ${tasks.length} Done",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineMedium!
                                        .copyWith(fontSize: 14),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                bottom: 10,
                                left: 110,
                              ),
                              child: CircularPercentIndicator(
                                animateToInitialPercent: true,
                                animateFromLastPercent: true,
                                animationDuration: 1000,
                                circularStrokeCap: CircularStrokeCap.round,
                                radius: 25,
                                lineWidth: 4,
                                animation: true,
                                backgroundColor: Colors.grey.shade300,
                                percent: percent.clamp(0.0, 1.0),
                                center: Text("${(percent * 100).toInt()}%"),
                                progressColor: Color(0xff15B86C),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: ValueListenableBuilder(
                      valueListenable: tasksbox.listenable(),
                      builder: (context, value, child) {
                        final highprioritytasks = value.values
                            .where((element) => element.isHighpriority)
                            .toList();
                        return Container(
                          height: 183,
                          width: 343,
                          decoration: BoxDecoration(
                            color: state.backgroundcolor,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                  top: 12,
                                  left: 16,
                                  bottom: 2,
                                ),
                                child: Text(
                                  "High Priority Tasks",
                                  style: Theme.of(context)
                                      .textTheme
                                      .displayLarge!
                                      .copyWith(
                                        fontSize: 17,
                                        color: Color(0xff15B86C),
                                      ),
                                ),
                              ),
                              Expanded(
                                child: ListView.builder(
                                  itemCount: highprioritytasks.length,
                                  itemBuilder: (context, index) {
                                    return HighPriorityTaskItem(
                                      taskModel: highprioritytasks[index],
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),

                  SizedBox(height: 10),
                  Text(
                    "My Tasks",
                    style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      fontSize: 22,
                      fontFamily: "Poppins",
                    ),
                  ),
                  SizedBox(height: 20),
                  ValueListenableBuilder(
                    valueListenable: tasksbox.listenable(),
                    builder: (context, value, child) {
                      return Expanded(
                        child: ListView.builder(
                          itemCount: value.values.length,
                          itemBuilder: (context, index) {
                            return TaskItem(
                              taskModel: value.values.toList()[index],
                            );
                          },
                        ),
                      );
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 210),
                    child: SizedBox(
                      width: 167,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return AddingTaskScreen();
                              },
                            ),
                          );
                        },
                        style: Theme.of(context).elevatedButtonTheme.style,
                        child: Row(
                          children: [
                            SizedBox(width: 15),
                            Icon(Icons.add),
                            SizedBox(width: 4),
                            Text("Add Task"),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
