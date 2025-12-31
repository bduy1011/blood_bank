import 'package:blood_donation/core/localization/app_locale.dart';
import 'package:flutter/material.dart';

enum NavigationType {
  home,
  notification,
  register,
  setting;

  String get icon {
    switch (this) {
      case NavigationType.home:
        return "assets/icons/ic_navigation_home.svg";
      case NavigationType.notification:
        return "assets/icons/ic_home_notification.svg";
      case NavigationType.register:
        return "assets/icons/ic_home_register.svg";
      case NavigationType.setting:
        return "assets/icons/ic_home_profile.svg";
    }
  }

  String title(BuildContext context) {
    switch (this) {
      case NavigationType.home:
        return AppLocale.home.translate(context);
      case NavigationType.notification:
        return AppLocale.notification.translate(context);
      case NavigationType.register:
        return AppLocale.register.translate(context);
      case NavigationType.setting:
        return AppLocale.personal.translate(context);
    }
  }
}
