import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    appBarTheme: const AppBarTheme(
      backgroundColor: Color.fromARGB(255, 21, 21, 21),
      iconTheme: IconThemeData(color: Colors.white),
    ),
    iconTheme: IconThemeData(color: Colors.white),

    // textTheme: TextTheme(T),
    hintColor: const Color.fromARGB(255, 232, 232, 232),
    scaffoldBackgroundColor: Color.fromARGB(255, 21, 21, 21),
    textTheme: GoogleFonts.poppinsTextTheme().copyWith(
      headlineSmall: TextStyle(fontSize: 30),
      // bodySmall: TextStyle(color: const Color.fromARGB(255, 164, 164, 164)),
      bodyMedium: const TextStyle(color: Color.fromARGB(255, 232, 232, 232)),
    ),
    colorScheme: const ColorScheme.dark(
        background: Colors.black,
        primary: Color.fromRGBO(80, 75, 166, 1),
        secondary: Color.fromRGBO(155, 149, 255, 1),
        tertiary: Colors.white));
