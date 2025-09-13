import 'package:depi_flutter_3rd_task/light_dark_controller/light_dark_cubit.dart';
import 'package:depi_flutter_3rd_task/light_dark_controller/light_dark_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.title,
    required this.validatormessage,
    required this.height,
    required this.name,
    required this.maximumlines,
    required this.controller,
  });
  final String title;
  final String validatormessage;
  final double height;
  final String name;
  final int maximumlines;
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
          alignment: AlignmentGeometry.xy(-0.9, 0),
          child: Text(
            name,
            style: Theme.of(
              context,
            ).textTheme.headlineLarge!.copyWith(fontSize: 22),
          ),
        ),
        SizedBox(height: 7),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: SizedBox(
            height: height,
            width: double.infinity,
            child: BlocBuilder<LightDarkCubit, ThemeState>(
              builder: (context, state) {
                return TextFormField(
                  controller: controller,
                  maxLines: maximumlines,
                  validator: (value) {
                    return value!.isEmpty ? validatormessage : null;
                  },
                  decoration: InputDecoration(
                  
                    counterStyle: TextStyle(color: state.backgroundcolor),
                    fillColor: state.backgroundcolor,
                    filled: true,
                    hintText: title,
                    hintStyle: TextStyle(
                      fontSize: 18,
                      color: Color(0xff6D6D6D),
                      fontWeight: FontWeight.w400,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(color: Color(0xff15B86C))
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(color: Color(0xff15B86C)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(color: Color(0xff15B86C)),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
