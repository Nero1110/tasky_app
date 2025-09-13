import 'package:depi_flutter_3rd_task/database/app_database.dart';
import 'package:depi_flutter_3rd_task/light_dark_controller/light_dark_cubit.dart';
import 'package:depi_flutter_3rd_task/light_dark_controller/light_dark_states.dart';
import 'package:depi_flutter_3rd_task/models/task_model.dart';
import 'package:depi_flutter_3rd_task/screens/adding_task_screen.dart';
import 'package:depi_flutter_3rd_task/screens/completed_tasks.dart';
import 'package:depi_flutter_3rd_task/screens/profile_screen.dart';
import 'package:depi_flutter_3rd_task/screens/to_do_screen.dart';
import 'package:depi_flutter_3rd_task/widgets/custom_elevated_button.dart';
import 'package:depi_flutter_3rd_task/widgets/task_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:moon_icons/moon_icons.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  SvgPicture wavinghand = SvgPicture.asset(
    "assets/waving-hand-medium-light-skin-tone-svgrepo-com 1 (1).svg",
  );
  List<TaskModel> tasks = [];

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

  bool isdone = true;
  @override
  Widget build(BuildContext context) {
    String username = ModalRoute.of(context)!.settings.arguments.toString();
    showlist();
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
                    padding: const EdgeInsets.only(top: 16, bottom: 32),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 35,
                          backgroundImage: AssetImage(
                            "assets/whatsapp_image.jpg",
                          ),
                        ),
                        SizedBox(width: 23),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Good Evening ,$username",
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineLarge!
                                    .copyWith(fontSize: 20),
                              ),
                              SizedBox(height: 2),

                              Text(
                                "One task at a time,One step \ncloser.",
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
                        ),

                        BlocBuilder<LightDarkCubit, ThemeState>(
                          builder: (context, state) {
                            return Padding(
                              padding: const EdgeInsets.only(
                                bottom: 15,
                                left: 50,
                              ),
                              child: GestureDetector(
                                onTap: () {
                                  if (state is LightState) {
                                    context
                                        .read<LightDarkCubit>()
                                        .darkTheming();
                                  } else {
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
                  SizedBox(height: 100),
                  Text(
                    "My Tasks",
                    style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      fontSize: 22,
                      fontFamily: "Poppins",
                    ),
                  ),
                  SizedBox(height: 20),
                  Expanded(
                    child: ListView.builder(
                      itemCount: tasks.length,
                      itemBuilder: (context, index) {
                        return TaskItem(taskModel: tasks[index]);
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 210, top: 100),
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
