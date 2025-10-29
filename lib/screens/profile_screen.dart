import 'dart:convert';
import 'dart:io';

import 'package:depi_flutter_3rd_task/light_dark_controller/light_dark_cubit.dart';
import 'package:depi_flutter_3rd_task/light_dark_controller/light_dark_states.dart';
import 'package:depi_flutter_3rd_task/models/user_details_model.dart';
import 'package:depi_flutter_3rd_task/screens/user_details_screen.dart';
import 'package:depi_flutter_3rd_task/services/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';

class ProfileScreen extends StatelessWidget {
  bool value = false;
  static String title = "My Profile";
  final box = Hive.box<UserDetailsModel>("Users");
  final themeboox = Hive.box("ThemeBox");
  ProfileScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "My Profile",
          style: Theme.of(
            context,
          ).textTheme.headlineMedium!.copyWith(fontSize: 20),
        ),
      ),
      body: BlocBuilder<LightDarkCubit, ThemeState>(
        builder: (context, state) {
          return ValueListenableBuilder(
            valueListenable: box.listenable(),
            builder: (context, value, child) {
              return Column(
                children: [
                  SizedBox(height: 55),
                  Center(
                    child: Stack(
                      children: [
                        ValueListenableBuilder(
                          valueListenable: Hive.box("ImageBox").listenable(),
                          builder: (context, value, child) {
                            return CircleAvatar(
                              radius: 50,
                              backgroundImage: value.get("profileImage")== null
                                  ?AssetImage("assets/whatsapp_image.jpg") 
                                  : MemoryImage(base64Decode(value.get("profileImage")))
                            );
                          }
                        ),
                        Positioned(
                          bottom: 0,
                          left: 60,
                          child: GestureDetector(
                            onTap: () async {
                              await PhotoPicker().pickProfileImage();
                            },
                            child: CircleAvatar(
                              backgroundColor: state.textcolor,
                              child: Icon(
                                Icons.camera_alt_rounded,
                                color: state.backgroundcolor,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    value.values.toList()[0].name,
                    style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      fontSize: 22,
                      fontFamily: "Poppins",
                    ),
                  ),
                  Text(
                    value.values.toList()[0].motivationQuote,
                    style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      fontSize: 15,
                      color: Colors.grey[600],
                    ),
                  ),
                  SizedBox(height: 50),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return UserDetailsScreen();
                          },
                        ),
                      );
                    },
                    child: Card(
                      child: ListTile(
                        leading: SvgPicture.asset(
                          "assets/profile.svg",
                          color: state.textcolor,
                        ),
                        title: Text(
                          "User Profile",
                          style: Theme.of(context).textTheme.headlineMedium!
                              .copyWith(fontSize: 16, fontFamily: "Poppins"),
                        ),
                        trailing: SvgPicture.asset("assets/arrow.svg"),
                      ),
                    ),
                  ),
                  ValueListenableBuilder(
                    valueListenable: themeboox.listenable(),
                    builder: (context, mybox, child) {
                      return Card(
                        child: ListTile(
                          leading: SvgPicture.asset(
                            "assets/moon.svg",
                            color: state.textcolor,
                          ),
                          title: Text(
                            "Dark Mode",
                            style: Theme.of(context).textTheme.headlineMedium!
                                .copyWith(fontSize: 16, fontFamily: "Poppins"),
                          ),
                          trailing: BlocBuilder<LightDarkCubit, ThemeState>(
                            builder: (context, state) {
                              return Switch(
                                value: mybox.get("islight") ?? false,
                                onChanged: (value) async {
                                  if (mybox.get(
                                        "islight",
                                        defaultValue: true,
                                      ) ==
                                      true) {
                                    await mybox.put("islight", false);
                                    context
                                        .read<LightDarkCubit>()
                                        .darkTheming();
                                  } else {
                                    await mybox.put("islight", true);
                                    context
                                        .read<LightDarkCubit>()
                                        .lightTheming();
                                  }
                                },
                              );
                            },
                          ),
                        ),
                      );
                    },
                  ),
                  GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text(
                              "Are you sure?",
                              style: Theme.of(context).textTheme.headlineMedium!
                                  .copyWith(fontSize: 18),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  exit(0);
                                },
                                child: Text(
                                  "Yes",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineMedium!
                                      .copyWith(fontSize: 15),
                                ),
                              ),

                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  "No",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineMedium!
                                      .copyWith(fontSize: 15),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: Card(
                      child: ListTile(
                        leading: SvgPicture.asset(
                          "assets/logout.svg",
                          color: state.textcolor,
                        ),
                        title: Text(
                          "Log Out",
                          style: Theme.of(context).textTheme.headlineMedium!
                              .copyWith(fontSize: 16, fontFamily: "Poppins"),
                        ),
                        trailing: SvgPicture.asset("assets/arrow.svg"),
                      ),
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
