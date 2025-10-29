import 'package:depi_flutter_3rd_task/light_dark_controller/light_dark_cubit.dart';
import 'package:depi_flutter_3rd_task/light_dark_controller/light_dark_states.dart';
import 'package:depi_flutter_3rd_task/screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:async';

import 'package:flutter_svg/flutter_svg.dart';

class SplashScreen extends StatefulWidget {
  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    )..repeat(reverse: true); // Animation رايح جاي

    _animation = Tween<double>(
      begin: 0.8,
      end: 1.2,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
    Timer(Duration(seconds: 8), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) {
            return WelcomeScreen();
          },
        ),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LightDarkCubit, ThemeState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: state.backgroundcolor,

          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 350, left: 130),
                child: ScaleTransition(
                  scale: _animation,
                  child: SvgPicture.asset(
                    "assets/taskyLogo.svg",
                    height: 140,
                    width: 140,
                  ),
                ),
              ),
            ],
          ),
          // body:
          //   child:
        );
      },
    );
  }
}
