import 'package:depi_flutter_3rd_task/database/app_database.dart';
import 'package:depi_flutter_3rd_task/light_dark_controller/light_dark_cubit.dart';
import 'package:depi_flutter_3rd_task/light_dark_controller/light_dark_states.dart';
import 'package:depi_flutter_3rd_task/screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
await  AppDatabase().database;
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
