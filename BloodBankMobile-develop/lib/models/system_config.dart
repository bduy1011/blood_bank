// ignore_for_file: public_member_api_docs, sort_constructors_first

class SystemConfig {
  String? key;
  String? value;
  String? note;

  SystemConfig({required this.key, required this.value, required this.note});

  Map<String, dynamic> toJson() {
    return {
      'key': key,
      'value': value,
      'note': note,
    };
  }

  SystemConfig.fromJson(Map<String, dynamic> map) {
    key = map['key'];
    value = map['value'];
    note = map['note'];
  }
}
