import 'package:blood_donation/core/localization/app_locale.dart';
import 'package:flutter/material.dart';

enum HomeMenuType {
  profile,
  setting,
  about,
  logout;

  String title(BuildContext context) {
    switch (this) {
      case HomeMenuType.profile:
        return AppLocale.yourAccount.translate(context);
      case HomeMenuType.setting:
        return AppLocale.settings.translate(context);
      case HomeMenuType.about:
        return AppLocale.softwareInformation.translate(context);
      case HomeMenuType.logout:
        return AppLocale.logout.translate(context);
    }
  }

  String get icon{
    switch (this) {
      case HomeMenuType.profile:
        return "assets/icons/ic_home_profile.svg";
      case HomeMenuType.setting:
        return "assets/icons/ic_home_setting.svg";
      case HomeMenuType.about:
        return "assets/icons/ic_home_info.svg";
      case HomeMenuType.logout:
        return "assets/icons/ic_home_logout.svg";
    }
  }
}
