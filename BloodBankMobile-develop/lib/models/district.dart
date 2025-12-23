// ignore_for_file: public_member_api_docs, sort_constructors_first

class District {
  final String nameDistrict;
  final String codeDistrict;
  final String codeProvince;

  District(
      {required this.nameDistrict,
      required this.codeDistrict,
      required this.codeProvince});

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'tenHuyen': nameDistrict,
      'maHuyen': codeDistrict,
      'maTinh': codeProvince,
    };
  }

  factory District.fromJson(Map<String, dynamic> map) {
    return District(
      nameDistrict: map['tenHuyen'] as String,
      codeDistrict: map['maHuyen'] as String,
      codeProvince: map['maTinh'] as String,
    );
  }
  @override
  String toString() {
    // TODO: implement toString
    return nameDistrict;
  }
}
