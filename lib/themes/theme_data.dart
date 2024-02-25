import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    hintColor: const Color.fromARGB(255, 69, 69, 69),
    iconTheme: const IconThemeData(color: Colors.black),
    appBarTheme: const AppBarTheme(
        backgroundColor: Color.fromARGB(255, 251, 248, 254),
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        titleTextStyle: TextStyle(color: Colors.black, fontSize: 20)),
    textTheme: GoogleFonts.poppinsTextTheme().copyWith(
      headlineSmall: const TextStyle(fontSize: 30),
      bodySmall: const TextStyle(color: Colors.black, fontSize: 20),
      bodyMedium: const TextStyle(color: Colors.black),
      labelLarge: const TextStyle(
          color: Colors.black, fontSize: 18, fontWeight: FontWeight.normal),
    ),
    floatingActionButtonTheme:
        FloatingActionButtonThemeData(foregroundColor: Colors.white),
    dividerColor: const Color.fromARGB(255, 178, 178, 178),
    scaffoldBackgroundColor: const Color.fromARGB(255, 251, 248, 254),
    colorScheme: const ColorScheme.light(
      background: Colors.black,
      primary: Color.fromRGBO(80, 75, 166, 1), //in buttons
      secondary: Color.fromRGBO(134, 107, 209, 1), //in links
      tertiary: Colors.black,
      primaryContainer:
          Color.fromRGBO(212, 210, 255, 0.848), //used in navigation bar
      onPrimary: Colors.black, //for text value (texttheme) in textfields
    ));

ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    floatingActionButtonTheme:
        FloatingActionButtonThemeData(foregroundColor: Colors.black),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color.fromARGB(255, 21, 21, 21),
      iconTheme: IconThemeData(color: Colors.white),
      titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
    ),
    iconTheme: const IconThemeData(color: Colors.white),
    hintColor: const Color.fromARGB(255, 232, 232, 232),
    scaffoldBackgroundColor: const Color.fromARGB(255, 21, 21, 21),
    textTheme: GoogleFonts.poppinsTextTheme().copyWith(
      headlineSmall: const TextStyle(fontSize: 30),
      bodySmall: const TextStyle(
          color: Color.fromARGB(255, 232, 232, 232), fontSize: 20),
      labelLarge: const TextStyle(
          color: Color.fromARGB(255, 232, 232, 232), fontSize: 18),
      bodyMedium: const TextStyle(color: Color.fromARGB(255, 232, 232, 232)),
    ),
    colorScheme: const ColorScheme.dark(
      background: Colors.black,
      primary: Color.fromRGBO(80, 75, 166, 1),
      secondary: Color.fromRGBO(155, 149, 255, 1),
      tertiary: Colors.white,
      primaryContainer: Color.fromRGBO(130, 124, 253, 0.418),
      onPrimary: Color.fromARGB(255, 194, 194, 194), 
    ));
