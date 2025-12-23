import 'package:blood_donation/models/transaction_detail.dart';

class Transaction {
  final int giaoDichId;
  final int loaiPhieu;
  final int tinhTrang;
  final DateTime ngay;
  final String maDonViCapMau;
  final String ghiChu;
  final String createdBy;
  final DateTime createdDate;
  final String updatedBy;
  final List<DetailedTransactions> giaoDichChiTiets;
  final String donViCapMau;

  Transaction({
    required this.giaoDichId,
    required this.loaiPhieu,
    required this.tinhTrang,
    required this.ngay,
    required this.maDonViCapMau,
    required this.ghiChu,
    required this.createdBy,
    required this.createdDate,
    required this.updatedBy,
    required this.giaoDichChiTiets,
    required this.donViCapMau,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      giaoDichId: json['giaoDichId'],
      loaiPhieu: json['loaiPhieu'],
      tinhTrang: json['tinhTrang'],
      ngay: DateTime.parse(json['ngay']),
      maDonViCapMau: json['maDonViCapMau'],
      ghiChu: json['ghiChu'],
      createdBy: json['createdBy'],
      createdDate: DateTime.parse(json['createdDate']),
      updatedBy: json['updatedBy'],
      giaoDichChiTiets: (json['giaoDichChiTiets'] as List)
          .map((i) => DetailedTransactions.fromJson(i))
          .toList(),
      donViCapMau: json['donViCapMau'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'giaoDichId': giaoDichId,
      'loaiPhieu': loaiPhieu,
      'tinhTrang': tinhTrang,
      'ngay': ngay.toIso8601String(),
      'maDonViCapMau': maDonViCapMau,
      'ghiChu': ghiChu,
      'createdBy': createdBy,
      'createdDate': createdDate.toIso8601String(),
      'updatedBy': updatedBy,
      'giaoDichChiTiets': giaoDichChiTiets.map((i) => i.toJson()).toList(),
      'donViCapMau': donViCapMau,
    };
  }
}
