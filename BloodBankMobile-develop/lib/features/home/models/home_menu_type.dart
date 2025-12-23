enum HomeMenuType {
  profile,
  setting,
  about,
  logout;

  String get title {
    switch (this) {
      case HomeMenuType.profile:
        return "Tài khoản của bạn";
      case HomeMenuType.setting:
        return "Cài đặt";
      case HomeMenuType.about:
        return "Thông tin phần mềm";
      case HomeMenuType.logout:
        return "Đăng xuất";
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
