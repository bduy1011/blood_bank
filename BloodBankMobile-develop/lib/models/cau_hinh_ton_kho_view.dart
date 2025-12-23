import 'package:get/get.dart';

class CauHinhTonKho {
  int? id;
  DateTime? ngay;
  List<CauHinhTonKhoChiTietViews>? cauHinhTonKhoChiTietViews;

  CauHinhTonKho({this.id, this.ngay, this.cauHinhTonKhoChiTietViews});

  CauHinhTonKho.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    ngay = json['ngay'] != null ? DateTime.parse(json['ngay']) : null;
    if (json['cauHinhTonKhoChiTietViews'] != null) {
      cauHinhTonKhoChiTietViews = <CauHinhTonKhoChiTietViews>[];
      json['cauHinhTonKhoChiTietViews'].forEach((v) {
        cauHinhTonKhoChiTietViews!.add(CauHinhTonKhoChiTietViews.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['ngay'] = ngay?.toIso8601String();
    if (cauHinhTonKhoChiTietViews != null) {
      data['cauHinhTonKhoChiTietViews'] =
          cauHinhTonKhoChiTietViews!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CauHinhTonKhoChiTietViews {
  int? id;
  int? cauHinhTonKhoId;
  int? loaiSanPham;
  String? loaiSanPhamDescription;
  List<CauHinhTonKhoChiTietConViews>? cauHinhTonKhoChiTietConViews;

  ///ui
  bool isExpaned = false;
  RxString title = "".obs;

  void updateTitle() {
    var sum = cauHinhTonKhoChiTietConViews?.fold(
            0, (total, giaoDich) => (total) + (giaoDich.soLuong ?? 0)) ??
        0;
    title.value = "$loaiSanPhamDescription${sum > 0 ? " ($sum)" : ""}";
  }

  ///
  CauHinhTonKhoChiTietViews(
      {this.id,
      this.cauHinhTonKhoId,
      this.loaiSanPham,
      this.loaiSanPhamDescription,
      this.cauHinhTonKhoChiTietConViews});

  CauHinhTonKhoChiTietViews.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    cauHinhTonKhoId = json['cauHinhTonKhoId'];
    loaiSanPham = json['loaiSanPham'];
    loaiSanPhamDescription = json['loaiSanPhamDescription'];
    if (json['cauHinhTonKhoChiTietConViews'] != null) {
      cauHinhTonKhoChiTietConViews = <CauHinhTonKhoChiTietConViews>[];
      json['cauHinhTonKhoChiTietConViews'].forEach((v) {
        cauHinhTonKhoChiTietConViews!
            .add(CauHinhTonKhoChiTietConViews.fromJson(v));
      });
    }
    updateTitle();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['cauHinhTonKhoId'] = cauHinhTonKhoId;
    data['loaiSanPham'] = loaiSanPham;
    data['loaiSanPhamDescription'] = loaiSanPhamDescription;
    if (cauHinhTonKhoChiTietConViews != null) {
      data['cauHinhTonKhoChiTietConViews'] =
          cauHinhTonKhoChiTietConViews!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CauHinhTonKhoChiTietConViews {
  int? id;
  int? cauHinhTonKhoChiTietId;
  int? soLuong;
  int? soLuongDuocBooking;
  int? maNhomMau;
  String? maNhomMauDescription;

  CauHinhTonKhoChiTietConViews(
      {this.id,
      this.cauHinhTonKhoChiTietId,
      this.soLuong,
      this.soLuongDuocBooking,
      this.maNhomMau,
      this.maNhomMauDescription});

  CauHinhTonKhoChiTietConViews.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    cauHinhTonKhoChiTietId = json['cauHinhTonKhoChiTietId'];
    soLuong = json['soLuong'];
    soLuongDuocBooking = json['soLuongDuocBooking'];
    maNhomMau = json['maNhomMau'];
    maNhomMauDescription = json['maNhomMauDescription'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['cauHinhTonKhoChiTietId'] = cauHinhTonKhoChiTietId;
    data['soLuong'] = soLuong;
    data['soLuongDuocBooking'] = soLuongDuocBooking;
    data['maNhomMau'] = maNhomMau;
    data['maNhomMauDescription'] = maNhomMauDescription;
    return data;
  }
}
