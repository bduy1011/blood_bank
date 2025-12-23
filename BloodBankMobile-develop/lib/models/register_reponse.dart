import 'blood_donor.dart';

class RegisterResponse {
  String? userCode;
  String? name;
  String? password;
  int? appRole;
  bool? active;
  String? macAddress;
  String? phoneNumber;
  String? otpCode;
  String? expiredOn;
  bool? acceptedOtp;
  bool? isDataQLMau;
  String? accessToken;
  String? idCardNr;
  BloodDonor? dmNguoiHienMau;
  int? soLanHienMau;
  DateTime? ngayHienMauGanNhat;
  bool? duongTinhGanNhat;

  RegisterResponse({
    this.userCode,
    this.name,
    this.password,
    this.appRole,
    this.active,
    this.macAddress,
    this.phoneNumber,
    this.otpCode,
    this.expiredOn,
    this.acceptedOtp,
    this.isDataQLMau,
    this.accessToken,
    this.idCardNr,
    this.dmNguoiHienMau,
    this.soLanHienMau,
    this.ngayHienMauGanNhat,
    this.duongTinhGanNhat,
  });

  RegisterResponse.fromJson(Map<String, dynamic> json) {
    userCode = json['userCode']?.toString();
    name = json['name'].toString();
    password = json['password']?.toString();
    appRole = json['appRole'];
    active = json['active'];
    macAddress = json['macAddress']?.toString();
    phoneNumber = json['phoneNumber']?.toString();
    otpCode = json['otpCode']?.toString();
    expiredOn = json['expiredOn']?.toString();
    acceptedOtp = json['acceptedOtp'];
    isDataQLMau = json['isDataQLMau'];
    accessToken = json['accessToken'];
    idCardNr = json['idCardNr'];
    dmNguoiHienMau = json['dmNguoiHienMau'] != null
        ? BloodDonor.fromJson(json['dmNguoiHienMau'])
        : null;
    soLanHienMau = json['soLanHienMau'];
    ngayHienMauGanNhat = json['ngayHienMauGanNhat'] != null
        ? DateTime.parse(json['ngayHienMauGanNhat'])
        : null;
    duongTinhGanNhat = json['duongTinhGanNhat'];
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userCode'] = userCode;
    data['name'] = name;
    data['password'] = password;
    data['appRole'] = appRole;
    data['active'] = active;
    data['macAddress'] = macAddress;
    data['phoneNumber'] = phoneNumber;
    data['otpCode'] = otpCode;
    data['expiredOn'] = expiredOn;
    data['acceptedOtp'] = acceptedOtp;
    data['isDataQLMau'] = isDataQLMau;
    data['idCardNr'] = idCardNr;
    data['accessToken'] = accessToken;
    data['dmNguoiHienMau'] = dmNguoiHienMau?.toJson();
    data['soLanHienMau'] = soLanHienMau;
    data['ngayHienMauGanNhat'] = ngayHienMauGanNhat;
    data['duongTinhGanNhat'] = duongTinhGanNhat;

    return data;
  }
}
