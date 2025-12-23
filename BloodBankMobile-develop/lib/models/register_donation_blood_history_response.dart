import 'package:blood_donation/models/answer_question.dart';
import 'package:blood_donation/utils/extension/string_ext.dart';

import 'answer_question_detail.dart';
import 'register_donation_blood.dart';

class RegisterDonationBloodHistoryResponse extends RegisterDonationBlood {
  String? tinhTrangDescription;
  @override
  List<SurveyQuestions>? surveyQuestions;
  @override
  int? id;
  @override
  DateTime? ngay;
  @override
  int? nguoiHienMauId;
  @override
  String? hoVaTen;
  @override
  DateTime? ngaySinh;
  @override
  int? namSinh;
  @override
  String? cmnd;
  @override
  bool? gioiTinh;
  @override
  String? maXa;
  @override
  String? tenXa;
  @override
  String? maHuyen;
  @override
  String? tenHuyen;
  @override
  String? maTinh;
  @override
  String? tenTinh;
  @override
  String? diaChiLienLac;
  @override
  String? diaChiThuongTru;
  @override
  String? ngheNghiep;
  @override
  String? email;
  @override
  String? soDT;
  @override
  String? site;
  @override
  int? tinhTrang;
  @override
  String? coQuan;
  @override
  int? traLoiCauHoiId;
  @override
  AnswerQuestion? traLoiCauHoi;
  @override
  int? dotLayMauId;

  RegisterDonationBloodHistoryResponse(
      {this.tinhTrangDescription,
      this.surveyQuestions,
      this.id,
      this.ngay,
      this.nguoiHienMauId,
      this.hoVaTen,
      this.ngaySinh,
      this.namSinh,
      this.cmnd,
      this.gioiTinh,
      this.maXa,
      this.tenXa,
      this.maHuyen,
      this.tenHuyen,
      this.maTinh,
      this.tenTinh,
      this.diaChiLienLac,
      this.diaChiThuongTru,
      this.ngheNghiep,
      this.email,
      this.soDT,
      this.site,
      this.tinhTrang,
      this.coQuan,
      this.traLoiCauHoiId,
      this.traLoiCauHoi,
      this.dotLayMauId});

  RegisterDonationBloodHistoryResponse.fromJson(Map<String, dynamic> json) {
    tinhTrangDescription = json['tinhTrangDescription']?.toString();
    surveyQuestions = json['surveyQuestions'] != null
        ? List<SurveyQuestions>.from(
            json['surveyQuestions'].map((x) => SurveyQuestions.fromJson(x)))
        : null;
    id = json['id'];
    ngay = json['ngay'] != null ? DateTime.parse(json['ngay']) : null;
    nguoiHienMauId = json['nguoiHienMauId'];
    hoVaTen = json['hoVaTen']?.toString();
    ngaySinh =
        json['ngaySinh'] != null ? DateTime.parse(json['ngaySinh']) : null;
    namSinh = json['namSinh']?.toString().toIntOrNull;
    cmnd = json['cmnd']?.toString();
    gioiTinh = json['gioiTinh'];
    maXa = json['maXa']?.toString();
    tenXa = json['tenXa']?.toString();
    maHuyen = json['maHuyen']?.toString();
    tenHuyen = json['tenHuyen']?.toString();
    maTinh = json['maTinh']?.toString();
    tenTinh = json['tenTinh']?.toString();
    diaChiLienLac = json['diaChiLienLac']?.toString();
    diaChiThuongTru = json['diaChiThuongTru']?.toString();
    ngheNghiep = json['ngheNghiep']?.toString();
    email = json['email']?.toString();
    soDT = json['soDT']?.toString();
    site = json['site']?.toString();
    tinhTrang = json['tinhTrang'];
    coQuan = json['coQuan']?.toString();
    traLoiCauHoiId = json['traLoiCauHoiId']?.toString().toIntOrNull;
    traLoiCauHoi = traLoiCauHoi = json['traLoiCauHoi'] != null
        ? AnswerQuestion.fromJson(json['traLoiCauHoi'])
        : null;
    dotLayMauId = json['dotLayMauId'];
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['tinhTrangDescription'] = tinhTrangDescription;
    data['surveyQuestions'] = surveyQuestions;
    data['id'] = id;
    data['ngay'] = ngay?.toIso8601String();
    data['nguoiHienMauId'] = nguoiHienMauId;
    data['hoVaTen'] = hoVaTen;
    data['ngaySinh'] = ngaySinh?.toIso8601String();
    data['namSinh'] = namSinh;
    data['cmnd'] = cmnd;
    data['gioiTinh'] = gioiTinh;
    data['maXa'] = maXa;
    data['tenXa'] = tenXa;
    data['maHuyen'] = maHuyen;
    data['tenHuyen'] = tenHuyen;
    data['maTinh'] = maTinh;
    data['tenTinh'] = tenTinh;
    data['diaChiLienLac'] = diaChiLienLac;
    data['diaChiThuongTru'] = diaChiThuongTru;
    data['ngheNghiep'] = ngheNghiep;
    data['email'] = email;
    data['soDT'] = soDT;
    data['site'] = site;
    data['tinhTrang'] = tinhTrang;
    data['coQuan'] = coQuan;
    data['traLoiCauHoiId'] = traLoiCauHoiId;
    data['traLoiCauHoi'] = traLoiCauHoi;
    data['dotLayMauId'] = dotLayMauId;
    data['surveyQuestions'] = surveyQuestions?.map((e) => e.toJson()).toList();

    return data;
  }
}
