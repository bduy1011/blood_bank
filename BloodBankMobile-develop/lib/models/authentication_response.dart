import 'package:blood_donation/models/authentication.dart';

class AuthenticationResponse {
  int? status;
  String? message;
  Authentication? data;
  AuthenticationResponse({
    this.status,
    this.message,
    this.data,
  });

  Map<String, dynamic> toJson() {
    final result = <String, dynamic>{};

    result.addAll({'status': status});
    result.addAll({'message': message});
    result.addAll({'data': data?.toJson()});

    return result;
  }

  AuthenticationResponse.fromJson(Map<String, dynamic> map) {
    status = map['status']?.toInt() ?? 0;
    message = map['message'] ?? '';
    if (map['data'] != null) {
      data = Authentication.fromJson(map['data']);
    }
  }
}
