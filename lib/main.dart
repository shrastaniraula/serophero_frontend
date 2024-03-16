import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:serophero/features/authentications/data/login/login_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:serophero/features/authentications/login.dart';
import 'package:serophero/features/chat/bloc/chat_list_bloc.dart';
import 'package:serophero/features/chat/chat.dart';
import 'package:serophero/features/home/navigation.dart';

import 'package:serophero/themes/theme_provider.dart';

import 'features/authentications/bloc/login/login_bloc.dart';

void main() {
  runApp(ChangeNotifierProvider(
      create: (context) => ThemeProvider(), child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LoginBloc(loginRepository: LoginRepository()),
          child: Container(),
        ),
        BlocProvider(
          create: (context) => ChatListBloc(),
          child: Container(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: Provider.of<ThemeProvider>(context).themeData,
        // darkTheme: darkTheme,
        home: LoginPage(),
      ),
    );
  }
}
