import 'package:get/get.dart';

import 'dm_don_vi_cap_mau_response.dart';

class GiaoDichTemplate {
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
  List<GiaoDichChiTietViews>? giaoDichChiTietViews;
  DmDonViCapMauResponse? dmDonViCapMauResponse;

  GiaoDichTemplate(
      {this.giaoDichId,
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
      this.giaoDichChiTietViews});

  GiaoDichTemplate.fromJson(Map<String, dynamic> json) {
    giaoDichId = json['giaoDichId'];
    loaiPhieu = json['loaiPhieu'];
    tinhTrang = json['tinhTrang'];
    ngay = json['ngay'] != null ? DateTime.parse(json['ngay']) : null;
    maDonViCapMau = json['maDonViCapMau']?.toString();
    ghiChu = json['ghiChu'];
    createdBy = json['createdBy']?.toString();
    createdDate = json['createdDate'] != null
        ? DateTime.parse(json['createdDate'])
        : null;
    updatedBy = json['updatedBy']?.toString();
    updatedDate = json['updatedDate'] != null
        ? DateTime.parse(json['updatedDate'])
        : null;
    isLocked = json['isLocked'];
    loaiPhieuDescription = json['loaiPhieuDescription'];
    tinhTrangDescription = json['tinhTrangDescription'];
    if (json['giaoDichChiTietViews'] != null) {
      giaoDichChiTietViews = <GiaoDichChiTietViews>[];
      json['giaoDichChiTietViews'].forEach((v) {
        giaoDichChiTietViews!.add(GiaoDichChiTietViews.fromJson(v));
      });
    }
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
    if (giaoDichChiTietViews != null) {
      data['giaoDichChiTietViews'] =
          giaoDichChiTietViews!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GiaoDichChiTietViews {
  int? giaoDichChiTietId;
  int? giaoDichId;
  int? loaiSanPham;
  String? dienGiai;
  String? loaiSanPhamDescription;
  List<GiaoDichConViews>? giaoDichConViews;

  ///
  bool isExpaned = false;
  RxString title = "".obs;
  RxInt sum = 0.obs;

  void updateTitle() {
    var sum = giaoDichConViews?.fold(
            0, (total, giaoDich) => (total) + (giaoDich.soLuong ?? 0)) ??
        0;
    title.value = "$loaiSanPhamDescription${sum > 0 ? " ($sum)" : ""}";
    this.sum.value = sum;
  }

  GiaoDichChiTietViews(
      {this.giaoDichChiTietId,
      this.giaoDichId,
      this.loaiSanPham,
      this.dienGiai,
      this.loaiSanPhamDescription,
      this.giaoDichConViews});

  GiaoDichChiTietViews.fromJson(Map<String, dynamic> json) {
    giaoDichChiTietId = json['giaoDichChiTietId'];
    giaoDichId = json['giaoDichId'];
    loaiSanPham = json['loaiSanPham'];
    dienGiai = json['dienGiai'];
    loaiSanPhamDescription = json['loaiSanPhamDescription'];
    if (json['giaoDichConViews'] != null) {
      giaoDichConViews = <GiaoDichConViews>[];
      json['giaoDichConViews'].forEach((v) {
        giaoDichConViews!.add(GiaoDichConViews.fromJson(v));
      });
    }
    updateTitle();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['giaoDichChiTietId'] = giaoDichChiTietId;
    data['giaoDichId'] = giaoDichId;
    data['loaiSanPham'] = loaiSanPham;
    data['dienGiai'] = dienGiai;
    data['loaiSanPhamDescription'] = loaiSanPhamDescription;
    if (giaoDichConViews != null) {
      data['giaoDichConViews'] =
          giaoDichConViews!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GiaoDichConViews {
  int? id;
  int? maNhomMau;
  int? soLuong;
  bool? daDuyet;
  String? approvedBy;
  DateTime? approvedOn;
  int? giaoDichChiTietId;
  int? soLuongDuyet;
  String? maNhomMauDescription;

  /// add after initTonkho
  int? soLuongTon;

  RxInt soLuongObs = 0.obs;

  GiaoDichConViews(
      {this.id,
      this.maNhomMau,
      this.soLuong,
      this.daDuyet,
      this.approvedBy,
      this.approvedOn,
      this.giaoDichChiTietId,
      this.soLuongDuyet,
      this.maNhomMauDescription});

  GiaoDichConViews.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    maNhomMau = json['maNhomMau'];
    soLuong = json['soLuong'];
    daDuyet = json['daDuyet'];
    approvedBy = json['approvedBy']?.toString();
    approvedOn =
        json['approvedOn'] != null ? DateTime.parse(json['approvedOn']) : null;
    giaoDichChiTietId = json['giaoDichChiTietId'];
    soLuongDuyet = json['soLuongDuyet'];
    maNhomMauDescription = json['maNhomMauDescription'];
    soLuongObs.value = soLuong ?? 0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['maNhomMau'] = maNhomMau;
    data['soLuong'] = soLuong;
    data['daDuyet'] = daDuyet;
    data['approvedBy'] = approvedBy;
    data['approvedOn'] = approvedOn?.toIso8601String();
    data['giaoDichChiTietId'] = giaoDichChiTietId;
    data['soLuongDuyet'] = soLuongDuyet;
    data['maNhomMauDescription'] = maNhomMauDescription;
    return data;
  }
}
