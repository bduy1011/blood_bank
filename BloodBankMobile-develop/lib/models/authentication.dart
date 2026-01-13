// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:blood_donation/models/blood_donor.dart';
import 'package:blood_donation/models/user_role.dart';

class Authentication {
  String? message;
  String? accessToken;
  String? userCode;
  String? name;
  String? phoneNumber;
  String? cmnd;
  DateTime? ngaySinh;
  int? status;
  int? appRole;
  BloodDonor? dmNguoiHienMau;
  int? soLanHienMau;
  DateTime? ngayHienMauGanNhat;
  bool? duongTinhGanNhat;

  Authentication({
    this.message,
    this.accessToken,
    this.userCode,
    this.name,
    this.status,
    this.appRole,
    this.dmNguoiHienMau,
    this.phoneNumber,
    this.cmnd,
    this.ngaySinh,
    this.soLanHienMau,
    this.ngayHienMauGanNhat,
    this.duongTinhGanNhat,
  });

  Map<String, dynamic> toJson() {
    final result = <String, dynamic>{};

    result.addAll({'message': message});
    result.addAll({'accessToken': accessToken});
    result.addAll({'userCode': userCode});
    result.addAll({'name': name});
    result.addAll({'status': status});
    result.addAll({'appRole': appRole});
    result.addAll({'phoneNumber': phoneNumber});
    result.addAll({'cmnd': cmnd});
    result.addAll({'ngaySinh': ngaySinh?.toIso8601String()});
    if (dmNguoiHienMau != null) {
      result.addAll({'dmNguoiHienMau': dmNguoiHienMau!.toJson()});
    }
    result.addAll({'soLanHienMau': soLanHienMau});
    result
        .addAll({'ngayHienMauGanNhat': ngayHienMauGanNhat?.toIso8601String()});
    result.addAll({
      'duongTinhGanNhat': duongTinhGanNhat,
    });
    return result;
  }

  Authentication.fromJson(Map<String, dynamic> map) {
    message = map['message'] ?? '';
    accessToken = map['accessToken'] ?? '';
    userCode = map['userCode'] ?? '';
    name = map['name'] ?? '';
    status = map['status']?.toInt() ?? 0;
    appRole = map['appRole']?.toInt() ?? 0;
    phoneNumber = map['phoneNumber'];
    cmnd = map['cmnd'] ?? map['idCardNr'];
    ngaySinh = map['ngaySinh'] != null
        ? DateTime.parse(map['ngaySinh'])
        : null;
    dmNguoiHienMau = map['dmNguoiHienMau'] != null
        ? BloodDonor.fromJson(map['dmNguoiHienMau'])
        : null;
    soLanHienMau = map['soLanHienMau'];
    ngayHienMauGanNhat = map['ngayHienMauGanNhat'] != null
        ? DateTime.parse(map['ngayHienMauGanNhat'])
        : null;
    duongTinhGanNhat = map['duongTinhGanNhat'];
  }

  // Authentication copyWith({
  //   String? message,
  //   String? accessToken,
  //   String? userCode,
  //   String? name,
  //   String? phoneNumber,
  //   String? cmnd,
  //   int? status,
  //   int? appRole,
  //   BloodDonor? dmNguoiHienMau,
  // }) {
  //   return Authentication(
  //     message: message ?? this.message,
  //     accessToken: accessToken ?? this.accessToken,
  //     userCode: userCode ?? this.userCode,
  //     name: name ?? this.name,
  //     status: status ?? this.status,
  //     appRole: appRole ?? this.appRole,
  //     cmnd: cmnd ?? this.cmnd,
  //     phoneNumber: phoneNumber ?? this.phoneNumber,
  //     dmNguoiHienMau: dmNguoiHienMau ?? this.dmNguoiHienMau,
  //   );
  // }
}

extension AuthenticationExt on Authentication {
  UserRole get role => UserRole.values.firstWhere((e) => e.value == appRole);
}
