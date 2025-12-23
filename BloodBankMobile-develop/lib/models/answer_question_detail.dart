// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:blood_donation/utils/extension/datetime_extension.dart';

class AnswerQuestionDetail {
  int? id;
  int? surveyQuestionId;
  bool? yesAnswer;
  bool? noAnswer;
  DateTime? onDate;
  String? ghiChu;
  int? traLoiCauHoiId;

  AnswerQuestionDetail({
    this.id,
    this.surveyQuestionId,
    this.yesAnswer,
    this.noAnswer,
    this.onDate,
    this.ghiChu,
    this.traLoiCauHoiId,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'surveyQuestionId': surveyQuestionId,
      'yesAnswer': yesAnswer,
      'noAnswer': noAnswer,
      'onDate': onDate?.toIso8601String(),
      'ghiChu': ghiChu,
      'traLoiCauHoiId': traLoiCauHoiId,
    };
  }

  AnswerQuestionDetail.fromJson(Map<String, dynamic> map) {
    id = map['id'];
    surveyQuestionId = map['surveyQuestionId'];
    yesAnswer = map['yesAnswer'];
    noAnswer = map['noAnswer'];
    onDate = map["onDate"] != null ? DateTime.parse(map["onDate"]) : null;
    ghiChu = map['ghiChu'] as String;
    traLoiCauHoiId = map['traLoiCauHoiId'] as int;
  }
}

class SurveyQuestions {
  int? id;
  String? content;
  bool? no;
  bool? yes;
  DateTime? onDate;
  String? notes;
  bool? maleSkip;

  SurveyQuestions(
      {this.id,
      this.content,
      this.no,
      this.yes,
      this.onDate,
      this.notes,
      this.maleSkip});

  SurveyQuestions.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    content = json['content'];
    no = json['no'];
    yes = json['yes'];
    onDate = json['onDate'] != null ? DateTime.parse(json['onDate']) : null;
    notes = json['notes'];
    maleSkip = json['maleSkip'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['content'] = content;
    data['no'] = no;
    data['yes'] = yes;
    data['onDate'] = onDate?.toIso8601String();
    data['notes'] = notes;
    data['maleSkip'] = maleSkip;
    return data;
  }

  String toStringQrCode() {
    // final Map<String, dynamic> data = <String, dynamic>{};
    // data['id'] = id;
    // data['no'] = no;
    // data['yes'] = yes;
    // data['onDate'] = onDate?.toIso8601String();
    // data['notes'] = notes;
    // data.removeWhere((key, v) => v == null);

    String rs =
        "$id|${yes == true ? "yes" : no == true ? "no" : ""}|${onDate?.dateTimeFormatStringShort ?? ""}|${notes ?? ""}";

    return rs;
  }
}
