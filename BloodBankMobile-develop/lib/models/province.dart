// ignore_for_file: public_member_api_docs, sort_constructors_first

class Province {
  final String codeProvince;
  final String nameProvince;
  final String? codeCountry;

  Province(
      {required this.codeProvince,
      required this.nameProvince,
      this.codeCountry});

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'maTinh': codeProvince,
      'tenTinh': nameProvince,
      'maQuocGia': codeCountry,
    };
  }

  factory Province.fromJson(Map<String, dynamic> map) {
    return Province(
      codeProvince: map['maTinh'] as String,
      nameProvince: map['tenTinh'] as String,
      codeCountry: map['maQuocGia'] != null ? map['maQuocGia'] as String : null,
    );
  }
  @override
  String toString() {
    // TODO: implement toString
    return nameProvince;
  }
}
