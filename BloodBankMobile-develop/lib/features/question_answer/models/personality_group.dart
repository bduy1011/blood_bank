import 'package:flutter/material.dart';

enum PersonalityGroup {
  location,
  time,
  condition,
  note,
  image,
  benefit,
  testing,
  cmnd,
  contagious,
  unwell,
  signs,
  preparedonate,
  abnormal,
  needblood,
  health,
  delay;

  String get title {
    switch (this) {
      case PersonalityGroup.location:
        return 'ĐỊA ĐIỂM HIẾN MÁU Ở ĐÂU?';
      case PersonalityGroup.time:
        return 'THỜI GIAN TIẾP NHẬN ĐĂNG KÝ HIẾN MÁU NHƯ THẾ NÀO?';
      case PersonalityGroup.condition:
        return 'TIÊU CHUẨN KHI HIẾN MÁU, TIỂU CẦU?';
      case PersonalityGroup.note:
        return 'LƯU Ý GÌ KHI ĐẾN HIẾN MÁU?';
      case PersonalityGroup.image:
        return 'CẨM NANG';
      case PersonalityGroup.benefit:
        return 'QUYỀN LỢI KHI HIẾN MÁU TÌNH NGUYỆN?';
      case PersonalityGroup.testing:
        return 'MÁU CỦA TÔI SẼ LÀM NHỮNG XÉT NGHIỆM GÌ?';
      case PersonalityGroup.cmnd:
        return 'TẠI SAO HIẾN MÁU PHẢI CÓ CCCD/CĂN CƯỚC?';
      case PersonalityGroup.contagious:
        return 'KHI HIẾN MÁU CÓ THỂ BỊ NHIỄM BỆNH KHÔNG?';
      case PersonalityGroup.unwell:
        return 'CẢM THẤY KHÔNG KHỎE SAU KHI HIẾN MÁU?';
      case PersonalityGroup.signs:
        return 'CÓ DẤU HIỆU SƯNG, PHÙ NƠI VẾT CHÍCH?';
      case PersonalityGroup.preparedonate:
        return 'NGÀY MAI TÔI SẼ HIẾN MÁU, TÔI NÊN CHUẨN BỊ NHƯ THẾ NÀO?';
      case PersonalityGroup.abnormal:
        return 'KHI PHÁT HIỆN BẤT THƯỜNG, CẢM THẤY KHÔNG AN TOÀN VỚI TÚI MÁU VỪA HIẾN?';
      case PersonalityGroup.needblood:
        return 'TẠI SAO CÓ NHIỀU NGƯỜI CẦN PHẢI ĐƯỢC TRUYỀN MÁU?';
      case PersonalityGroup.health:
        return 'HIẾN MÁU NHÂN ĐẠO CÓ HẠI ĐẾN SỨC KHOẺ KHÔNG?';
      case PersonalityGroup.delay:
        return 'NHỮNG TRƯỜNG HỢP NÀO CẦN PHẢI TRÌ HOÃN HIẾN MÁU?';
    }
  }

  IconData? get icon {
    switch (this) {
      case PersonalityGroup.location:
        return Icons.location_on_outlined;
      case PersonalityGroup.time:
        return Icons.access_time_rounded;
      case PersonalityGroup.condition:
        return Icons.add_task_rounded;
      case PersonalityGroup.note:
        return Icons.not_listed_location_outlined;
      case PersonalityGroup.image:
        return Icons.more_outlined;
      case PersonalityGroup.benefit:
        return Icons.volunteer_activism_outlined;
      case PersonalityGroup.testing:
        return Icons.candlestick_chart_outlined;
      case PersonalityGroup.cmnd:
        return Icons.photo_camera_front_outlined;
      case PersonalityGroup.contagious:
        return Icons.ac_unit_sharp;
      case PersonalityGroup.unwell:
        return Icons.announcement_outlined;
      case PersonalityGroup.signs:
        return Icons.personal_injury_outlined;
      case PersonalityGroup.preparedonate:
        return Icons.offline_bolt_outlined;
      case PersonalityGroup.abnormal:
        return Icons.warning_amber;
      case PersonalityGroup.needblood:
        return Icons.model_training_sharp;
      case PersonalityGroup.health:
        return Icons.health_and_safety_outlined;
      case PersonalityGroup.delay:
        return Icons.back_hand_outlined;
    }
  }
}
