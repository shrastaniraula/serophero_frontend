import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:serophero/features/authentications/data/login/login_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:serophero/features/authentications/login.dart';
import 'package:serophero/features/chat/bloc/chat_list_bloc.dart';
import 'package:khalti_flutter/khalti_flutter.dart';
import 'package:serophero/features/events/bloc/event_bloc.dart';
import 'package:serophero/features/home/bloc/home_bloc.dart';
import 'package:serophero/features/news/bloc/news_bloc.dart';
import 'package:serophero/features/payment/bloc/payment_bloc.dart';
import 'package:serophero/features/reports/bloc/report_bloc.dart';

import 'package:serophero/themes/theme_provider.dart';

import 'features/authentications/bloc/login/login_bloc.dart';

void main() {
  runApp(ChangeNotifierProvider(
      create: (context) => ThemeProvider(), child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
          ),
          BlocProvider(
            create: (context) => PaymentBloc(),
            child: Container(),
          ),
          BlocProvider(
            create: (context) => NewsBloc(),
            child: Container(),
          ),
          BlocProvider(
            create: (context) => EventBloc(),
            child: Container(),
          ),
          BlocProvider(
            create: (context) => ReportBloc(),
            child: Container(),
          ),
          BlocProvider(
            create: (context) => HomeBloc(),
            child: Container(),
          )
        ],
        child: KhaltiScope(
            publicKey: 'test_public_key_43edc68dfab54cb4a49f5adb4505d29d',
            builder: (context, navigatorKey) {
              return MaterialApp(
                navigatorKey: navigatorKey,
                supportedLocales: const [
                  Locale('en', 'US'),
                  Locale('ne', 'NP'),
                ],
                localizationsDelegates: const [
                  KhaltiLocalizations.delegate,
                ],
                debugShowCheckedModeBanner: false,
                theme: Provider.of<ThemeProvider>(context).themeData,
                home: LoginPage(),
              );
            }));
  }
}
