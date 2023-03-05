import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class Themes {
  static final lightTheme = ThemeData(
      fontFamily: "poppins",
      scaffoldBackgroundColor: Vx.blue100,
      cardColor: Vx.blue200,
      dividerColor: Vx.gray300,
      appBarTheme: AppBarTheme(backgroundColor: Vx.blue100),
      primaryColor: Vx.black,
      iconTheme: IconThemeData(color: Vx.gray400));

  static final darkTheme = ThemeData(
      fontFamily: "poppins",
      scaffoldBackgroundColor: Vx.black,
      primaryColor: Vx.white,
      cardColor: Vx.gray700,
      dividerColor: Vx.white,
      appBarTheme: AppBarTheme(backgroundColor: Vx.black),
      iconTheme: IconThemeData(color: Vx.white));
}
