import 'package:depi_flutter_3rd_task/models/task_model.dart';
import 'package:depi_flutter_3rd_task/widgets/custom_elevated_button.dart';
import 'package:depi_flutter_3rd_task/widgets/custom_text_field.dart';
import 'package:depi_flutter_3rd_task/widgets/task_item.dart';
import 'package:flutter/material.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';

class AddingTaskScreen extends StatefulWidget {
  AddingTaskScreen({super.key});

  @override
  State<AddingTaskScreen> createState() => _AddingTaskScreenState();
}

class _AddingTaskScreenState extends State<AddingTaskScreen> {
  final formkey = GlobalKey<FormState>();

  final titlecontroller = TextEditingController();

  final descriptioncontroller = TextEditingController();

  final bool isDone = false;

  bool isHighpriority = false;

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
                  controller: titlecontroller,
                  maximumlines: 1,
                  title: "Finish UI design for login screen ",
                  validatormessage: "Please enter the task name",
                  height: 100,
                  name: "Task Name",
                ),
                SizedBox(height: 20),
                CustomTextFormField(
                  controller: descriptioncontroller,
                  maximumlines: 7,
                  title:
                      "Finish onboarding UI and hand off to devs by Thursday",
                  validatormessage: "Please enter the task description",
                  height: 200,
                  name: "Task Description",
                ),

                Padding(
                  padding: const EdgeInsets.only(left: 14, right: 10, top: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "High Priority",
                        style: Theme.of(
                          context,
                        ).textTheme.headlineLarge!.copyWith(fontSize: 22),
                      ),
                      Switch(
                        value: isHighpriority,
                        activeThumbColor: Colors.white,
                        activeTrackColor: Color(0xff15B86C),
                        onChanged: (value) {
                          setState(() {
                            isHighpriority = value;
                          });
                        },
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 200),
                SizedBox(
                  width: 343,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (formkey.currentState!.validate()) {
                        await Hive.box<TaskModel>("Tasks").add(
                          TaskModel(
                            title: titlecontroller.text,
                            description: descriptioncontroller.text,
                            isDone: isDone,
                            createdAt: DateTime.now(),
                            isHighpriority: isHighpriority,
                          ),
                        );

                        Navigator.pop(context);
                      }
                    },
                    style: Theme.of(context).elevatedButtonTheme.style,
                    child: Row(
                      children: [
                        SizedBox(width: 100),
                        Icon(Icons.add),
                        SizedBox(width: 4),
                        Text("Add Task"),
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
