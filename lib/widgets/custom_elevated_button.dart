import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.title,
     this.formkey,
    this.onpressed,
  });
  final String title;
  final GlobalKey<FormState>? formkey;
  final void Function()? onpressed;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 343,
      child: ElevatedButton(

        onPressed: onpressed,
        style: Theme.of(context).elevatedButtonTheme.style,
        child: Text(title),
      ),
    );
  }
}
