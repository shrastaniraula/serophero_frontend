import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:serophero/features/authentications/bloc/otp_pass/otp_pass_bloc.dart';
import 'package:serophero/features/authentications/bloc/signup/signup_bloc.dart';
import 'package:serophero/features/authentications/data/login/login_repo.dart';
import 'package:serophero/features/authentications/login.dart';
import 'package:serophero/features/business/bloc/directories_bloc.dart';
import 'package:serophero/features/chat/bloc/chat_list_bloc.dart';
import 'package:serophero/features/events/bloc/event_bloc.dart';
import 'package:serophero/features/home/bloc/home_bloc.dart';
import 'package:serophero/features/home/navigation.dart';
import 'package:serophero/features/news/bloc/news/news_bloc.dart';
import 'package:serophero/features/news/bloc/personal_news/personal_news_bloc.dart';
import 'package:serophero/features/notifications/bloc/notification_bloc.dart';
import 'package:serophero/features/payment/bloc/payment_bloc.dart';
import 'package:serophero/features/profile/bloc/edit_profile_bloc.dart';
import 'package:serophero/features/profile/cubit/image_cubit.dart';
import 'package:serophero/features/reports/bloc/report_bloc.dart';
import 'package:serophero/notification_services.dart';
import 'package:serophero/suggestions/bloc/suggestions_bloc.dart';
import 'package:serophero/themes/theme_provider.dart';
import 'package:khalti_flutter/khalti_flutter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:serophero/utils/shared_preferences.dart';
import 'features/authentications/bloc/login/login_bloc.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: 'AIzaSyAlo4Z1w15JHiwdh60iySIov9_nrqjjoE0',
          appId: '1:750238724164:android:82016682009e4d530d8c11',
          messagingSenderId: '750238724164',
          projectId: 'serophero-1f758'));

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  // FlutterNativeSplash.remove();

  runApp(ChangeNotifierProvider(
      create: (context) => ThemeProvider(), child: const MyApp()));
  // runApp(const MainWidget());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  NotificationServices notificationServices = NotificationServices();
  // String? token = '';
  String token = '';

  @override
  void initState() {
    super.initState();
    getToken();

    notificationServices.requestNotificationPermission();
    notificationServices.forgroundMessage();
    notificationServices.firebaseInit(context);
    notificationServices.setupInteractMessage(context);
    notificationServices.isTokenRefresh();
    notificationServices.getDeviceToken().then((value) {
      if (kDebugMode) {
        print('device token');
        print(value);
      }
    });

    // DeviceInfo.androidInfo();
  }

  void getToken() async {
    String fetchedToken = await SharedUtils.getToken();
    setState(() {
      token = fetchedToken;
    });
    print('Token value: $token');
  }

  // value checkToken() async {}

  @override
  Widget build(BuildContext context) {
    // Future<String> token = SharedUtils.getToken();
    // print(token.);

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
            create: (context) => StoreImageCubit(),
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
          ),
          BlocProvider(
            create: (context) => BusinessBloc(),
            child: Container(),
          ),
          BlocProvider(
            create: (context) => EditProfileBloc(),
            child: Container(),
          ),
          BlocProvider(
            create: (context) => SignupBloc(),
            child: Container(),
          ),
          BlocProvider(
            create: (context) => OtpPassBloc(),
            child: Container(),
          ),
          BlocProvider(
            create: (context) => SuggestionsBloc(),
            child: Container(),
          ),
          BlocProvider(
            create: (context) => NotificationBloc(),
            child: Container(),
          ),
          BlocProvider(
            create: (context) => PersonalNewsBloc(),
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
                  home: token == '' ? LoginPage() : Navigation());
            }));
  }
}
