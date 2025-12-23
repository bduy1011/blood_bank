class DonationBloodHistoryResponse {
  String? ketQuaKTBTDescription;
  String? ketQuaHbsAgDescription;
  String? ketQuaHIVDescription;
  String? ketQuaHCVDescription;
  String? ketQuaGiangMaiDescription;
  String? ketQuaSotRetDescription;
  String? description;
  int? isHyperlink;
  int? id;
  int? nguoiHienMauId;
  String? maVachId;
  DateTime? ngayThu;
  String? maSanPham;
  String? tenSanPham;
  int? theTich;
  DateTime? ngaySanXuat;
  DateTime? ngayCapPhat;
  String? capPhatChoDonVi;
  String? ghiChuTuiMau;
  int? ketQuaKTBT;
  int? ketQuaHbsAg;
  int? ketQuaHIV;
  int? ketQuaHCV;
  int? ketQuaGiangMai;
  int? ketQuaSotRet;
  int? dotLayMauId;
  String? dmNguoiHienMau;
  String? dotLayMau;

  DonationBloodHistoryResponse(
      {this.ketQuaKTBTDescription,
      this.ketQuaHbsAgDescription,
      this.ketQuaHIVDescription,
      this.ketQuaHCVDescription,
      this.ketQuaGiangMaiDescription,
      this.ketQuaSotRetDescription,
      this.id,
      this.nguoiHienMauId,
      this.maVachId,
      this.ngayThu,
      this.maSanPham,
      this.tenSanPham,
      this.theTich,
      this.ngaySanXuat,
      this.ngayCapPhat,
      this.capPhatChoDonVi,
      this.ghiChuTuiMau,
      this.ketQuaKTBT,
      this.ketQuaHbsAg,
      this.ketQuaHIV,
      this.ketQuaHCV,
      this.ketQuaGiangMai,
      this.ketQuaSotRet,
      this.dotLayMauId,
      this.dmNguoiHienMau,
      this.dotLayMau});

  DonationBloodHistoryResponse.fromJson(Map<String, dynamic> json) {
    ketQuaKTBTDescription = json['ketQuaKTBTDescription'];
    ketQuaHbsAgDescription = json['ketQuaHbsAgDescription'];
    ketQuaHIVDescription = json['ketQuaHIVDescription'];
    ketQuaHCVDescription = json['ketQuaHCVDescription'];
    ketQuaGiangMaiDescription = json['ketQuaGiangMaiDescription'];
    ketQuaSotRetDescription = json['ketQuaSotRetDescription'];
    description = json['description'];
    isHyperlink = json['isHyperlink'];
    id = json['id'];
    nguoiHienMauId = json['nguoiHienMauId'];
    maVachId = json['maVachId'];
    ngayThu = json['ngayThu'] != null ? DateTime.parse(json['ngayThu']) : null;
    maSanPham = json['maSanPham'];
    tenSanPham = json['tenSanPham'];
    theTich = json['theTich'];
    ngaySanXuat = json['ngaySanXuat'] != null
        ? DateTime.parse(json['ngaySanXuat'])
        : null;
    ngayCapPhat = json['ngayCapPhat'] != null
        ? DateTime.parse(json['ngayCapPhat'])
        : null;
    capPhatChoDonVi = json['capPhatChoDonVi'];
    ghiChuTuiMau = json['ghiChuTuiMau'];
    ketQuaKTBT = json['ketQuaKTBT'];
    ketQuaHbsAg = json['ketQuaHbsAg'];
    ketQuaHIV = json['ketQuaHIV'];
    ketQuaHCV = json['ketQuaHCV'];
    ketQuaGiangMai = json['ketQuaGiangMai'];
    ketQuaSotRet = json['ketQuaSotRet'];
    dotLayMauId = json['dotLayMauId'];
    dmNguoiHienMau = json['dmNguoiHienMau'];
    dotLayMau = json['dotLayMau'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ketQuaKTBTDescription'] = ketQuaKTBTDescription;
    data['ketQuaHbsAgDescription'] = ketQuaHbsAgDescription;
    data['ketQuaHIVDescription'] = ketQuaHIVDescription;
    data['ketQuaHCVDescription'] = ketQuaHCVDescription;
    data['ketQuaGiangMaiDescription'] = ketQuaGiangMaiDescription;
    data['ketQuaSotRetDescription'] = ketQuaSotRetDescription;
    data['id'] = id;
    data['nguoiHienMauId'] = nguoiHienMauId;
    data['maVachId'] = maVachId;
    data['ngayThu'] = ngayThu;
    data['maSanPham'] = maSanPham;
    data['tenSanPham'] = tenSanPham;
    data['theTich'] = theTich;
    data['ngaySanXuat'] = ngaySanXuat;
    data['ngayCapPhat'] = ngayCapPhat;
    data['capPhatChoDonVi'] = capPhatChoDonVi;
    data['ghiChuTuiMau'] = ghiChuTuiMau;
    data['ketQuaKTBT'] = ketQuaKTBT;
    data['ketQuaHbsAg'] = ketQuaHbsAg;
    data['ketQuaHIV'] = ketQuaHIV;
    data['ketQuaHCV'] = ketQuaHCV;
    data['ketQuaGiangMai'] = ketQuaGiangMai;
    data['ketQuaSotRet'] = ketQuaSotRet;
    data['dotLayMauId'] = dotLayMauId;
    data['dmNguoiHienMau'] = dmNguoiHienMau;
    data['dotLayMau'] = dotLayMau;
    data['description'] = description;
    data['isHyperlink'] = isHyperlink;
    return data;
  }
}
