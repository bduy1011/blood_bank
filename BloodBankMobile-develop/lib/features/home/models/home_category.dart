import 'package:blood_donation/core/localization/app_locale.dart';
import 'package:flutter/material.dart';

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

  String title(BuildContext context) {
    switch (this) {
      case HomeCategory.registerBuyBlood:
        return AppLocale.registerBuyBloodShort.translate(context);
      case HomeCategory.historyRegisterBuyBlood:
        return AppLocale.historyRegisterBuyBlood.translate(context);
      case HomeCategory.registerDonateBlood:
        return AppLocale.registerDonateBlood.translate(context);
      case HomeCategory.bloodDonationSchedule:
        return AppLocale.bloodDonationScheduleShort.translate(context);
      case HomeCategory.bloodDonationHistory:
        return AppLocale.bloodDonationHistoryShort.translate(context);
      case HomeCategory.bloodDonationRegister:
        return AppLocale.bloodDonationRegisterShort.translate(context);
      case HomeCategory.approveBuyBlood:
        return AppLocale.approveBuyBloodRequest.translate(context);
      case HomeCategory.homeManagement:
        return AppLocale.homeManagement.translate(context);
      case HomeCategory.questionAndAnswer:
        return AppLocale.questionAndAnswer.translate(context);
      case HomeCategory.feedbackSupport:
        return AppLocale.contactSupport.translate(context);
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
