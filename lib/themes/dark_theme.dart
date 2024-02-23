import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    appBarTheme: const AppBarTheme(
      backgroundColor: Color.fromARGB(255, 21, 21, 21),
      iconTheme: IconThemeData(color: Colors.white),
      titleTextStyle: TextStyle(color: Colors.white, fontSize: 22),
    ),
    iconTheme: IconThemeData(color: Colors.white),
    hintColor: const Color.fromARGB(255, 232, 232, 232),
    scaffoldBackgroundColor: Color.fromARGB(255, 21, 21, 21),
    textTheme: GoogleFonts.poppinsTextTheme().copyWith(
      headlineSmall: TextStyle(fontSize: 30),
      bodySmall: TextStyle(
          color: const Color.fromARGB(255, 232, 232, 232), fontSize: 20),
      bodyMedium: const TextStyle(color: Color.fromARGB(255, 232, 232, 232)),
    ),
    colorScheme: const ColorScheme.dark(
      background: Colors.black,
      primary: Color.fromRGBO(80, 75, 166, 1),
      secondary: Color.fromRGBO(155, 149, 255, 1),
      tertiary: Colors.white,
      primaryContainer: Color.fromRGBO(130, 124, 253, 0.418),
    ));
