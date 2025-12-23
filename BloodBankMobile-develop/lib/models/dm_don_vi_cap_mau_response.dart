class DmDonViCapMauResponse {
  String? maDonVi;
  String? tenDonVi;
  String? diaChi;
  String? dienThoai;
  bool? isBvNhi;
  bool? isDonViCapMau;
  bool? isDonViNhanMau;
  int? uuTien;
  bool? active;
  dynamic giaoDichs;

  DmDonViCapMauResponse(
      {this.maDonVi,
      this.tenDonVi,
      this.diaChi,
      this.dienThoai,
      this.isBvNhi,
      this.isDonViCapMau,
      this.isDonViNhanMau,
      this.uuTien,
      this.active,
      this.giaoDichs});

  DmDonViCapMauResponse.fromJson(Map<String, dynamic> json) {
    maDonVi = json['maDonVi'];
    tenDonVi = json['tenDonVi'];
    diaChi = json['diaChi'];
    dienThoai = json['dienThoai'];
    isBvNhi = json['isBvNhi'];
    isDonViCapMau = json['isDonViCapMau'];
    isDonViNhanMau = json['isDonViNhanMau'];
    uuTien = json['uuTien'];
    active = json['active'];
    giaoDichs = json['giaoDichs'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['maDonVi'] = maDonVi;
    data['tenDonVi'] = tenDonVi;
    data['diaChi'] = diaChi;
    data['dienThoai'] = dienThoai;
    data['isBvNhi'] = isBvNhi;
    data['isDonViCapMau'] = isDonViCapMau;
    data['isDonViNhanMau'] = isDonViNhanMau;
    data['uuTien'] = uuTien;
    data['active'] = active;
    data['giaoDichs'] = giaoDichs;
    return data;
  }

  @override
  String toString() {
    // TODO: implement toString
    return "$tenDonVi";
  }
}
