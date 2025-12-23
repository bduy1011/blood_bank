// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:blood_donation/models/register_donation_blood.dart';

class RegisterDonationBloodResponse {
  int? status;
  String? message;
  RegisterDonationBlood? data;

  RegisterDonationBloodResponse(
      {required this.status, required this.message, required this.data});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'status': status,
      'message': message,
      'data': data?.toJson(),
    };
  }

  RegisterDonationBloodResponse.fromJson(Map<String, dynamic> map) {
    status = map['status'] as int?;
    message = map['message'] as String?;
    if (map['data'] != null) {
      data =
          RegisterDonationBlood.fromJson(map['data'] as Map<String, dynamic>);
    }
  }
}
