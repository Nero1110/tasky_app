import 'package:depi_flutter_3rd_task/models/user_details_model.dart';
import 'package:depi_flutter_3rd_task/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';

class UserDetailsScreen extends StatelessWidget {
  UserDetailsScreen({super.key});
  final formkey = GlobalKey<FormState>();
  final usernamecontroller = TextEditingController();
  final motivationquotecontroller = TextEditingController();
  final box = Hive.box<UserDetailsModel>("Users");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("New Task")),
      body: Form(
        key: formkey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 30),

            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                CustomTextFormField(
                  controller: usernamecontroller,
                  maximumlines: 1,
                  title: "Usama Elgendy",
                  validatormessage: "Please enter the user name",
                  height: 100,
                  name: "User Name",
                ),
                SizedBox(height: 20),
                CustomTextFormField(
                  controller: motivationquotecontroller,
                  maximumlines: 7,
                  title: "One task at a time. One step closer.",
                  validatormessage: "Please enter the motivation quote",
                  height: 200,
                  name: "Motivation Quote",
                ),

                SizedBox(height: 250),
                SizedBox(
                  width: 343,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (formkey.currentState!.validate()) {
                        await box.putAt(
                          0,
                          UserDetailsModel(
                            motivationQuote: motivationquotecontroller.text,
                            name: usernamecontroller.text,
                          ),
                        );

                        Navigator.pop(context);
                      }
                    },
                    style: Theme.of(context).elevatedButtonTheme.style,
                    child: Row(
                      children: [
                        SizedBox(width: 100),
                        SizedBox(width: 4),
                        Text("Save Changes"),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
