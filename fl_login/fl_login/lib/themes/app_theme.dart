import 'package:flutter/material.dart';

class AppTheme {
  static const Color primary = Color.fromRGBO(68, 185, 130, 1);
  static const Color textoGeneral = Colors.grey;

  static final ThemeData ligthTheme = ThemeData.light().copyWith(
    scaffoldBackgroundColor: Colors.grey[300],
    inputDecorationTheme: const InputDecorationTheme(
        floatingLabelStyle: TextStyle(color: primary),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: primary),
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10),
                topRight: Radius.circular(10))),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: primary),
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10),
                topRight: Radius.circular(10))),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10),
                topRight: Radius.circular(10)))),
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
            backgroundColor: primary,
            shape: const StadiumBorder(),
            elevation: 5)),
  );
}
