// ignore_for_file: public_member_api_docs, sort_constructors_first

class Question {
  int? id;
  String? content;
  int? attribute;
  bool? maleSkip;

  Question(
      {required this.id, required this.content, this.attribute, this.maleSkip});

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'content': content,
      'attribute': attribute,
      'maleSkip': maleSkip
    };
  }

  Question.fromJson(Map<String, dynamic> map) {
    id = map['id'];
    content = map['content'];
    attribute = map['attribute'];
    maleSkip = map['maleSkip'];
  }
}
