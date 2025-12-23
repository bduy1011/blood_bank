// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:blood_donation/models/answer_question_detail.dart';

class AnswerQuestion {
  int? id;
  DateTime? ngay;
  String? ghiChu;
  List<AnswerQuestionDetail>? traLoiCauHoiChiTiets;
  // final BloodDonationEvent bloodDonationEvent;

  AnswerQuestion({
    required this.id,
    required this.ngay,
    required this.ghiChu,
    required this.traLoiCauHoiChiTiets,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'ngay': ngay?.toIso8601String(),
      'ghiChu': ghiChu,
      'traLoiCauHoiChiTiets':
          traLoiCauHoiChiTiets?.map((x) => x.toJson()).toList(),
      // 'bloodDonationEvent': bloodDonationEvent.toJson(),
    };
  }

  AnswerQuestion.fromJson(Map<String, dynamic> map) {
    id = map['id'];
    ngay = map['ngay'] != null ? DateTime.parse(map['ngay']) : null;
    ghiChu = map['ghiChu'];
    traLoiCauHoiChiTiets = List<AnswerQuestionDetail>.from(
      (map['traLoiCauHoiChiTiets']).map<AnswerQuestionDetail>(
        (x) => AnswerQuestionDetail.fromJson(x as Map<String, dynamic>),
      ),
    );
  }

  AnswerQuestion copyWith({
    int? id,
    DateTime? ngay,
    String? ghiChu,
    List<AnswerQuestionDetail>? answerQuestionDetails,
  }) {
    return AnswerQuestion(
      id: id ?? this.id,
      ngay: ngay ?? this.ngay,
      ghiChu: ghiChu ?? this.ghiChu,
      traLoiCauHoiChiTiets: answerQuestionDetails ?? traLoiCauHoiChiTiets,
    );
  }
}
