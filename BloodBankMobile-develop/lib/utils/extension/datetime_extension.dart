import 'package:intl/intl.dart';

const String defaultDateFormat = "dd/MM/yyyy";
const String defaultDateTimeFormat = "dd/MM/yyyy HH:mm";
const String defaultYYYYMMdd = "yyyy-MM-dd";
const String defaultDateTimeFormatShort = "ddMMyyyyHHmm";
const String defaultTimeFormat = "HH:mm";

extension DateTimeExtensions on DateTime {
  DateTime get firstDateOfMonth => DateTime(year, month);

  DateTime get lastDateOfMonth => DateTime(year, month + 1, 0);
  String get dateTimeFormatStringShort {
    return DateFormat(defaultDateTimeFormatShort).format(toLocal());
  }

  String get dateYYYYMMddString {
    return DateFormat(defaultYYYYMMdd).format(toLocal());
  }

  String get dateTimeString {
    // if (isToday()) {
    //   return "Hôm nay";
    // }
    return DateFormat(defaultDateFormat).format(toLocal());
  }

  String get dateTimeHourString {
    // if (isToday()) {
    //   return "Hôm nay ${DateFormat(defaultDateTimeFormat).format(toLocal())}";
    // }
    return DateFormat(defaultDateTimeFormat).format(toLocal());
  }

  String get ddmmyyyy {
    return DateFormat(defaultDateFormat).format(toLocal());
  }

  String get timeHourString {
    return DateFormat(defaultTimeFormat).format(toLocal());
  }

  isToday() {
    final now = DateTime.now();
    return now.year == year && now.month == month && now.day == day;
  }

  String get dayInWeek {
    switch (weekday) {
      case DateTime.monday:
        return "Thứ hai";
      case DateTime.tuesday:
        return "Thứ ba";
      case DateTime.wednesday:
        return "Thứ tư";
      case DateTime.thursday:
        return "Thứ năm";
      case DateTime.friday:
        return "Thứ sáu";
      case DateTime.saturday:
        return "Thứ bảy";
      case DateTime.sunday:
        return "Chủ nhật";
      default:
        return "";
    }
  }
}
