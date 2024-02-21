import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    hintColor: Color.fromARGB(255, 69, 69, 69),
    iconTheme: IconThemeData(color: Colors.black),
    appBarTheme: const AppBarTheme(
        backgroundColor: Color.fromARGB(255, 251, 248, 254),
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        titleTextStyle: TextStyle(color: Colors.black)),
    textTheme: GoogleFonts.poppinsTextTheme()
        .copyWith(headlineSmall: TextStyle(fontSize: 30)),
    scaffoldBackgroundColor: const Color.fromARGB(255, 251, 248, 254),
    colorScheme: const ColorScheme.light(
        background: Colors.black,
        primary: Color.fromRGBO(80, 75, 166, 1),
        secondary: Color.fromRGBO(134, 107, 209, 1),
        tertiary: Colors.black));
