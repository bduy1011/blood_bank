import 'package:animations/animations.dart';
import 'package:flutter/widgets.dart';

class Routes {
  static const String home = "/";
  static const String settings = "/settings";
  static const String bloodHistoryLocations = "/bloodLocations";
  static const String historyDonateBlood = "/historyDonateBlood";
  static const String bloodUsers = "/bloodUsers";
  static const String historyRegisterBuyBlood = "/historyRegisterBuyBlood";
  static const String registerDonateBlood = "/registerDonateBlood";
  static const String management = "/management";
  static const String login = "/login";
  static const String register = '/register';
  static const String registerBuyBlood = '/registerBuyBlood';
  static const String approveBuyBlood = '/approveBuyBlood';
  static const String history = '/history';
  static const String profile = '/profile';
  static const String changePassword = '/changePassword';
  static const String news = '/news';
  static const String splash = '/splash';
  static const String appPage = '/appPage';
  static const String questionAnswer = '/questionAnswer';
  static const String feedback = '/feedback';
  static const String addFeedback = '/feedback/add';
  static const String notification = '/notification';

  static Route<T> fadeThrough<T>(RouteSettings settings, WidgetBuilder page,
      {int duration = 300}) {
    return PageRouteBuilder<T>(
      settings: settings,
      transitionDuration: Duration(milliseconds: duration),
      pageBuilder: (context, animation, secondaryAnimation) => page(context),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeScaleTransition(animation: animation, child: child);
      },
    );
  }
}
