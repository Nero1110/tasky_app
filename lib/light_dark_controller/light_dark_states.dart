import 'package:flutter/material.dart';
import 'package:moon_icons/moon_icons.dart';

sealed class ThemeState {
  Icon? icon;
  Color? backgroundcolor;
  ColorScheme? colorScheme;
  Color? textcolor;
  ThemeState({
    this.icon,
    this.backgroundcolor,
    this.colorScheme,
    this.textcolor,
  });
}

class LightState extends ThemeState {
  LightState()
    : super(
        icon: Icon(
          MoonIcons.other_moon_16_light,
          color: Color(0xff282828),
          size: 32,
        ),
        backgroundcolor: Colors.grey[300],
        colorScheme: ColorScheme.light(),
        textcolor: Color(0xff282828),
      );
}

class DarkState extends ThemeState {
  DarkState()
    : super(
        icon: Icon(Icons.wb_sunny_outlined, color: Color(0xffFFFCFC)),
        backgroundcolor: Color(0xff282828),
        colorScheme: ColorScheme.dark(),
        textcolor: Color(0xffFFFCFC),
      );
}
