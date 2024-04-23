import 'package:flutter/material.dart';
import 'package:serophero/features/authentications/email_pass_reset.dart';
import 'package:serophero/features/authentications/login.dart';
import 'package:serophero/features/authentications/password_reset.dart';
import 'package:serophero/features/authentications/register.dart';
import 'package:serophero/features/authentications/verify_otp.dart';
import 'package:serophero/features/business/business_directories.dart';
import 'package:serophero/features/business/business_regsitration.dart';
import 'package:serophero/features/chat/chat.dart';

import 'package:serophero/features/events/add_event.dart';
import 'package:serophero/features/events/view_event.dart';
import 'package:serophero/features/home/navigation.dart';
import 'package:serophero/features/news/add_news.dart';
import 'package:serophero/features/news/personal_news_list.dart';
import 'package:serophero/features/news/view_news.dart';
import 'package:serophero/features/notifications/notification.dart';
import 'package:serophero/features/payment/payment_history.dart';
import 'package:serophero/features/payment/payment_initiation.dart';
import 'package:serophero/features/profile/edit_profile.dart';
import 'package:serophero/features/profile/view_profile.dart';
import 'package:serophero/features/reports/report.dart';
import 'package:serophero/suggestions/make_suggestions.dart';
import 'package:serophero/suggestions/view_suggestions.dart';

class GeneratedRoute {
  Route onGeneratedRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      // case "/":
      //   return MaterialPageRoute(builder: (_) => LoginPage());
      // case "/onboarding":
      //   return MaterialPageRoute(builder: (_) => OnBoarding());
      case "/login":
        return MaterialPageRoute(builder: (_) => const LoginPage());
      case "/signup":
        return MaterialPageRoute(builder: (_) => const SignupPage());
      case "/notification":
        return MaterialPageRoute(builder: (_) => const Notifications());
      case "/home":
        return MaterialPageRoute(builder: (_) => Navigation());
      case "/otp":
        // Check if arguments are provided and return the OTP route accordingly
        final otpKey =
            (routeSettings.arguments as Map<String, dynamic>)['otp_key'];
        final email =
            (routeSettings.arguments as Map<String, dynamic>)['email'];
        final purpose =
            (routeSettings.arguments as Map<String, dynamic>)['purpose'];

        return MaterialPageRoute(
          builder: (_) => VerifyOtpPage(
            otpKey: otpKey ?? '',
            email: email ?? '',
            purpose: purpose ?? '',
          ),
        );
      case "/email_reset_pass":
        return MaterialPageRoute(builder: (_) => EmailPassword());
      case "/change_password":
        return MaterialPageRoute(builder: (_) => const ChangePassword());

      case "/directories":
        return MaterialPageRoute(builder: (_) => const Directories());
      case "/edit_profile":
        final profile =
            (routeSettings.arguments as Map<String, dynamic>)['profile'];

        return MaterialPageRoute(
          builder: (_) => EditProfile(
            profile: profile,
          ),
        );
      // return MaterialPageRoute(builder: (_) => EditProfile());

      case "/payment":
        return MaterialPageRoute(builder: (_) => PaymentInitiation());
      case "/transaction_history":
        return MaterialPageRoute(builder: (_) => TransactionHistoryPage());
      case "/view_profile":
        final userId =
            (routeSettings.arguments as Map<String, dynamic>)['userId'];

        return MaterialPageRoute(
          builder: (_) => ViewProfile(
            userId: userId,
          ),
        );
      case "/business_registration":
        return MaterialPageRoute(builder: (_) => const BusinessRegister());
      case "/view_news":
        final news = (routeSettings.arguments as Map<String, dynamic>)['news'];
        return MaterialPageRoute(
            builder: (_) => ViewNews(
                  news: news,
                ));

      case "/personal_news":
        return MaterialPageRoute(builder: (_) => const PersonalNews());
      case "/view_events":
        final event =
            (routeSettings.arguments as Map<String, dynamic>)['event'];

        return MaterialPageRoute(
            builder: (_) => ViewEvent(
                  event: event,
                ));
      case "/add_news":
        return MaterialPageRoute(builder: (_) => const AddNews());
      case "/add_event":
        return MaterialPageRoute(builder: (_) => const AddEvent());
      case "/view_suggestions":
        return MaterialPageRoute(builder: (_) => const ViewSuggestions());
      case "/drop_suggestions":
        return MaterialPageRoute(builder: (_) => const DropSuggestions());
      case "/chat_page":
        final userId =
            (routeSettings.arguments as Map<String, dynamic>)['userId'];
        final myId = (routeSettings.arguments as Map<String, dynamic>)['myId'];
        return MaterialPageRoute(
          builder: (_) => ChatScreen(
            userId: userId,
            myId: myId,
          ),
        );
      case "/report":
        final id = (routeSettings.arguments as Map<String, dynamic>)['id'];
        final type = (routeSettings.arguments as Map<String, dynamic>)['type'];

        return MaterialPageRoute(
          builder: (_) => Report(
            id: id,
            type: type,
          ),
        );

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
