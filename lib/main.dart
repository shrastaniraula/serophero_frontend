import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:serophero/features/home/navigation.dart';
import 'package:serophero/themes/theme_provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
      create: (context) => ThemeProvider(), child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: Provider.of<ThemeProvider>(context).themeData,
      // darkTheme: darkTheme,
      home: Navigation(),
    );
  }
}
