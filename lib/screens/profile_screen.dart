import 'package:depi_flutter_3rd_task/light_dark_controller/light_dark_cubit.dart';
import 'package:depi_flutter_3rd_task/light_dark_controller/light_dark_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});
  static String title = "My Profile";

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool value = false;
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
      body: BlocBuilder<LightDarkCubit, ThemeState>(
        builder: (context, state) {
          return Column(
            children: [
              SizedBox(height: 55),
              Center(
                child: Stack(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: AssetImage("assets/whatsapp_image.jpg"),
                    ),
                    Positioned(
                      bottom: 0,
                      left: 60,
                      child: CircleAvatar(
                        backgroundColor: state.textcolor,
                        child: Icon(
                          Icons.camera_alt_rounded,
                          color: state.backgroundcolor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                "Nour",
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                  fontSize: 22,
                  fontFamily: "Poppins",
                ),
              ),
              Text(
                "One Task a time , One Step Closer",
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                  fontSize: 15,
                  color: Colors.grey[600],
                ),
              ),
              SizedBox(height: 50),
              Card(
                child: ListTile(
                  leading: SvgPicture.asset("assets/profile.svg"),
                  title: Text(
                    "User Profile",
                    style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      fontSize: 16,
                      fontFamily: "Poppins",
                    ),
                  ),
                  trailing: SvgPicture.asset("assets/arrow.svg"),
                ),
              ),
              Card(
                child: ListTile(
                  leading: SvgPicture.asset("assets/moon.svg"),
                  title: Text(
                    "Dark Mode",
                    style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      fontSize: 16,
                      fontFamily: "Poppins",
                    ),
                  ),
                  trailing: Switch(
                    value: value,
                    onChanged: (value) {
                      setState(() {
                        value;
                      });
                    },
                  ),
                ),
              ),
              Card(
                child: ListTile(
                  leading: SvgPicture.asset("assets/logout.svg"),
                  title: Text(
                    "Log Out",
                    style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      fontSize: 16,
                      fontFamily: "Poppins",
                    ),
                  ),
                  trailing: SvgPicture.asset("assets/arrow.svg"),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
