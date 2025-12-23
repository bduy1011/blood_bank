// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:blood_donation/models/answer_question.dart';
import 'package:blood_donation/utils/extension/datetime_extension.dart';

import 'answer_question_detail.dart';

class RegisterDonationBlood {
  int? id;
  DateTime? ngay;
  int? nguoiHienMauId;
  String? hoVaTen;
  DateTime? ngaySinh;
  int? namSinh;
  String? cmnd;
  bool? gioiTinh;
  String? maXa;
  String? tenXa;
  String? maHuyen;
  String? tenHuyen;
  String? maTinh;
  String? tenTinh;
  String? diaChiLienLac;
  String? diaChiThuongTru;
  String? ngheNghiep;
  String? email;
  String? soDT;
  String? site;
  int? tinhTrang;
  String? coQuan;
  String? maDonViCapMau;
  // final BloodSupplyUnit? donViCapMau;
  int? traLoiCauHoiId;
  AnswerQuestion? traLoiCauHoi;
  List<SurveyQuestions>? surveyQuestions;
  int? dotLayMauId;

  RegisterDonationBlood({
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
    this.maDonViCapMau,
    this.traLoiCauHoiId,
    this.traLoiCauHoi,
    this.dotLayMauId,
    this.surveyQuestions,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'ngay': ngay?.toIso8601String(),
      'nguoiHienMauId': nguoiHienMauId,
      'hoVaTen': hoVaTen,
      'ngaySinh': ngaySinh?.toIso8601String(),
      'namSinh': namSinh,
      'cmnd': cmnd,
      'gioiTinh': gioiTinh,
      'maXa': maXa,
      'tenXa': tenXa,
      'maHuyen': maHuyen,
      'tenHuyen': tenHuyen,
      'maTinh': maTinh,
      'tenTinh': tenTinh,
      'diaChiLienLac': diaChiLienLac,
      'diaChiThuongTru': diaChiThuongTru,
      'ngheNghiep': ngheNghiep,
      'email': email,
      'soDT': soDT,
      'site': site,
      'tinhTrang': tinhTrang,
      'coQuan': coQuan,
      'maDonViCapMau': maDonViCapMau,
      'traLoiCauHoiId': traLoiCauHoiId,
      'traLoiCauHoi': traLoiCauHoi?.toJson(),
      'dotLayMauId': dotLayMauId,
      "surveyQuestions": surveyQuestions?.map((e) => e.toJson()).toList(),
    };
  }

  Map<String, dynamic> toJsonQrCode() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data["data"] =
        "${id?.toString() ?? ""}|${traLoiCauHoiId?.toString() ?? ""}|${ngay?.dateTimeFormatStringShort ?? ""}|${nguoiHienMauId?.toString() ?? ""}|${hoVaTen?.toString() ?? ""}|${ngaySinh?.dateTimeFormatStringShort ?? ""}|${namSinh?.toString() ?? ""}|${cmnd?.toString() ?? ""}|${gioiTinh?.toString() ?? ""}|${maXa?.toString() ?? ""}|${maHuyen?.toString() ?? ""}|${maTinh?.toString() ?? ""}|${diaChiLienLac?.toString() ?? ""}|${soDT?.toString() ?? ""}|${site?.toString() ?? ""}|${tinhTrang?.toString() ?? ""}|${email?.toString() ?? ""}|${ngheNghiep?.toString() ?? ""}|${coQuan?.toString() ?? ""}|${dotLayMauId?.toString() ?? ""}";
    data['surveyQuestions'] =
        surveyQuestions?.map((e) => e.toStringQrCode()).toList();
    return data;
  }

  RegisterDonationBlood.fromJson(Map<String, dynamic> map) {
    id = map['id'];
    ngay = map['ngay'] != null ? DateTime.parse(map['ngay']) : null;
    nguoiHienMauId = map['nguoiHienMauId'];
    hoVaTen = map['hoVaTen'];
    ngaySinh = map['ngaySinh'] != null ? DateTime.parse(map['ngaySinh']) : null;
    namSinh = map['namSinh'];
    cmnd = map['cmnd'];
    gioiTinh = map['gioiTinh'];
    maXa = map['maXa'];
    tenXa = map['tenXa'];
    maHuyen = map['maHuyen'];
    tenHuyen = map['tenHuyen'];
    maTinh = map['maTinh'];
    tenTinh = map['tenTinh'];
    diaChiLienLac = map['diaChiLienLac'];
    diaChiThuongTru = map['diaChiThuongTru'];
    ngheNghiep = map['ngheNghiep'];
    email = map['email'];
    soDT = map['soDT'];
    site = map['site'];
    tinhTrang = map['tinhTrang'];
    coQuan = map['coQuan'];
    maDonViCapMau = map['maDonViCapMau'];

    traLoiCauHoiId = map['traLoiCauHoiId'];
    traLoiCauHoi = map['traLoiCauHoi'] != null
        ? AnswerQuestion.fromJson(map['traLoiCauHoi'])
        : null;
    dotLayMauId = map['dotLayMauId'];
    surveyQuestions = map['surveyQuestions'] != null
        ? List<SurveyQuestions>.from(
            map['surveyQuestions'].map((x) => SurveyQuestions.fromJson(x)))
        : null;
  }

  RegisterDonationBlood copyWith({
    int? id,
    DateTime? ngay,
    int? nguoiHienMauId,
    String? hoVaTen,
    DateTime? ngaySinh,
    int? namSinh,
    String? cmnd,
    bool? gioiTinh,
    String? maXa,
    String? tenXa,
    String? maHuyen,
    String? tenHuyen,
    String? maTinh,
    String? tenTinh,
    String? diaChiLienLac,
    String? diaChiThuongTru,
    String? ngheNghiep,
    String? email,
    String? soDT,
    String? site,
    int? tinhTrang,
    String? coQuan,
    String? maDonViCapMau,
    int? traLoiCauHoiId,
    AnswerQuestion? traLoiCauHoi,
    int? dotLayMauId,
    List<SurveyQuestions>? surveyQuestions,
  }) {
    return RegisterDonationBlood(
      id: id ?? this.id,
      ngay: ngay ?? this.ngay,
      nguoiHienMauId: nguoiHienMauId ?? this.nguoiHienMauId,
      hoVaTen: hoVaTen ?? this.hoVaTen,
      ngaySinh: ngaySinh ?? this.ngaySinh,
      namSinh: namSinh ?? this.namSinh,
      cmnd: cmnd ?? this.cmnd,
      gioiTinh: gioiTinh ?? this.gioiTinh,
      maXa: maXa ?? this.maXa,
      tenXa: tenXa ?? this.tenXa,
      maHuyen: maHuyen ?? this.maHuyen,
      tenHuyen: tenHuyen ?? this.tenHuyen,
      maTinh: maTinh ?? this.maTinh,
      tenTinh: tenTinh ?? this.tenTinh,
      diaChiLienLac: diaChiLienLac ?? this.diaChiLienLac,
      diaChiThuongTru: diaChiThuongTru ?? this.diaChiThuongTru,
      ngheNghiep: ngheNghiep ?? this.ngheNghiep,
      email: email ?? this.email,
      soDT: soDT ?? this.soDT,
      site: site ?? this.site,
      tinhTrang: tinhTrang ?? this.tinhTrang,
      coQuan: coQuan ?? this.coQuan,
      maDonViCapMau: maDonViCapMau ?? this.maDonViCapMau,
      traLoiCauHoiId: traLoiCauHoiId ?? this.traLoiCauHoiId,
      traLoiCauHoi: traLoiCauHoi ?? this.traLoiCauHoi,
      dotLayMauId: dotLayMauId ?? this.dotLayMauId,
      surveyQuestions: surveyQuestions ?? this.surveyQuestions,
    );
  }
}
