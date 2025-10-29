import 'package:depi_flutter_3rd_task/light_dark_controller/light_dark_cubit.dart';
import 'package:depi_flutter_3rd_task/light_dark_controller/light_dark_states.dart';
import 'package:depi_flutter_3rd_task/models/task_model.dart';
import 'package:depi_flutter_3rd_task/models/user_details_model.dart';
import 'package:depi_flutter_3rd_task/screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(TaskModelAdapter());
  await Hive.openBox<TaskModel>("Tasks");
  Hive.registerAdapter(UserDetailsModelAdapter());
  await Hive.openBox<UserDetailsModel>("Users");
  await Hive.openBox("ThemeBox");
  await Hive.openBox("ImageBox");
  runApp(const TaskyApp());
}

class TaskyApp extends StatelessWidget {
  const TaskyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LightDarkCubit(),
      child: BlocBuilder<LightDarkCubit, ThemeState>(
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: WelcomeScreen(),
            theme: ThemeData(
              colorScheme: state.colorScheme,
              textTheme: TextTheme(
                headlineMedium: TextStyle(
                  fontSize: 28,
                  color: state.textcolor,
                  fontWeight: FontWeight.w400,
                ),
                headlineLarge: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w400,
                  color: state.textcolor,
                ),
              ),
              elevatedButtonTheme: ElevatedButtonThemeData(
                style: ElevatedButton.styleFrom(
                  foregroundColor: state.textcolor,
                  backgroundColor: Color(0xff15B86C),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
