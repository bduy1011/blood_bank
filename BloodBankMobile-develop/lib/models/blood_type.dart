// ignore_for_file: public_member_api_docs, sort_constructors_first

// ignore_for_file: constant_identifier_names

class BloodType {
  int? id;
  String? name;
  int? count;

  BloodType({this.id, this.name, this.count = 0});

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'key': id,
      'value': name,
    };
  }

  BloodType.fromJson(Map<String, dynamic> map) {
    id = map['key'];
    name = map['value'];
  }

  BloodType copyWith({
    int? id,
    String? name,
    int? count,
  }) {
    return BloodType(
      id: id ?? this.id,
      name: name ?? this.name,
      count: count ?? this.count,
    );
  }
}
