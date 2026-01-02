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
  static const String accountInformation = 'account_information';
  static const String changePassword = 'change_password';
  static const String appInformation = 'app_information';
  static const String versionInformation = 'version_information';
  static const String setup = 'setup';
  static const String language = 'language';
  static const String english = 'english';
  static const String vietnamese = 'vietnamese';
  static const String thankYouMessage = 'thank_you_message';
  static const String confirmDeleteAccount = 'confirm_delete_account';
  static const String deleteAccountMessage = 'delete_account_message';
  static const String deleteAccountSuccess = 'delete_account_success';
  static const String deleteAccountFailed = 'delete_account_failed';
  static const String scanQRCCCD = 'scan_qr_cccd';
  static const String tryAgain = 'try_again';
  static const String back = 'back';
  static const String close = 'close';
  static const String cameraError = 'camera_error';
  static const String cameraInitError = 'camera_init_error';
  static const String qrScanInstruction = 'qr_scan_instruction';
  static const String cannotInitCamera = 'cannot_init_camera';
  static const String error = 'error';
  static const String cannotReadQRCode = 'cannot_read_qr_code';
  static const String passwordNotMatch = 'password_not_match';
  static const String registerAccountSuccess = 'register_account_success';
  static const String registerAccountFailed = 'register_account_failed';
  static const String pleaseSignBeforeConfirm = 'please_sign_before_confirm';
  static const String confirm = 'confirm';
  static const String registerAccount = 'register_account';
  static const String signatureConfirmed = 'signature_confirmed';
  static const String passwordMinLength = 'password_min_length';
  static const String cannotSaveSignature = 'cannot_save_signature';
  static const String errorOccurred = 'error_occurred';
  static const String signatureCancelled = 'signature_cancelled';
  static const String functions = 'functions';
  static const String home = 'home';
  static const String personal = 'personal';
  static const String historyRegisterBuyBlood = 'history_register_buy_blood';
  static const String approveBuyBloodRequest = 'approve_buy_blood_request';
  static const String contactSupport = 'contact_support';
  static const String registerBuyBloodShort = 'register_buy_blood_short';
  static const String bloodDonationScheduleShort =
      'blood_donation_schedule_short';
  static const String bloodDonationHistoryShort =
      'blood_donation_history_short';
  static const String bloodDonationRegisterShort =
      'blood_donation_register_short';
  static const String yourAccount = 'your_account';
  static const String softwareInformation = 'software_information';
  static const String noNotificationYet = 'no_notification_yet';
  static const String notUpdatePersonalInfo = 'not_update_personal_info';
  static const String updateNow = 'update_now';
  static const String noData = 'no_data';
  static const String pleaseUpdatePersonalInfoBefore =
      'please_update_personal_info_before';
  static const String expectedArrivalDateTime = 'expected_arrival_date_time';
  static const String contactAddress = 'contact_address';
  static const String fromToDate = 'from_to_date';
  static const String pleaseEnterApprovalQuantity =
      'please_enter_approval_quantity';
  static const String pleaseEnterFullInfo = 'please_enter_full_info';
  static const String pleaseEnterFullNameBeforeSign =
      'please_enter_full_name_before_sign';
  static const String pleaseEnterIdCardBeforeSign =
      'please_enter_id_card_before_sign';
  static const String pleaseEnterFeedbackContent =
      'please_enter_feedback_content';
  static const String pleaseUpdatePersonalInfoBeforeFeedback =
      'please_update_personal_info_before_feedback';
  static const String pleaseUpdatePersonalInfoBeforeRegister =
      'please_update_personal_info_before_register';
  static const String pleaseUpdatePersonalInfoBeforeBuyBlood =
      'please_update_personal_info_before_buy_blood';
  static const String saveChanges = 'save_changes';
  static const String selectDateTime = 'select_date_time';
  static const String notEnterOldPassword = 'not_enter_old_password';
  static const String notEnterPassword = 'not_enter_password';
  static const String changePasswordSuccess = 'change_password_success';
  static const String changePasswordFailed = 'change_password_failed';
  static const String numberOfBloodDonations = 'number_of_blood_donations';
  static const String welcomeBack = 'welcome_back';
  static const String notDonatedYet = 'not_donated_yet';
  static const String daysSinceLastDonation = 'days_since_last_donation';
  static const String lastDonation = 'last_donation';
  static const String notificationTitle = 'notification_title';
  static const String cannotFindRoute = 'cannot_find_route';
  static const String pleaseSelectBloodUnit = 'please_select_blood_unit';
  static const String approveBuyBloodSuccess = 'approve_buy_blood_success';
  static const String rejectBuyBloodSuccess = 'reject_buy_blood_success';
  static const String sendSuccess = 'send_success';
  static const String notEnterFullName = 'not_enter_full_name';
  static const String invalidFullName = 'invalid_full_name';
  static const String notEnterUsername = 'not_enter_username';
  static const String notEnterPhone = 'not_enter_phone';
  static const String invalidPhone = 'invalid_phone';
  static const String qrCodeReadSuccess = 'qr_code_read_success';
  static const String qrCodeReadError = 'qr_code_read_error';
  static const String qrScanError = 'qr_scan_error';
  static const String signatureSavedSuccess = 'signature_saved_success';
  static const String signatureNotComplete = 'signature_not_complete';
  static const String signatureError = 'signature_error';
  static const String updateAccountSuccess = 'update_account_success';
  static const String updateAccountFailed = 'update_account_failed';
  static const String invalidIdCard = 'invalid_id_card';
  static const String cancelRegisterSuccess = 'cancel_register_success';
  static const String cancelRegisterFailed = 'cancel_register_failed';
  static const String cancelBuyBloodSuccess = 'cancel_buy_blood_success';
  static const String cancelBuyBloodFailed = 'cancel_buy_blood_failed';
  static const String updateInventorySuccess = 'update_inventory_success';
  static const String errorOccurredPleaseRetry = 'error_occurred_please_retry';
  static const String sendOtpSuccess = 'send_otp_success';
  static const String time = 'time';
  static const String invalidUsername = 'invalid_username';
  static const String scanIdCardToGetInfo = 'scan_id_card_to_get_info';
  static const String registeringToDonate = 'registering_to_donate';
  static const String platelets = 'platelets';
  static const String blood = 'blood';
  static const String at = 'at';
  static const String timeFrom = 'time_from';
  static const String day = 'day';
  static const String noDataFromToDate = 'no_data_from_to_date';
  static const String updateIdCard = 'update_id_card';
  static const String here = 'here';
  static const String toViewDonationRegisterHistory =
      'to_view_donation_register_history';
  static const String toViewDonationHistory = 'to_view_donation_history';
  static const String apply = 'apply';
  static const String contactInformation = 'contact_information';
  static const String contactViaFanpage = 'contact_via_fanpage';
  static const String sendRequestDirectly = 'send_request_directly';
  static const String selectTimeRange = 'select_time_range';
  static const String forgotPassword = 'forgot_password';
  static const String pleaseFillInfoBelow = 'please_fill_info_below';
  static const String send = 'send';
  static const String address = 'address';
  static const String phone = 'phone';
  static const String extension = 'extension';
  static const String or = 'or';
  static const String contactDuringBusinessHours =
      'contact_during_business_hours';
  static const String version = 'version';
  static const String updateDate = 'update_date';
  static const String thankYouForUsingApp = 'thank_you_for_using_app';
  static const String rateApp = 'rate_app';
  // Biometric
  static const String loginWithBiometric = 'loginWithBiometric';
  static const String biometricNotAvailable = 'biometricNotAvailable';
  static const String biometricNotEnrolled = 'biometricNotEnrolled';
  static const String biometricAuthFailed = 'biometricAuthFailed';
  static const String biometricAuthSuccess = 'biometricAuthSuccess';
  static const String enableBiometricLogin = 'enableBiometricLogin';
  static const String biometricAuthReason = 'biometricAuthReason';
  static const String selectImageFromGallery = 'selectImageFromGallery';
  static const String noQRCodeFoundInImage = 'noQRCodeFoundInImage';
  static const String failedToReadQRFromImage = 'failedToReadQRFromImage';

  static const Map<String, dynamic> EN = {
    homeBook: 'Book appointment',
    homeRegister: 'Register',
    homeHistory: 'History',
    homeLocation: "Location",
    homeBloodUsers: "Blood donation\nlist",
    homeStatictics: "Statistics",
    homeManagement: "Management",
    search: "Search",
    settings: "Settings",
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
    accountInformation: 'Account information',
    changePassword: 'Change password',
    appInformation: 'App information',
    versionInformation: 'Version information',
    setup: 'Setup',
    language: 'Language',
    english: 'English',
    vietnamese: 'Vietnamese',
    thankYouMessage:
        'Sincere thanks to Medcomtech Company for accompanying Cho Ray Blood Transfusion Center in voluntary blood donation activities.',
    confirmDeleteAccount: 'Confirm delete account',
    deleteAccountMessage: 'Your account will be deleted\npermanently',
    deleteAccountSuccess: 'Account deleted successfully',
    deleteAccountFailed: 'Failed to delete account',
    scanQRCCCD: 'Scan QR CCCD/ID Card',
    tryAgain: 'Try again',
    back: 'Back',
    close: 'Close',
    cameraError: 'Camera error',
    cameraInitError: 'Camera initialization error',
    qrScanInstruction: 'Place the QR code on your ID card in the frame',
    cannotInitCamera:
        'Cannot initialize camera. Please rebuild the app and grant camera permission.\nError:',
    error: 'Error',
    cannotReadQRCode: 'Cannot read information from QR code:',
    passwordNotMatch: 'Password and confirm password do not match',
    registerAccountSuccess: 'Account registration successful!',
    registerAccountFailed: 'Account registration failed!',
    pleaseSignBeforeConfirm: 'Please sign before confirming',
    confirm: 'Confirm',
    registerAccount: 'Register account',
    signatureConfirmed: 'Digital signature confirmed!',
    passwordMinLength: 'Password must be at least 6 characters',
    cannotSaveSignature: 'Cannot save signature',
    errorOccurred: 'An error occurred:',
    signatureCancelled: 'Digital signature cancelled',
    functions: 'Functions',
    home: 'Home',
    personal: 'Personal',
    historyRegisterBuyBlood: 'Registration history\nfor blood concession',
    approveBuyBloodRequest: 'Approve blood\nconcession request',
    contactSupport: 'Contact\nsupport',
    registerBuyBloodShort: 'Register\nblood concession',
    bloodDonationScheduleShort: 'Blood donation\nschedule',
    bloodDonationHistoryShort: 'Blood donation\nhistory',
    bloodDonationRegisterShort: 'Registration history\nfor blood donation',
    yourAccount: 'Your account',
    softwareInformation: 'Software information',
    noNotificationYet: "You don't have any notifications yet",
    notUpdatePersonalInfo: "You have not updated personal information.",
    updateNow: "Update now",
    noData: 'No data',
    pleaseUpdatePersonalInfoBefore: 'Please update personal information before',
    expectedArrivalDateTime: 'Expected arrival date and time',
    contactAddress: 'Contact address',
    fromToDate: 'From {fromDate} to {toDate}',
    pleaseEnterApprovalQuantity: 'Please enter approval quantity',
    pleaseEnterFullInfo: 'Please enter full information\nto continue!',
    pleaseEnterFullNameBeforeSign: 'Please enter full name before signing',
    pleaseEnterIdCardBeforeSign: 'Please enter ID card before signing',
    pleaseEnterFeedbackContent: 'Please enter feedback content',
    pleaseUpdatePersonalInfoBeforeFeedback:
        'Please update personal information before sending feedback!',
    pleaseUpdatePersonalInfoBeforeRegister:
        'Please update personal information before registering to donate blood!',
    pleaseUpdatePersonalInfoBeforeBuyBlood:
        'Please update personal information before creating blood concession request!',
    saveChanges: 'Save changes',
    selectDateTime: 'Select date and time',
    notEnterOldPassword: 'Please enter old password',
    notEnterPassword: 'Please enter password',
    changePasswordSuccess: 'Password changed successfully',
    changePasswordFailed: 'Password change failed',
    numberOfBloodDonations: 'Number of blood donations',
    welcomeBack: 'Welcome back!',
    notDonatedYet: "You haven't donated blood yet!",
    daysSinceLastDonation:
        "It's been {days} days since you last donated blood!\n",
    lastDonation: 'Your last blood donation: {date}',
    notificationTitle: 'Notification',
    cannotFindRoute: 'Cannot find route',
    pleaseSelectBloodUnit: 'Please select blood unit',
    approveBuyBloodSuccess: 'Blood concession request approved successfully',
    rejectBuyBloodSuccess: 'Blood concession request rejected successfully',
    sendSuccess: 'Sent successfully!',
    notEnterFullName: 'Please enter full name',
    invalidFullName: 'Invalid full name',
    notEnterUsername: 'Please enter username',
    notEnterPhone: 'Please enter phone number',
    invalidPhone: 'Invalid phone number',
    qrCodeReadSuccess: 'QR code information retrieved successfully!',
    qrCodeReadError: 'Error reading QR code information!',
    qrScanError: 'Error scanning QR code!',
    signatureSavedSuccess: 'Signature saved successfully!',
    signatureNotComplete: 'Signature not completed',
    signatureError: 'Error performing digital signature:',
    updateAccountSuccess: 'Account updated successfully',
    updateAccountFailed: 'Account update failed',
    invalidIdCard: 'ID card format is incorrect!',
    cancelRegisterSuccess: 'Registration cancelled successfully',
    cancelRegisterFailed: 'Registration cancellation failed',
    cancelBuyBloodSuccess: 'Blood concession request cancelled successfully',
    cancelBuyBloodFailed: 'Blood concession request cancellation failed',
    updateInventorySuccess: 'Inventory information updated successfully',
    errorOccurredPleaseRetry: 'An error occurred, please try again later',
    sendOtpSuccess: 'OTP sent successfully',
    time: 'Time',
    invalidUsername: 'Username must be ID card with 9 or 12 characters!',
    scanIdCardToGetInfo: 'Scan ID card to get information',
    registeringToDonate: 'You are registering to donate',
    platelets: 'platelets',
    blood: 'blood',
    at: 'at',
    timeFrom: 'Time from',
    day: 'day',
    noDataFromToDate: 'No data\nfrom {fromDate} to {toDate}',
    updateIdCard: 'Update ID card',
    here: 'Here',
    toViewDonationRegisterHistory:
        ' to view your blood donation registration history.',
    toViewDonationHistory: ' to view your blood donation history.',
    apply: 'Apply',
    selectTimeRange: 'Select time range',
    contactInformation: 'CONTACT INFORMATION',
    contactViaFanpage: 'CONTACT VIA FANPAGE',
    sendRequestDirectly: 'SEND REQUEST DIRECTLY',
    forgotPassword: 'Did you forget your password?',
    pleaseFillInfoBelow:
        'Please fill in the information below.\nThe center will contact you to reset your password!',
    send: 'Send',
    address: 'Address: ',
    phone: 'Phone: ',
    extension: ' - extension ',
    or: ' or ',
    contactDuringBusinessHours: ' (contact during business hours).',
    version: 'Version: V.',
    updateDate: 'Update date: ',
    thankYouForUsingApp:
        'Thank you for using our app!\nPlease leave a review to help us improve',
    rateApp: 'RATE APP',
    // Biometric
    loginWithBiometric: 'Login with fingerprint/Face ID',
    biometricNotAvailable:
        'Biometric authentication is not available on this device',
    biometricNotEnrolled: 'No biometric credentials found. Please login first.',
    biometricAuthFailed: 'Biometric authentication failed',
    biometricAuthSuccess: 'Login successful',
    enableBiometricLogin: 'Enable biometric login',
    biometricAuthReason: 'Please authenticate to login',
    selectImageFromGallery: 'Select image from gallery',
    noQRCodeFoundInImage: 'No QR code found in the selected image',
    failedToReadQRFromImage: 'Failed to read QR code from image',
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
    accountInformation: 'Thông tin tài khoản',
    changePassword: 'Thay đổi mật khẩu',
    appInformation: 'Thông tin ứng dụng',
    versionInformation: 'Thông tin phiên bản',
    setup: 'Thiết lập',
    language: 'Ngôn ngữ',
    english: 'Tiếng Anh',
    vietnamese: 'Tiếng Việt',
    thankYouMessage:
        'Chân thành cảm ơn Công ty Medcomtech đã đồng hành cùng Trung tâm Truyền máu Chợ Rẫy trong hoạt động vận động hiến máu tình nguyện.',
    confirmDeleteAccount: 'Xác nhận xóa tài khoản',
    deleteAccountMessage: 'Tài khoản của bạn sẽ bị xóa\nvĩnh viễn',
    deleteAccountSuccess: 'Xóa tài khoản thành công',
    deleteAccountFailed: 'Xóa tài khoản thất bại',
    scanQRCCCD: 'Quét mã QR CCCD/Căn cước',
    tryAgain: 'Thử lại',
    back: 'Quay lại',
    close: 'Đóng',
    cameraError: 'Lỗi camera',
    cameraInitError: 'Lỗi khởi tạo camera',
    qrScanInstruction: 'Đưa mã QR trên căn cước công dân vào khung',
    cannotInitCamera:
        'Không thể khởi tạo camera. Vui lòng rebuild app và cấp quyền camera.\nLỗi:',
    error: 'Lỗi',
    cannotReadQRCode: 'Không thể đọc thông tin từ QR code:',
    passwordNotMatch: 'Mật khẩu và xác nhận mật khẩu không giống nhau',
    registerAccountSuccess: 'Đăng ký tài khoản thành công!',
    registerAccountFailed: 'Đăng ký tài khoản thất bại!',
    pleaseSignBeforeConfirm: 'Vui lòng ký tên trước khi xác nhận',
    confirm: 'Xác nhận',
    registerAccount: 'Đăng ký tài khoản',
    signatureConfirmed: 'Đã xác nhận chữ ký số!',
    passwordMinLength: 'Mật khẩu phải từ 6 ký tự',
    cannotSaveSignature: 'Không thể lưu chữ ký',
    errorOccurred: 'Có lỗi xảy ra:',
    signatureCancelled: 'Đã hủy chữ ký số',
    functions: 'Chức năng',
    home: 'Trang chủ',
    personal: 'Cá nhân',
    historyRegisterBuyBlood: 'Lịch sử ĐK\nnhượng máu',
    approveBuyBloodRequest: 'Duyệt YC\nnhượng máu',
    contactSupport: 'Liên hệ\nhỗ trợ',
    registerBuyBloodShort: 'Đăng ký\nnhượng máu',
    bloodDonationScheduleShort: 'Lịch\nhiến máu',
    bloodDonationHistoryShort: 'Lịch sử\nhiến máu',
    bloodDonationRegisterShort: 'Lịch sử\nđ.ký hiến máu',
    yourAccount: 'Tài khoản của bạn',
    softwareInformation: 'Thông tin phần mềm',
    noNotificationYet: 'Bạn chưa có thông báo nào',
    notUpdatePersonalInfo: 'Bạn chưa cập nhật thông tin cá nhân.',
    updateNow: 'Cập nhật ngay',
    noData: 'Không có dữ liệu',
    pleaseUpdatePersonalInfoBefore:
        'Vui lòng cập nhật thông tin cá nhân trước khi',
    expectedArrivalDateTime: 'Ngày giờ dự kiến đến',
    contactAddress: 'Địa chỉ liên hệ',
    fromToDate: 'Từ {fromDate} đến {toDate}',
    pleaseEnterApprovalQuantity: 'Vui lòng nhập số lượng duyệt',
    pleaseEnterFullInfo: 'Vui lòng nhập đủ thông tin\nđể tiếp tục!',
    pleaseEnterFullNameBeforeSign: 'Vui lòng nhập họ tên trước khi ký số',
    pleaseEnterIdCardBeforeSign: 'Vui lòng nhập CCCD/Căn cước trước khi ký số',
    pleaseEnterFeedbackContent: 'Vui lòng nhập nội dung góp ý/ phản hồi',
    pleaseUpdatePersonalInfoBeforeFeedback:
        'Vui lòng nhập cập nhật thông tin cá nhân trước khi gửi phản hồi!',
    pleaseUpdatePersonalInfoBeforeRegister:
        'Vui lòng nhập cập nhật thông tin cá nhân trước khi đăng ký hiến máu!',
    pleaseUpdatePersonalInfoBeforeBuyBlood:
        'Vui lòng nhập cập nhật thông tin cá nhân trước khi tạo yêu cầu nhượng máu!',
    saveChanges: 'Lưu thay đổi',
    selectDateTime: 'Chọn ngày giờ',
    notEnterOldPassword: 'Chưa nhập mật khẩu cũ',
    notEnterPassword: 'Chưa nhập mật khẩu',
    changePasswordSuccess: 'Thay đổi mật khẩu thành công',
    changePasswordFailed: 'Thay đổi mật khẩu thất bại',
    numberOfBloodDonations: 'Số lần hiến máu',
    welcomeBack: 'Chào mừng bạn quay trở lại!',
    notDonatedYet: 'Bạn chưa hiến máu lần nào!',
    daysSinceLastDonation: 'Đã {days} ngày rồi bạn chưa hiến máu!\n',
    lastDonation: 'Lần hiến máu gần nhất của bạn: {date}',
    notificationTitle: 'Thông báo',
    cannotFindRoute: 'Không tìm thấy đường đi',
    pleaseSelectBloodUnit: 'Vui lòng chọn đơn vị cấp máu.',
    approveBuyBloodSuccess: 'Duyệt yêu cầu nhượng máu thành công.',
    rejectBuyBloodSuccess: 'Từ chối yêu cầu nhượng máu thành công.',
    sendSuccess: 'Gửi thành công!',
    notEnterFullName: 'Chưa nhập họ tên',
    invalidFullName: 'Họ tên không hợp lệ',
    notEnterUsername: 'Chưa nhập tên tài khoản',
    notEnterPhone: 'Chưa nhập số điện thoại',
    invalidPhone: 'Số điện thoại không đúng',
    qrCodeReadSuccess: 'Đã lấy thông tin từ QR code thành công!',
    qrCodeReadError: 'Lỗi khi đọc thông tin từ QR code!',
    qrScanError: 'Lỗi khi quét QR code!',
    signatureSavedSuccess: 'Đã lưu chữ ký thành công!',
    signatureNotComplete: 'Chưa hoàn thành chữ ký',
    signatureError: 'Lỗi khi thực hiện chữ ký số:',
    updateAccountSuccess: 'Cập nhật tài khoản thành công',
    updateAccountFailed: 'Cập nhật tài khoản thất bại',
    invalidIdCard: 'CCCD/Căn cước không đúng định dạng!',
    cancelRegisterSuccess: 'Hủy đăng ký thành công',
    cancelRegisterFailed: 'Hủy đăng ký thất bại',
    cancelBuyBloodSuccess: 'Hủy yêu cầu nhượng máu thành công',
    cancelBuyBloodFailed: 'Hủy yêu cầu nhượng máu thất bại',
    updateInventorySuccess: 'Cập nhật thông tin tồn kho thành công.',
    errorOccurredPleaseRetry: 'Có lỗi xãy ra, xin vui long thử lại sau',
    sendOtpSuccess: 'Gửi OTP thành công',
    time: 'Lần',
    invalidUsername:
        'Tên đăng nhập phải là CCCD/Căn cước có độ dài 9 hoặc 12 ký tự!',
    scanIdCardToGetInfo: 'Quét CCCD/Căn cước để lấy thông tin',
    registeringToDonate: 'Bạn đang đăng ký hiến',
    platelets: 'tiểu cầu',
    blood: 'máu',
    at: 'tại:',
    timeFrom: 'Thời gian từ',
    day: 'ngày',
    noDataFromToDate: 'Không có dữ liệu\r\ntừ {fromDate} đến {toDate}',
    updateIdCard: 'Cập nhật CCCD/Căn cước',
    here: 'Tại đây',
    toViewDonationRegisterHistory: ' để xem lịch sử đăng ký hiến máu của bạn.',
    toViewDonationHistory: ' để xem lịch sử hiến máu của bạn.',
    apply: 'Áp dụng',
    selectTimeRange: 'Chọn khoảng thời gian',
    contactInformation: 'THÔNG TIN LIÊN HỆ',
    contactViaFanpage: 'LIÊN HỆ QUA FANPAGE',
    sendRequestDirectly: 'GỬI YÊU CẦU TRỰC TIẾP',
    forgotPassword: 'Bạn quên mật khẩu?',
    pleaseFillInfoBelow:
        'Vui lòng điền các thông tin bên dưới.\nTrung tâm sẽ liên hệ để cấp lại mật khẩu cho bạn!',
    send: 'Gửi',
    address: 'Địa chỉ: ',
    phone: 'Điện thoại: ',
    extension: ' - số nội bộ ',
    or: ' hoặc ',
    contactDuringBusinessHours: ' (liên hệ trong giờ hành chính).',
    version: 'Phiên bản: V.',
    updateDate: 'Ngày cập nhật: ',
    thankYouForUsingApp:
        'Cảm ơn bạn đã sử dụng ứng dụng của chúng tôi!\nHãy để lại đánh giá để cải thiện thêm',
    rateApp: 'ĐÁNH GIÁ APP',
    // Biometric
    loginWithBiometric: 'Đăng nhập bằng vân tay, Face ID',
    biometricNotAvailable: 'Thiết bị không hỗ trợ xác thực sinh trắc học',
    biometricNotEnrolled:
        'Chưa có thông tin đăng nhập. Vui lòng đăng nhập trước.',
    biometricAuthFailed: 'Xác thực sinh trắc học thất bại',
    biometricAuthSuccess: 'Đăng nhập thành công',
    enableBiometricLogin: 'Bật đăng nhập bằng sinh trắc học',
    biometricAuthReason: 'Vui lòng xác thực để đăng nhập',
    selectImageFromGallery: 'Chọn ảnh từ thư viện',
    noQRCodeFoundInImage: 'Không tìm thấy QR code trong ảnh đã chọn',
    failedToReadQRFromImage: 'Không thể đọc QR code từ ảnh',
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
