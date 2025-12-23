import 'package:get/get.dart';

import '../theme/themes.dart';

enum PageStatus { loading, idle, error }

class AppState {
  final AppThemeData appTheme;
  final Rx<PageStatus> status = PageStatus.loading.obs;
  final bool isAuthenticated;
  AppState(
      {required this.appTheme,
      PageStatus? status,
      this.isAuthenticated = true}) {
    this.status.value = status ?? PageStatus.loading;
  }

  copyWith({
    AppThemeData? appTheme,
    PageStatus? status,
    bool? isAuthenticated,
  }) {
    appTheme = appTheme ?? this.appTheme;
    this.status.value = this.status.value = status ?? this.status.value;
    isAuthenticated = isAuthenticated ?? this.isAuthenticated;
  }

  @override
  String toString() =>
      'AppState(appTheme: $appTheme, status: $status, isAuthenticated: $isAuthenticated)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AppState &&
        other.appTheme == appTheme &&
        other.status == status &&
        other.isAuthenticated == isAuthenticated;
  }

  @override
  int get hashCode =>
      appTheme.hashCode ^ status.hashCode ^ isAuthenticated.hashCode;
}
