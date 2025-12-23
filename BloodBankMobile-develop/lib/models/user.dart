// ignore_for_file: public_member_api_docs, sort_constructors_first

class User {
  final String hoTen;
  final String namSinh;
  final String cmnd;
  final String clientId;
  final String? email;
  final String? appToken;
  User({
    required this.hoTen,
    required this.namSinh,
    required this.cmnd,
    required this.clientId,
    this.email,
    this.appToken,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      hoTen: json['hoTen'] ?? '',
      namSinh: json['namSinh'] ?? '',
      cmnd: json['cmnd'] ?? '',
      clientId: json['clientId'] ?? '',
      appToken: json['appToken'] ?? '',
      email: json['email'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'hoTen': hoTen,
      'namSinh': namSinh,
      'cmnd': cmnd,
      'clientId': clientId,
      'appToken': appToken,
      'email': email,
    };
  }
}
