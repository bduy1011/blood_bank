class NewsResponse {
  int? tinTucId;
  String? tieuDe;
  String? noiDung1;
  String? noiDung2;
  int? loai;
  int? module;
  String? thumbnailLink;
  String? createdBy;
  DateTime? createdOn;
  bool? active;

  NewsResponse(
      {this.tinTucId,
      this.tieuDe,
      this.noiDung1,
      this.noiDung2,
      this.loai,
      this.module,
      this.thumbnailLink,
      this.createdBy,
      this.createdOn,
      this.active});

  NewsResponse.fromJson(Map<String, dynamic> json) {
    tinTucId = json['tinTucId'];
    tieuDe = json['tieuDe'];
    noiDung1 = json['noiDung1'];
    noiDung2 = json['noiDung2'];
    loai = json['loai'];
    module = json['module'];
    thumbnailLink = json['thumbnailLink'];
    createdBy = json['createdBy'];
    createdOn =
        json['createdOn'] != null ? DateTime.parse(json['createdOn']) : null;
    active = json['active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['tinTucId'] = tinTucId;
    data['tieuDe'] = tieuDe;
    data['noiDung1'] = noiDung1;
    data['noiDung2'] = noiDung2;
    data['loai'] = loai;
    data['module'] = module;
    data['thumbnailLink'] = thumbnailLink;
    data['createdBy'] = createdBy;
    data['createdOn'] = createdOn?.toIso8601String();
    data['active'] = active;
    return data;
  }
}
