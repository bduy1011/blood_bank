import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../app/app_util/app_center.dart';
import '../../app/theme/themes.dart';
import '../../di/injector.dart';

extension Style on BuildContext {
  AppThemeData get myTheme => getIt<AppCenter>().state.appTheme;
}

extension ScreenSize on BuildContext {
  double get screenHeight => MediaQuery.of(this).size.height;
  double get screenWidth => MediaQuery.of(this).size.width;
}

extension ResponsiveExt on BuildContext {
  bool get isMobile => ResponsiveBreakpoints.of(this).isMobile;
  bool get isDesktop => ResponsiveBreakpoints.of(this).isDesktop;
}
