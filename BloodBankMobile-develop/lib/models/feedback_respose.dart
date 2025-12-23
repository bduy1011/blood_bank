class FeedbackResponse {
  int? id;
  DateTime? ngay;
  int? nguoiHienMauId;
  String? hoVaTen;
  String? loaiGopY;
  String? noiDung;
  String? email;
  String? soDT;
  bool? daXem;
  String? hinhAnh1;
  String? hinhAnh2;
  String? hinhAnh3;

  FeedbackResponse(
      {this.id,
      this.ngay,
      this.nguoiHienMauId,
      this.hoVaTen,
      this.loaiGopY,
      this.noiDung,
      this.email,
      this.soDT,
      this.daXem,
      this.hinhAnh1,
      this.hinhAnh2,
      this.hinhAnh3});

  FeedbackResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    ngay = json['ngay'] != null ? DateTime.parse(json['ngay']) : null;
    nguoiHienMauId = json['nguoiHienMauId'];
    hoVaTen = json['hoVaTen'];
    loaiGopY = json['loaiGopY'];
    noiDung = json['noiDung'];
    email = json['email'];
    soDT = json['soDT'];
    daXem = json['daXem'];
    hinhAnh1 = json['hinhAnh1'];
    hinhAnh2 = json['hinhAnh2'];
    hinhAnh3 = json['hinhAnh3'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['ngay'] = ngay?.toIso8601String();
    data['nguoiHienMauId'] = nguoiHienMauId;
    data['hoVaTen'] = hoVaTen;
    data['loaiGopY'] = loaiGopY;
    data['noiDung'] = noiDung;
    data['email'] = email;
    data['soDT'] = soDT;
    data['daXem'] = daXem;
    data['hinhAnh1'] = hinhAnh1;
    data['hinhAnh2'] = hinhAnh2;
    data['hinhAnh3'] = hinhAnh3;
    return data;
  }
}
