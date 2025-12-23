import 'package:blood_donation/models/giao_dich_template.dart';

class GiaodichResponse {
  int? giaoDichId;
  int? loaiPhieu;
  int? tinhTrang;
  DateTime? ngay;
  String? maDonViCapMau;
  String? ghiChu;
  String? createdBy;
  DateTime? createdDate;
  String? updatedBy;
  DateTime? updatedDate;
  bool? isLocked;
  String? loaiPhieuDescription;
  String? tinhTrangDescription;
  GiaoDichChiTietViews? giaoDichChiTietViews;
  String? donViCapMauName;
  String? creatorName;
  double? totalApproveQuantity;
  double? totalQuantity;
  GiaodichResponse({
    this.giaoDichId,
    this.loaiPhieu,
    this.tinhTrang,
    this.ngay,
    this.maDonViCapMau,
    this.ghiChu,
    this.createdBy,
    this.createdDate,
    this.updatedBy,
    this.updatedDate,
    this.isLocked,
    this.loaiPhieuDescription,
    this.tinhTrangDescription,
    this.giaoDichChiTietViews,
    this.creatorName,
    this.donViCapMauName,
    this.totalApproveQuantity,
    this.totalQuantity,
  });

  GiaodichResponse.fromJson(Map<String, dynamic> json) {
    giaoDichId = json['giaoDichId'];
    loaiPhieu = json['loaiPhieu'];
    tinhTrang = json['tinhTrang'];
    ngay = json['ngay'] != null ? DateTime.parse(json['ngay']) : null;
    maDonViCapMau = json['maDonViCapMau'];
    ghiChu = json['ghiChu'];
    createdBy = json['createdBy'];
    createdDate = json['createdDate'] != null
        ? DateTime.parse(json['createdDate'])
        : null;
    updatedBy = json['updatedBy'];
    updatedDate = json['updatedDate'] != null
        ? DateTime.parse(json['updatedDate'])
        : null;
    isLocked = json['isLocked'];
    loaiPhieuDescription = json['loaiPhieuDescription'];
    tinhTrangDescription = json['tinhTrangDescription'];
    giaoDichChiTietViews = json['giaoDichChiTietViews'];
    creatorName = json['creatorName'];
    donViCapMauName = json['donViCapMauName'];
    totalApproveQuantity = json['totalApproveQuantity'];
    totalQuantity = json['totalQuantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['giaoDichId'] = giaoDichId;
    data['loaiPhieu'] = loaiPhieu;
    data['tinhTrang'] = tinhTrang;
    data['ngay'] = ngay?.toIso8601String();
    data['maDonViCapMau'] = maDonViCapMau;
    data['ghiChu'] = ghiChu;
    data['createdBy'] = createdBy;
    data['createdDate'] = createdDate?.toIso8601String();
    data['updatedBy'] = updatedBy;
    data['updatedDate'] = updatedDate?.toIso8601String();
    data['isLocked'] = isLocked;
    data['loaiPhieuDescription'] = loaiPhieuDescription;
    data['tinhTrangDescription'] = tinhTrangDescription;
    data['giaoDichChiTietViews'] = giaoDichChiTietViews;
    data['creatorName'] = creatorName;
    data['donViCapMauName'] = donViCapMauName;
    data['totalApproveQuantity'] = totalApproveQuantity;
    data['totalQuantity'] = totalQuantity;
    return data;
  }
}
