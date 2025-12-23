// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';

final FlutterLocalization localization = FlutterLocalization.instance;

enum AppLanguage {
  en,
  vi;

  String get languageCode {
    switch (this) {
      case AppLanguage.en:
        return "en";
      case AppLanguage.vi:
        return "vi";
    }
  }

  MapLocale get defaultLocale {
    switch (this) {
      case AppLanguage.en:
        return MapLocale(languageCode, AppLocale.EN, countryCode: "US");
      case AppLanguage.vi:
        return MapLocale(languageCode, AppLocale.VI, countryCode: "VN");
    }
  }
}

extension StringExt on String {
  String translate(BuildContext context) {
    return getString(context);
  }
}

mixin class AppLocale {
  // Home
  static const String homeBook = 'home_book';
  static const String homeRegister = 'home_register';
  static const String homeHistory = 'home_history';
  static const String homeLocation = 'home_location';
  static const String homeBloodUsers = 'home_blood_users';
  static const String homeStatictics = 'home_statictics';
  static const String homeManagement = 'home_management';
  static const String search = 'search';
  static const String settings = 'settings';
  static const String generalSetting = 'generalSetting';
  static const String myAccount = 'my_account';
  static const String restorePurchased = 'restore_purchased';
  static const String enableNotifications = 'enable_notifications';
  static const String all_premium_access = 'all_premium_access';
  static const String supportFeedback = 'support_feedback';
  static const String howToUseGuide = 'how_to_use_guide';
  static const String rateUs = 'rate_us';
  static const String feedbackSupport = 'feedback_support';
  static const String moreAboutUs = 'more_about_us';
  static const String aboutUs = 'about_us';
  static const String share = 'share';
  static const String privacyPolicy = 'privacy_policy';
  static const String bloodDonationHistory = 'blood_donation_history';
  static const String bloodDonationRegister = 'blood_donation_register';
  static const String friend = 'friend';
  static const String listFriend = 'listFriend';
  static const String group = 'group';
  static const String joinGroup = 'join_group';
  static const String deleteAccount = 'delete_account';
  static const String logout = 'logout';
  static const String bloodType = "blood_type";
  static const String times = 'times';
  static const String filter = 'filter';
  static const String provinceCity = 'province_city';
  static const String enterProvinceCity = 'enter_province_city';
  static const String ward = 'ward';
  static const String district = 'district';
  static const String enterDistrict = 'enter_district';
  static const String fromDate = 'from_date';
  static const String today = 'today';
  static const String tomorrow = 'tomorrow';
  static const String enterTime = 'enter_time';
  static const String toDay = 'to_day';
  static const String location = 'location';
  static const String application = 'application';
  static const String news = 'news';
  static const String all = 'all';
  static const String dontHaveAnAccount = 'dont_have_an_account';
  static const String loginByOtp = 'login_by_otp';
  static const String login = 'login';
  static const String contact = 'contact';
  static const String signUp = 'sign_up';
  static const String username = 'username';
  static const String password = 'password';
  static const String oldPassword = 'oldPassword';
  static const String confirmPassword = 'confirm_password';
  static const String loginWithGoogle = 'login_with_google';
  static const String loginFail = 'loginFail';
  static const String authLoginWith = "auth_loginWith";
  static const String formRequiredPasswordError =
      "form_required_password_error";
  static const String formRequiredUsernameError =
      "form_required_username_error";
  static const String formRequiredNameError = "form_required_name_error";
  static const String formRequiredPhoneError = "form_required_phone_error";
  static const String road = 'road';
  static const String register = 'register';
  static const String registerDonateBlood = 'registerDonateBlood';
  static const String registerBuyBlood = 'registerBuyBlood';
  static const String approveBuyBlood = 'approveBuyBlood';
  static const String bloodDonationSchedule = 'bloodDonationSchedule';
  static const String next = 'next';
  static const String prev = 'prev';
  static const String name = 'name';
  static const String gender = 'gender';
  static const String updateInformation = 'updateInformation';
  static const String fullname = 'fullname';
  static const String birthYear = 'birthYear';
  static const String idCard = 'idCard';
  static const String phoneNumber = 'phoneNumber';
  static const String email = 'email';
  static const String notification = 'notification';
  static const String notificationUpdateProfile = 'notificationUpdateProfile';
  static const String cancel = 'cancel';
  static const String accept = 'accept';
  static const String yes = 'yes';
  static const String no = 'no';
  static const String dominance = 'dominance';
  static const String influence = 'influence';
  static const String steadiness = 'steadiness';
  static const String compliance = 'compliance';
  static const String personalityGroup = 'personalityGroup';
  static const String questionAndAnswer = 'questionAndAnswer';
  static const String listRegister = 'listRegister';
  static const String selectBloodBuyUnit = 'selectBloodBuyUnit';
  static const String note = 'note';

  static const Map<String, dynamic> EN = {
    homeBook: 'Đặt lịch',
    homeRegister: 'Đăng ký',
    homeHistory: 'Lịch sử',
    homeLocation: "Địa điểm",
    homeBloodUsers: "Danh sách\nhiến máu",
    homeStatictics: "Thống kê",
    homeManagement: "Quản lý",
    search: "Tìm kiếm",
    settings: "Cài đặt",
    generalSetting: 'General setting',
    updateInformation: 'Update information',
    bloodDonationHistory: 'Blood donation history',
    bloodDonationRegister: 'Blood donation register',
    friend: 'Friend',
    listFriend: 'Friends',
    group: 'Group',
    joinGroup: 'Join group',
    deleteAccount: 'Delete account',
    logout: 'Logout',
    myAccount: 'My account',
    restorePurchased: 'restore_purchased',
    enableNotifications: 'Enable notifications',
    all_premium_access: 'All premium access',
    supportFeedback: 'Support & feedback',
    howToUseGuide: 'How to use guide',
    rateUs: 'Rate us',
    feedbackSupport: 'Feedback/support',
    moreAboutUs: 'More about us',
    aboutUs: 'About us',
    share: 'Share',
    privacyPolicy: 'Privacy policy',
    bloodType: 'Blood type',
    times: 'Times',
    filter: 'Filter',
    provinceCity: 'Province/City',
    enterProvinceCity: 'Enter Province/City',
    district: 'District',
    enterDistrict: 'Enter District',
    ward: 'Ward',
    fromDate: 'From date',
    today: 'Today',
    tomorrow: 'Tomorrow',
    enterTime: 'Enter time',
    toDay: 'To day',
    location: 'Location',
    application: 'Application',
    news: 'news',
    all: 'all',
    dontHaveAnAccount: "Don't have an account yet?",
    loginByOtp: "Login by number phone",
    login: 'Login',
    contact: 'Contact',
    signUp: 'Sign Up',
    username: 'Username or Number Phone',
    password: 'Password',
    oldPassword: 'Old password',
    confirmPassword: 'Confirm password',
    loginWithGoogle: 'Login with Google',
    loginFail: 'Wrong username or password',
    authLoginWith: 'Or',
    formRequiredPasswordError: 'Please enter your password',
    formRequiredUsernameError: 'Please enter your username',
    formRequiredNameError: 'Please enter your name',
    formRequiredPhoneError: 'Please enter your phone',
    road: 'road',
    register: 'Register',
    registerDonateBlood: 'Register to donate blood',
    next: 'next',
    prev: 'prev',
    name: 'Name',
    gender: 'Gender',
    registerBuyBlood: 'Register buy blood',
    approveBuyBlood: 'Approve buy blood',
    bloodDonationSchedule: 'Blood donation schedule',
    fullname: 'Fullname',
    birthYear: 'Birth year',
    idCard: 'ID card',
    phoneNumber: 'Phone number',
    email: 'Email',
    notification: 'Notification',
    notificationUpdateProfile: 'Would you like to update your information?',
    cancel: 'Cancel',
    accept: 'Accept',
    yes: 'Yes',
    no: 'No',
    dominance: 'Dominance',
    influence: 'Influence',
    steadiness: 'Steadiness',
    compliance: 'Compliance',
    personalityGroup: 'Personality group',
    questionAndAnswer: 'Question - answer',
    listRegister: 'List register',
    selectBloodBuyUnit: 'Select the unit for blood concession',
    note: 'Note',
  };

  static const Map<String, dynamic> VI = {
    homeBook: 'Đặt lịch',
    homeRegister: 'Đăng ký',
    homeHistory: 'Lịch sử',
    homeLocation: "Địa điểm",
    homeBloodUsers: "Danh sách\nhiến máu",
    homeStatictics: "Thống kê",
    homeManagement: "Quản lý",
    search: "Tìm kiếm",
    settings: "Settings",
    generalSetting: 'Cài đặt chung',
    updateInformation: 'Cập nhật thông tin',
    bloodDonationHistory: 'Lịch sử hiến máu',
    bloodDonationRegister: 'Lịch sử đăng ký hiến máu',
    friend: 'Bạn bè',
    listFriend: 'Danh sách bạn bè',
    group: 'Nhóm',
    joinGroup: 'Tham gia nhóm',
    deleteAccount: 'Xóa tài khoản',
    logout: 'Đăng xuất',
    myAccount: 'Tài khoản của tôi',
    enableNotifications: 'Hiển thị thông báo',
    all_premium_access: 'Tất cả quyền truy cập cấp cao',
    supportFeedback: 'Hỗ trợ và phản hồi',
    howToUseGuide: 'Hướng dẫn sử dụng',
    rateUs: 'Đánh giá',
    feedbackSupport: 'Liên hệ - hỗ trợ',
    moreAboutUs: 'Thông tin về chúng tôi',
    aboutUs: 'Về chúng tôi',
    share: 'Chia sẻ',
    privacyPolicy: 'Chính sách bảo mật',
    bloodType: 'Nhóm máu',
    times: 'Số lần',
    filter: 'Bộ lọc',
    enterTime: 'Nhập thời gian',
    provinceCity: 'Tỉnh/Thành phố',
    enterProvinceCity: 'Nhập Tỉnh/Thành phố',
    district: 'Huyện/Quận',
    enterDistrict: 'Nhập Huyện/Quận',
    ward: 'Phường/Xã',
    fromDate: 'Từ ngày',
    today: 'Hôm nay',
    tomorrow: 'Ngày mai',
    toDay: 'Đến ngày',
    location: 'Địa điểm',
    application: 'Ứng dụng',
    news: 'Tin tức',
    all: 'Tất cả',
    dontHaveAnAccount: 'Bạn chưa có tài khoản?',
    loginByOtp: 'Đăng nhập bằng số điện thoại',
    login: 'Đăng nhập',
    contact: 'Liên hệ',
    signUp: 'Đăng ký',
    username: 'Tên đăng nhập/CCCD/Căn cước',
    password: 'Mật khẩu',
    oldPassword: 'Mật khẩu cũ',
    confirmPassword: 'Nhập lại mật khẩu',
    loginWithGoogle: 'Đăng nhập với Google',
    loginFail: 'Sai tên đăng nhập hoặc mật khẩu',
    authLoginWith: 'Hoặc',
    formRequiredPasswordError: 'Vui lòng nhập mật khẩu',
    formRequiredUsernameError: 'Vui lòng nhập tài khoản',
    formRequiredNameError: 'Vui lòng nhập họ tên',
    formRequiredPhoneError: 'Vui lòng nhập số điện thoại',
    road: 'Đường đi',
    register: 'Đăng ký',
    registerDonateBlood: 'Đăng ký hiến máu',
    next: 'Tiếp theo',
    prev: 'Quay lại',
    name: 'Tên',
    gender: 'Giới tính',
    registerBuyBlood: 'Đăng ký nhượng máu',
    approveBuyBlood: 'Duyệt yêu cầu nhượng máu',
    bloodDonationSchedule: 'Lịch hiến máu',
    fullname: 'Họ và tên',
    birthYear: 'Năm sinh',
    idCard: 'CCCD/Căn cước',
    phoneNumber: 'Số điện thoại',
    email: 'Email',
    notification: 'Thông báo',
    notificationUpdateProfile: 'Bạn có muốn cập nhật thông tin không?',
    cancel: 'Hủy',
    accept: 'Đồng ý',
    yes: 'Có',
    no: 'Không',
    dominance: 'Sự thống trị',
    influence: 'Sự ảnh hưởng',
    steadiness: 'Sự ổn định',
    compliance: 'Sự tuân thủ',
    personalityGroup: 'Nhóm tính cách',
    questionAndAnswer: 'Hỏi - đáp',
    listRegister: 'Danh sách đăng ký',
    selectBloodBuyUnit: 'Chọn đơn vị cho nhượng máu',
    note: 'Ghi chú',
  };

  void init(
      {required List<MapLocale> mapLocales,
      AppLanguage initLanguage = AppLanguage.en}) {
    localization.onTranslatedLanguage = onTranslatedLanguage;
    localization.init(
        mapLocales: mapLocales, initLanguageCode: initLanguage.languageCode);
  }

  void onTranslatedLanguage(Locale? locale) {}
}
