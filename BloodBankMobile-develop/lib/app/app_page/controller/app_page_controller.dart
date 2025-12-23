import 'package:auto_size_text/auto_size_text.dart';
import 'package:blood_donation/base/base_view/base_view.dart';
import 'package:flutter/material.dart';

import '../../../features/home/presentation/home_page.dart';
import '../../../features/notification/presentation/notification_page.dart';
import '../../../features/settings/presentation/settings_page.dart';

class AppPageController extends BaseModelStateful {
  ///
  ///
  int activeIndex = 4;
  final AutoSizeGroup bottomTextGroup = AutoSizeGroup();

  final routes = <Widget>[
    const HomePage(),
    const NotificationPage(),
    const HomePage(),
    const SettingsPage(),
    const HomePage(),
  ];

  void onChangeHomeTab() {
    activeIndex = 4;
    refresh();
  }
}
