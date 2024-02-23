// import 'package:serophero/data/model/directories_model.dart';
// import 'package:serophero/screens/business/business_directories.dart';
// import 'package:serophero/screens/business/business_regsitration.dart';
// import 'package:serophero/screens/chats/individual_chat.dart';
// import 'package:serophero/screens/events/event_list.dart';
// import 'package:serophero/screens/events/view_event.dart';
// import 'package:serophero/screens/home.dart';
// import 'package:serophero/screens/loginsignup/login.dart';
// import 'package:serophero/screens/loginsignup/otp.dart';
// import 'package:serophero/screens/loginsignup/signup.dart';
// import 'package:serophero/screens/news/add_news.dart';
// import 'package:serophero/screens/news/news_list.dart';
// import 'package:serophero/screens/news/view_news.dart';
// import 'package:serophero/screens/onboarding.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/navigator.dart';
import 'package:serophero/features/authentications/login.dart';
import 'package:serophero/features/authentications/register.dart';
import 'package:serophero/features/news/add_news.dart';
import 'package:serophero/features/notifications/notification.dart';
// import 'package:serophero/screens/profile/view_profile.dart';
// import 'package:serophero/screens/reports/report.dart';

// import 'package:serophero/login_signup/login.dart';
// import 'package:serophero/login_signup/register.dart';

class GeneratedRoute {
  Route onGeneratedRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case "/":
        return MaterialPageRoute(builder: (_) => LoginPage());
      // case "/onboarding":
      //   return MaterialPageRoute(builder: (_) => OnBoarding());
      // case "/home":
      //   return MaterialPageRoute(builder: (_) => Home());
      case "/login":
        return MaterialPageRoute(builder: (_) => LoginPage());
      case "/signup":
        return MaterialPageRoute(builder: (_) => SignupPage());
      case "/notification":
        return MaterialPageRoute(builder: (_) => Notifications());
      // case "/otp":
      //   // Check if arguments are provided and return the OTP route accordingly
      //   final otp_key =
      //       (routeSettings.arguments as Map<String, dynamic>)['otp_key'];
      //   final email =
      //       (routeSettings.arguments as Map<String, dynamic>)['email'];

      //   return MaterialPageRoute(
      //     builder: (_) => VerifyOtp(
      //       otp_key: otp_key ?? '',
      //       email: email ?? '',
      //     ),
      //   );

      // case "/directories":
      //   return MaterialPageRoute(builder: (_) => BusinessDirectories());
      // case "/view_profile":
      //   final user = (routeSettings.arguments as Map<String, dynamic>)['user'];
      //   final business =
      //       (routeSettings.arguments as Map<String, dynamic>)['business'];

      //   return MaterialPageRoute(
      //     builder: (_) => ViewProfile(
      //       user: user,
      //       business: business ?? Business(id: 0, name: "", description: ""),
      //     ),
      //   );
      // case "/business_registration":
      //   return MaterialPageRoute(builder: (_) => BusinessRegistration());
      // case "/events_list":
      //   return MaterialPageRoute(builder: (_) => Event());
      // case "/news_list":
      //   return MaterialPageRoute(builder: (_) => NewsList());
      // case "/view_news":
      //   return MaterialPageRoute(builder: (_) => ViewNews());
      // case "/view_events":
      //   return MaterialPageRoute(builder: (_) => ViewEvent());
      case "/add_news":
        return MaterialPageRoute(builder: (_) => AddNews());
      // case "/report":
      //   return MaterialPageRoute(builder: (_) => Report());
      // case "/chat":
      //   return MaterialPageRoute(builder: (_) => Chat());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Column(
              children: [
                Text("This route ${routeSettings.name} doesn't exist")
              ],
            ),
          ),
        );
    }
  }
}
