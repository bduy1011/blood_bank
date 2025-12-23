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

  String get title {
    switch (this) {
      case NavigationType.home:
        return "Trang chủ";
      case NavigationType.notification:
        return "Thông báo";
      case NavigationType.register:
        return "Đăng ký";
      case NavigationType.setting:
        return "Cá nhân";
    }
  }
}
