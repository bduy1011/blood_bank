import 'package:blood_donation/models/transaction.dart';

class BloodSupplyUnit {
  final String maDonVi;
  final String tenDonVi;
  final String diaChi;
  final String dienThoai;
  final bool isBvNhi;
  final bool isDonViCapMau;
  final bool isDonViNhanMau;
  final int uuTien;
  final bool active;
  final List<Transaction> giaoDichs;
  final bool isHienThiApp;

  BloodSupplyUnit({
    required this.maDonVi,
    required this.tenDonVi,
    required this.diaChi,
    required this.dienThoai,
    required this.isBvNhi,
    required this.isDonViCapMau,
    required this.isDonViNhanMau,
    required this.uuTien,
    required this.active,
    required this.giaoDichs,
    required this.isHienThiApp,
  });

  factory BloodSupplyUnit.fromJson(Map<String, dynamic> json) {
    return BloodSupplyUnit(
      maDonVi: json['maDonVi'],
      tenDonVi: json['tenDonVi'],
      diaChi: json['diaChi'],
      dienThoai: json['dienThoai'],
      isBvNhi: json['isBvNhi'],
      isDonViCapMau: json['isDonViCapMau'],
      isDonViNhanMau: json['isDonViNhanMau'],
      uuTien: json['uuTien'],
      active: json['active'],
      giaoDichs: (json['giaoDichs'] as List)
          .map((i) => Transaction.fromJson(i))
          .toList(),
      isHienThiApp: json['isHienThiApp'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'maDonVi': maDonVi,
      'tenDonVi': tenDonVi,
      'diaChi': diaChi,
      'dienThoai': dienThoai,
      'isBvNhi': isBvNhi,
      'isDonViCapMau': isDonViCapMau,
      'isDonViNhanMau': isDonViNhanMau,
      'uuTien': uuTien,
      'active': active,
      'giaoDichs': giaoDichs.map((i) => i.toJson()).toList(),
      'isHienThiApp': isHienThiApp,
    };
  }
}
