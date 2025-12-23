enum HomeCategory {
  // book,
  registerBuyBlood, // đăng ký nhượng máu
  historyRegisterBuyBlood, //lịch sử đăng ký nhượng máu
  approveBuyBlood, // duyệt nhượng máu
  registerDonateBlood, // đăng ký hiến máu
  bloodDonationSchedule, // lịch hiến máu
  bloodDonationHistory, // lịch sử hiến máu
  bloodDonationRegister, // lịch sử đăng ký hiến máu
  questionAndAnswer, // hỏi - đáp
  feedbackSupport, // liên hệ - phn hồi

  // bloodUsers,
  // statistics,
  homeManagement;

  String get title {
    switch (this) {
      case HomeCategory.registerBuyBlood:
        // return AppLocale.registerBuyBlood;
        return "Đăng ký\nnhượng máu";
      case HomeCategory.historyRegisterBuyBlood:
        // return AppLocale.registerBuyBlood;
        return "Lịch sử ĐK\nnhượng máu";
      case HomeCategory.registerDonateBlood:
        // return AppLocale.registerDonateBlood;
        return "Đăng ký\nhiến máu";
      case HomeCategory.bloodDonationSchedule:
        // return AppLocale.bloodDonationSchedule;
        return "Lịch\nhiến máu";
      case HomeCategory.bloodDonationHistory:
        // return AppLocale.bloodDonationHistory;
        return "Lịch sử\nhiến máu";
      case HomeCategory.bloodDonationRegister:
        return "Lịch sử\nđ.ký hiến máu";
      // return AppLocale.bloodDonationRegister;
      // case HomeCategory.bloodUsers:
      //   return AppLocale.homeBloodUsers;
      // case HomeCategory.statistics:
      //   return AppLocale.homeStatictics;
      case HomeCategory.approveBuyBlood:
        return "Duyệt YC\nnhượng máu";
      // return AppLocale.approveBuyBlood;
      case HomeCategory.homeManagement:
        return "Quản lý";
      // return AppLocale.homeManagement;
      case HomeCategory.questionAndAnswer:
        return "Hỏi - đáp";
      // return AppLocale.questionAndAnswer;
      case HomeCategory.feedbackSupport:
        // return AppLocale.feedbackSupport;
        return "Liên hệ\nhỗ trợ";
    }
  }

  String get icon {
    switch (this) {
      case HomeCategory.registerBuyBlood:
        return "assets/icons/ic_register_buy_blood.png";
      case HomeCategory.historyRegisterBuyBlood:
        return "assets/icons/ic_register_buy_blood.png";
      case HomeCategory.registerDonateBlood:
        return "assets/icons/ic_home_register.png";
      case HomeCategory.bloodDonationSchedule:
        return "assets/icons/ic_blood_donate_schedule.png";
      case HomeCategory.bloodDonationHistory:
        return "assets/icons/ic_home_history.png";
      case HomeCategory.bloodDonationRegister:
        return "assets/icons/ic_hand_blood.png";
      // case HomeCategory.bloodUsers:
      //   return "assets/icons/ic_home_blood_users.svg";
      // case HomeCategory.statistics:
      //   return "assets/icons/ic_home_statistics.svg";
      case HomeCategory.approveBuyBlood:
        return "assets/icons/ic_register_buy_blood.png";
      case HomeCategory.homeManagement:
        return "assets/icons/ic_home_management.png";
      case HomeCategory.questionAndAnswer:
        return "assets/icons/ic_home_question_answer.png";
      case HomeCategory.feedbackSupport:
        return "assets/icons/ic_feedback.png";
    }
  }
}
