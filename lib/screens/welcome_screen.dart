import 'package:depi_flutter_3rd_task/models/user_details_model.dart';
import 'package:depi_flutter_3rd_task/screens/adding_task_screen.dart';
import 'package:depi_flutter_3rd_task/screens/home_screen.dart';
import 'package:depi_flutter_3rd_task/screens/navigation_screen.dart';
import 'package:depi_flutter_3rd_task/widgets/custom_elevated_button.dart';
import 'package:depi_flutter_3rd_task/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';

class WelcomeScreen extends StatelessWidget {
  WelcomeScreen({super.key});
  final formkey = GlobalKey<FormState>();
  final TextEditingController controller = TextEditingController();
  final usersbox = Hive.box<UserDetailsModel>("Users");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    left: 143,
                    right: 120.5,
                    top: 50,
                  ),
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        "assets/taskyLogo.svg",
                        height: 42,
                        width: 42,
                      ),
                      SizedBox(width: 5),
                      Text(
                        "Tasky",
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 165),
                Row(
                  children: [
                    SizedBox(width: 75),
                    Text(
                      "Welcome to Tasky",
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                    SvgPicture.asset(
                      "assets/waving-hand-medium-light-skin-tone-svgrepo-com 1 (1).svg",
                    ),
                  ],
                ),
                SizedBox(height: 5),
                Text(
                  "Your Productivity Journey Starts here",
                  style: Theme.of(
                    context,
                  ).textTheme.headlineLarge!.copyWith(fontSize: 18),
                ),
                SizedBox(height: 24),
                SvgPicture.asset("assets/working.svg"),
                SizedBox(height: 30),

                CustomTextFormField(
                  controller: controller,
                  maximumlines: 1,
                  name: "Full name",
                  height: 100,
                  title: "e.g. Sarah Khalid",
                  validatormessage: "Your name is required",
                ),
                CustomButton(
                  title: "Let's Get Started",
                  formkey: formkey,
                  onpressed: () async {
                    formkey.currentState!.validate();
                    if (formkey.currentState!.validate()) {
                      if (usersbox.isEmpty) {
                        await usersbox.add(
                          UserDetailsModel(
                            motivationQuote:
                                "One task at a time ,One step closer",
                            name: controller.text,
                          ),
                        );
                      }
                      await usersbox.putAt(
                        0,
                        UserDetailsModel(
                          motivationQuote:
                              "One task at a time ,One step closer",
                          name: controller.text,
                        ),
                      );
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          settings: RouteSettings(arguments: controller.text),
                          builder: (context) {
                            return NavigationScreen();
                          },
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
