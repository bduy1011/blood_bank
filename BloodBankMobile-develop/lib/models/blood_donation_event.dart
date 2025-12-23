// ignore_for_file: public_member_api_docs, sort_constructors_first

class BloodDonationEvent {
  int? dotLayMauId;
  int? loaiDot;
  int? tinhTrang;
  int? loaiMau;
  String? ten;
  int? soLuongDuKien;
  DateTime? ngayGio;
  int? nguonLayMau;
  String? donViPhoiHopId;
  String? tenDonViPhoiHop;
  String? diaDiemToChuc;
  String? nguoiLienHe;
  String? maXa;
  String? tenXa;
  String? maHuyen;
  String? tenHuyen;
  String? maTinh;
  String? tenTinh;
  String? googleMapLink;
  String? ghiChu;
  bool? isDuocDangKy;
  int? soLuongDangKyHienMau;

  BloodDonationEvent(
      {this.dotLayMauId,
      this.loaiDot,
      this.tinhTrang,
      this.loaiMau,
      this.ten,
      this.soLuongDuKien,
      this.ngayGio,
      this.nguonLayMau,
      this.donViPhoiHopId,
      this.tenDonViPhoiHop,
      this.diaDiemToChuc,
      this.nguoiLienHe,
      this.maXa,
      this.tenXa,
      this.maHuyen,
      this.tenHuyen,
      this.maTinh,
      this.tenTinh,
      this.googleMapLink,
      this.ghiChu,
      this.isDuocDangKy,
      this.soLuongDangKyHienMau});

  BloodDonationEvent.fromJson(Map<String, dynamic> json) {
    dotLayMauId = json['dotLayMauId'];
    loaiDot = json['loaiDot'];
    tinhTrang = json['tinhTrang'];
    loaiMau = json['loaiMau'];
    ten = json['ten'];
    soLuongDuKien = json['soLuongDuKien'];
    ngayGio = json['ngayGio'] != null ? DateTime.parse(json['ngayGio']) : null;
    nguonLayMau = json['nguonLayMau'];
    donViPhoiHopId = json['donViPhoiHopId'];
    tenDonViPhoiHop = json['tenDonViPhoiHop'];
    diaDiemToChuc = json['diaDiemToChuc'];
    nguoiLienHe = json['nguoiLienHe'];
    maXa = json['maXa'];
    tenXa = json['tenXa'];
    maHuyen = json['maHuyen'];
    tenHuyen = json['tenHuyen'];
    maTinh = json['maTinh'];
    tenTinh = json['tenTinh'];
    googleMapLink = json['googleMapLink'];
    ghiChu = json['ghiChu'];
    isDuocDangKy = json['isDuocDangKy'];
    soLuongDangKyHienMau = json['soLuongDangKyHienMau'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['dotLayMauId'] = dotLayMauId;
    data['loaiDot'] = loaiDot;
    data['tinhTrang'] = tinhTrang;
    data['loaiMau'] = loaiMau;
    data['ten'] = ten;
    data['soLuongDuKien'] = soLuongDuKien;
    data['ngayGio'] = ngayGio?.toIso8601String();
    data['nguonLayMau'] = nguonLayMau;
    data['donViPhoiHopId'] = donViPhoiHopId;
    data['tenDonViPhoiHop'] = tenDonViPhoiHop;
    data['diaDiemToChuc'] = diaDiemToChuc;
    data['nguoiLienHe'] = nguoiLienHe;
    data['maXa'] = maXa;
    data['tenXa'] = tenXa;
    data['maHuyen'] = maHuyen;
    data['tenHuyen'] = tenHuyen;
    data['maTinh'] = maTinh;
    data['tenTinh'] = tenTinh;
    data['googleMapLink'] = googleMapLink;
    data['ghiChu'] = ghiChu;
    data['isDuocDangKy'] = isDuocDangKy;
    data['soLuongDangKyHienMau'] = soLuongDangKyHienMau;
    return data;
  }
}
