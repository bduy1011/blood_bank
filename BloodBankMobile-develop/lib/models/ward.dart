// ignore_for_file: public_member_api_docs, sort_constructors_first

class Ward {
  final String nameWards;
  final String codeWards;
  final String codeDistrict;

  Ward(
      {required this.nameWards,
      required this.codeWards,
      required this.codeDistrict});

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'tenXa': nameWards,
      'maXa': codeWards,
      'maHuyen': codeDistrict,
    };
  }

  factory Ward.fromJson(Map<String, dynamic> map) {
    return Ward(
      nameWards: map['tenXa'] as String,
      codeWards: map['maXa'] as String,
      codeDistrict: map['maHuyen'] as String,
    );
  }
  @override
  String toString() {
    // TODO: implement toString
    return nameWards;
  }
}
