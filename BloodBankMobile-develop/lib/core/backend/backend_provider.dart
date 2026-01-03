import 'dart:developer';

import 'package:blood_donation/core/backend/header_interceptor.dart';
import 'package:blood_donation/core/backend/mock_interceptor.dart';
import 'package:blood_donation/core/backend/remote/backend_client.dart';
import 'package:blood_donation/core/storage/local_storage.dart';
import 'package:blood_donation/models/authentication.dart';
import 'package:blood_donation/models/blood_donation_event.dart';
import 'package:blood_donation/models/blood_type.dart';
import 'package:blood_donation/models/district.dart';
import 'package:blood_donation/models/general_response.dart';
import 'package:blood_donation/models/giaodich_response.dart';
import 'package:blood_donation/models/province.dart';
import 'package:blood_donation/models/question.dart';
import 'package:blood_donation/models/register_donation_blood_history_response.dart';
import 'package:blood_donation/models/register_donation_blood_response.dart';
import 'package:blood_donation/models/slide_model.dart';
import 'package:blood_donation/models/system_config.dart';
import 'package:blood_donation/models/ward.dart';
import 'package:blood_donation/utils/secure_token_service.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

import '../../app/app_util/app_center.dart';
import '../../models/authentication_response.dart';
import '../../models/blood_donor.dart';
import '../../models/cau_hinh_ton_kho_view.dart';
import '../../models/dm_don_vi_cap_mau_response.dart';
import '../../models/donation_blood_history_response.dart';
import '../../models/feedback_respose.dart';
import '../../models/giao_dich_template.dart';
import '../../models/news_response.dart';
import '../../models/register_reponse.dart';
import '../../utils/app_utils.dart';

class BackendProvider {
  static final BackendProvider _singleton = BackendProvider._internal();

  factory BackendProvider() {
    return _singleton;
  }

  BackendProvider._internal();

  LocalStorage get _localStorage => LocalStorage();

  late final BackendClient _client;
  late final String url;
  final isAuthenticatedNotifier = ValueNotifier<bool>(false);
  FirebaseAuth get _firebaseAuth => FirebaseAuth.instance;

  bool get isAuthenticated {
    if (!isLoginExpired) {
      return true;
    }
    return isAuthenticatedNotifier.value;
  }

  bool get isLoginExpired {
    if (_localStorage.authentication?.accessToken?.isNotEmpty != true) {
      return true;
    }
    final isExpired =
        JwtDecoder.isExpired(_localStorage.authentication!.accessToken ?? "");
    notifyAuthentication(isAuthenticated: !isExpired);
    return isExpired;
  }

  void notifyAuthentication({required bool isAuthenticated}) {
    if (!isAuthenticated) {
      GetIt.instance<AppCenter>().authentication?.accessToken = "";
    }
    isAuthenticatedNotifier.value = isAuthenticated;
  }

  void create({required String url}) {
    this.url = url;
    final dio = Dio();

    // Thêm MockInterceptor trước HeaderInterceptor để intercept trước
    dio.interceptors.add(MockInterceptor());
    dio.interceptors.add(HeaderInterceptor());

    _client = BackendClient(dio);

    notifyAuthentication(
        isAuthenticated: _localStorage
                    .authentication?.accessToken?.isNotEmpty ==
                true &&
            !JwtDecoder.isExpired(_localStorage.authentication!.accessToken!));
  }

  Future<String?> register(
      {required String fullName,
      required String username,
      required String password}) async {
    var macAddressMobile = AppUtils.instance.deviceId;
    final authentication = (await _client.register({
      "userCode": username,
      "name": fullName,
      "password": password,
      "isMaHoa": false,
      "deviceId": macAddressMobile,
    }));

    if (authentication.status == 200) {
      return null;
    } else {
      return authentication.message;
    }
  }

  Future<String?> registerByPhoneNumber(
      {required String fullName, required String phoneNumber}) async {
    var macAddressMobile = AppUtils.instance.deviceId;
    final authentication = (await _client.registerByPhone({
      "fullName": fullName,
      "phoneNumber": phoneNumber,
      "otpCode": "",
      "deviceId": macAddressMobile,
    }));

    if (authentication.status == 200 || authentication.status == 409) {
      return null;
    } else {
      return authentication.message;
    }
  }

  Future<Authentication?> checkOtp(
      {required String fullName,
      required String phoneNumber,
      required otpCode}) async {
    AuthenticationResponse? authenticationResponse;
    try {
      var macAddressMobile = AppUtils.instance.deviceId;
      authenticationResponse = (await _client.checkOtp({
        "fullName": fullName,
        "phoneNumber": phoneNumber,
        "otpCode": otpCode,
        "deviceId": macAddressMobile,
      }));
    } catch (e) {
      // TODO
    }
    if (authenticationResponse?.data != null) {
      if (authenticationResponse?.data!.accessToken?.isNotEmpty == true) {
        final auth = authenticationResponse!.data!;
        
        // Lưu authentication vào localStorage
        await _localStorage.saveAuthentication(authentication: auth);
        
        // Lưu tokens vào secure storage cho biometric login
        // Note: Nếu server trả về refreshToken, lấy từ authenticationResponse.data
        final tokenService = SecureTokenService();
        await tokenService.saveTokens(
          accessToken: auth.accessToken!,
          refreshToken: null, // TODO: Lấy từ server response nếu có
        );
        
        return auth;
      }
    } else {
      if (authenticationResponse?.message != null) {
        throw authenticationResponse?.message ?? "";
      }
    }
    return null;
  }

  Future<String?> reSendOtp(
      {required String fullName,
      required String phoneNumber,
      required otpCode}) async {
    var macAddressMobile = AppUtils.instance.deviceId;
    var authenticationResponse = (await _client.resendOtp({
      "fullName": fullName,
      "phoneNumber": phoneNumber,
      "otpCode": otpCode,
      "deviceId": macAddressMobile,
    }));

    if (authenticationResponse.status != 200) {
    } else {
      if (authenticationResponse.message != null) {
        return authenticationResponse.message ?? "";
      }
    }
    return null;
  }

  Future<String?> refreshToken() async {
    String? token;
    try {
      token = await _client.refreshToken();
    } catch (e, s) {
      // TODO
      log("refreshToken()", error: e, stackTrace: s);
    }
    return token;
  }

  Future<Authentication?> reLoadInformation() async {
    AuthenticationResponse? authenticationResponse;
    try {
      authenticationResponse = await _client.reLoadInformation();
    } catch (e, s) {
      // TODO
      log("reLoadInformation()", error: e, stackTrace: s);
    }
    if (authenticationResponse?.data != null) {
      ///
      authenticationResponse?.data?.accessToken =
          _localStorage.authentication?.accessToken;

      ///
      if (authenticationResponse?.data!.accessToken?.isNotEmpty == true) {
        await _localStorage.saveAuthentication(
            authentication: authenticationResponse!.data!);
        GetIt.instance<AppCenter>()
            .setAuthentication(authenticationResponse.data);
        return authenticationResponse.data;
      }
    } else {
      if (authenticationResponse?.message != null) {
        throw authenticationResponse?.message ?? "";
      }
    }
    return null;
  }

  Future<Authentication?> login(
      {required String username, required String password}) async {
    AuthenticationResponse? authenticationResponse;
    try {
      var macAddressMobile = AppUtils.instance.deviceId;
      authenticationResponse = (await _client.login({
        "userCode": username,
        "password": password,
        'deviceId': macAddressMobile,
      }));
    } catch (e, s) {
      // TODO
      log("login()", error: e, stackTrace: s);
    }
    if (authenticationResponse?.data != null) {
      if (authenticationResponse?.data!.accessToken?.isNotEmpty == true) {
        final auth = authenticationResponse!.data!;
        
        // Lưu authentication vào localStorage
        await _localStorage.saveAuthentication(authentication: auth);
        
        // Lưu tokens vào secure storage cho biometric login
        // Note: Nếu server trả về refreshToken, lấy từ authenticationResponse.data
        final tokenService = SecureTokenService();
        await tokenService.saveTokens(
          accessToken: auth.accessToken!,
          refreshToken: null, // TODO: Lấy từ server response nếu có refreshToken
        );
        
        return auth;
      }
    } else {
      if (authenticationResponse?.message != null) {
        throw authenticationResponse?.message ?? "";
      }
    }
    return null;
  }

  Future<Authentication> saveAuthentication(
      Authentication authentication) async {
    await _localStorage.saveAuthentication(authentication: authentication);
    return authentication;
  }

  Future<String?> getClientIdFromFirebase() async {
    User? user = FirebaseAuth.instance.currentUser;
    return user?.uid;
  }

  Future<Authentication?> loginWithGoogle() async {
    return null;

    // try {
    //   final GoogleSignInAccount googleUser = (await GoogleSignIn().signIn())!;
    //   final GoogleSignInAuthentication googleAuth =
    //       await googleUser.authentication;
    //   final credential = GoogleAuthProvider.credential(
    //     accessToken: googleAuth.accessToken,
    //     idToken: googleAuth.idToken,
    //   );
    //   UserCredential userCredential =
    //       await _firebaseAuth.signInWithCredential(credential);
    //   final macAddressMobile = await getMacAddressMobile();
    //   final clientId = userCredential.user!.uid;
    //   final authentication = (await _client.login({
    //     'clientId': clientId,
    //     'appToken': googleAuth.accessToken,
    //     'macAddress': macAddressMobile,
    //     'userCode': '',
    //     'password': ''
    //   }))
    //       .data;

    //   if (authentication?.accessToken?.isNotEmpty == true) {
    //     await _localStorage.saveAuthentication(
    //         authentication: (authentication!..name = googleUser.displayName));
    //     return authentication;
    //   }
    // } catch (e, s) {
    //   log("loginWithGoogle()", error: e, stackTrace: s);
    // }
    // return null;
  }

  Future<void> logout() async {
    // await _firebaseAuth.signOut();
    try {
      await _client.logout();
      await _localStorage.clearAuthentication();
    } catch (e) {
      // TODO
      await _localStorage.clearAuthentication();
    }
    // Xóa tokens khỏi secure storage
    try {
      final tokenService = SecureTokenService();
      await tokenService.clearTokens();
    } catch (e) {
      log("clearTokens() error: $e");
    }
    notifyAuthentication(isAuthenticated: false);
  }

  Future<GeneralResponseMap> deleteAccount({
    required String code,
  }) async {
    return _client.deleteAccount(
      code,
    );
  }

  Future<GeneralResponseMap> changePasswordByRegister({
    required Map<String, dynamic> body,
    required String token,
  }) async {
    return _client.changePasswordByRegister(
      body,
      token,
    );
  }

  Future<GeneralResponseMap> changePassword({
    required Map<String, dynamic> body,
  }) async {
    return _client.changePassword(
      body,
    );
  }

  Future<GeneralResponseMap<RegisterResponse>> updateAccount({
    required Map<String, dynamic> body,
    required String code,
    required bool isModIdCard,
  }) async {
    return _client.updateUser(
      body,
      code,
      isModIdCard,
    );
  }

  Future<GeneralResponseMap<BloodDonor>> getDMNguoiHienMauByIdCard({
    required String idCard,
    required String phoneNumber,
  }) async {
    try {
      return await _client.getDMNguoiHienMauByIdCard(
        idCard,
        phoneNumber,
      );
    } catch (e, s) {
      log("getDMNguoiHienMauByIdCard()", error: e, stackTrace: s);
      rethrow;
    }
  }

  Future<GeneralResponse<BloodType>> getBloodTypes() {
    try {
      return _client.getBloodTypes();
    } catch (e, s) {
      log("getBloodTypes()", error: e, stackTrace: s);
      rethrow;
    }
  }

  Future<GeneralResponse<DmDonViCapMauResponse>> getDmDonViCapMau() {
    try {
      return _client.getDmDonViCapMau();
    } catch (e, s) {
      log("getdmDonViCapMau()", error: e, stackTrace: s);
      rethrow;
    }
  }

  Future<GeneralResponseMap<GiaoDichTemplate>> getTemplateNhuongMau() {
    try {
      return _client.getTemplateNhuongMau("1");
    } catch (e, s) {
      log("getTemplateNhuongMau()", error: e, stackTrace: s);
      rethrow;
    }
  }

  Future<GeneralResponseMap<CauHinhTonKho>> initTonKhoTemplate(DateTime date) {
    try {
      return _client.initTonKhoTemplate(date.toIso8601String());
    } catch (e, s) {
      log("initTonKhoTemplate()", error: e, stackTrace: s);
      rethrow;
    }
  }

  Future<GeneralResponseMap<dynamic>> createTonKho(Map<String, dynamic> body) {
    try {
      return _client.createTonKho(body);
    } catch (e, s) {
      log("createTonKho()", error: e, stackTrace: s);
      rethrow;
    }
  }

  Future<GeneralResponseMap<dynamic>> updateTonKho(
      String id, Map<String, dynamic> body) {
    try {
      return _client.updateTonKho(body, id);
    } catch (e, s) {
      log("updateTonKho()", error: e, stackTrace: s);
      rethrow;
    }
  }

  Future<GeneralResponse<CauHinhTonKho>> getTonKho(Map<String, dynamic> body) {
    try {
      return _client.getTonKho(body);
    } catch (e, s) {
      log("getTonKho()", error: e, stackTrace: s);
      rethrow;
    }
  }

  Future<GeneralResponseMap<CauHinhTonKho>> getTonKhoById(
    String id,
  ) {
    try {
      return _client.getTonKhoById(id);
    } catch (e, s) {
      log("getTonKhoById()", error: e, stackTrace: s);
      rethrow;
    }
  }

  Future<GeneralResponseMap> createGiaoDich(Map<String, dynamic> body) {
    try {
      return _client.createGiaoDich(body);
    } catch (e, s) {
      log("createGiaoDich()", error: e, stackTrace: s);
      rethrow;
    }
  }

  Future<GeneralResponseMap> updateGiaoDich(
      String id, Map<String, dynamic> body) {
    try {
      return _client.updateGiaoDich(id, false, body);
    } catch (e, s) {
      log("updateGiaoDich()", error: e, stackTrace: s);
      rethrow;
    }
  }

  Future<GeneralResponseMap> cancelGiaoDich(
      String id, Map<String, dynamic> body) {
    try {
      return _client.cancelGiaoDich(id, false, body);
    } catch (e, s) {
      log("updateGiaoDich()", error: e, stackTrace: s);
      rethrow;
    }
  }

  Future<GeneralResponseMap> approveGiaoDich(
    String id,
    Map<String, dynamic> body,
  ) {
    try {
      return _client.approveGiaoDich(id, true, body);
    } catch (e, s) {
      log("approveGiaoDich()", error: e, stackTrace: s);
      rethrow;
    }
  }

  Future<GeneralResponseMap<GiaoDichTemplate>> getGiaoDichById(String id) {
    try {
      return _client.getGiaoDichById(id);
    } catch (e, s) {
      log("getGiaoDichById()", error: e, stackTrace: s);
      rethrow;
    }
  }

  Future<GeneralResponse<GiaodichResponse>> loadGiaoDich(
      Map<String, dynamic> body) {
    try {
      return _client.loadGiaoDich(body);
    } catch (e, s) {
      log("loadGiaoDich()", error: e, stackTrace: s);
      rethrow;
    }
  }

  Future<GeneralResponseMap> deleteGiaoDich(String id) {
    try {
      return _client.deleteGiaoDich(id);
    } catch (e, s) {
      log("loadGiaoDich()", error: e, stackTrace: s);
      rethrow;
    }
  }

  Future<String> getHTMLLetter(String id, String type) async {
    try {
      return await _client.getLetter(id, type);
    } catch (e, s) {
      log("getHTMLLetter()", error: e, stackTrace: s);
      return "";
    }
  }

  Future<RegisterDonationBloodResponse> registerDonateBlood(
      {required Map<String, dynamic> body}) {
    try {
      return _client.registerDonateBlood(body);
    } catch (e, s) {
      log("registerDonateBlood()", error: e, stackTrace: s);
      rethrow;
    }
  }

  Future<GeneralResponse<RegisterDonationBloodHistoryResponse>>
      registerDonateBloodHistory({required Map<String, dynamic> body}) {
    try {
      return _client.registerDonateBloodHistory(body);
    } catch (e, s) {
      log("registerDonateBloodHistory()", error: e, stackTrace: s);
      rethrow;
    }
  }

  Future<GeneralResponseMap<RegisterDonationBloodHistoryResponse>?>
      getRegisterDonateBloodById({required String id}) async {
    try {
      return await _client.getRegisterDonateBloodById(id);
    } catch (e, s) {
      log("getRegisterDonateBloodById()", error: e, stackTrace: s);
    }
    return null;
  }

  Future<GeneralResponse<DonationBloodHistoryResponse>> bloodDonationHistory(
      {required Map<String, dynamic> body}) {
    try {
      return _client.donateBloodHistory(body);
    } catch (e, s) {
      log("bloodDonationHistory()", error: e, stackTrace: s);
      rethrow;
    }
  }

  Future<GeneralResponseMap> requestForgotPassword(
      {required Map<String, dynamic> body}) async {
    try {
      return await _client.requestForgotPassword(body);
    } catch (e, s) {
      log("requestForgotPassword()", error: e, stackTrace: s);
      rethrow;
    }
  }

  Future<GeneralResponseMap<RegisterDonationBloodHistoryResponse>>
      cancelRegisterDonateBlood(
          {required Map<String, dynamic> body, required int id}) {
    try {
      return _client.cancelRegisterDonateBlood(body, "$id");
    } catch (e, s) {
      log("bloodDonationHistory()", error: e, stackTrace: s);
      rethrow;
    }
  }

  Future<GeneralResponse<BloodDonationEvent>> getBloodDonationFilter(
      {required Map<String, dynamic> body}) {
    try {
      return _client.getBloodDonationEvents(body);
    } catch (e, s) {
      // throw error when disconnect internet
      log("getBloodDonationEvents()", error: e, stackTrace: s);
      rethrow;
    }
  }

  Future<GeneralResponse<BloodDonationEvent>> getBloodDonationEventsByID(
      {required int id, required DateTime ngayGio}) {
    try {
      return _client.getBloodDonationEvents({
        "pageIndex": 1,
        "pageSize": 1000,
        "dotLayMauIds": [id],
        "tuNgay": ngayGio.subtract(const Duration(days: 1)).toIso8601String(),
        "denNgay": ngayGio.add(const Duration(days: 1)).toIso8601String(),
      });
    } catch (e, s) {
      // throw error when disconnect internet
      log("getBloodDonationEvents()", error: e, stackTrace: s);
      rethrow;
    }
  }

  Future<GeneralResponse<Ward>> getWards() {
    try {
      return _client.getWards();
    } catch (e, s) {
      log("getWards()", error: e, stackTrace: s);
      rethrow;
    }
  }

  Future<GeneralResponse<District>> getDistrict() {
    try {
      return _client.getDictricts();
    } catch (e, s) {
      log("getDistrict()", error: e, stackTrace: s);
      rethrow;
    }
  }

  Future<GeneralResponse<Province>> getProvince() {
    try {
      return _client.getProvinces();
    } catch (e, s) {
      log("getProvince()", error: e, stackTrace: s);
      rethrow;
    }
  }

  Future<GeneralResponseMap<dynamic>> createGopY(
      {required Map<String, dynamic> body}) {
    try {
      return _client.createGopY(body);
    } catch (e, s) {
      log("createGopY()", error: e, stackTrace: s);
      rethrow;
    }
  }

  Future<GeneralResponse<FeedbackResponse>> getGopY(
      {required Map<String, dynamic> body}) {
    try {
      return _client.getGopY(body);
    } catch (e, s) {
      log("getGopY()", error: e, stackTrace: s);
      rethrow;
    }
  }

  Future<GeneralResponse<SystemConfig>> getSystemConfig() {
    try {
      return _client.getSystemConfig({"pageIndex": 1, "pageSize": 10000});
    } catch (e, s) {
      log("getSystemConfig()", error: e, stackTrace: s);
      rethrow;
    }
  }

  Future<GeneralResponse<SlideModel>> getSystemSlides() async {
    try {
      return await _client.getSystemSlides({"pageIndex": 1, "pageSize": 10});
    } catch (e, s) {
      log("getSystemSlides()", error: e, stackTrace: s);
      rethrow;
    }
  }

  Future<GeneralResponse<NewsResponse>> getNews() async {
    try {
      return await _client.getNews({"pageIndex": 1, "pageSize": 100});
    } catch (e, s) {
      log("getNews()", error: e, stackTrace: s);
      rethrow;
    }
  }

  Future<GeneralResponseMap<NewsResponse>> getNewsById(String id) async {
    try {
      return await _client.getNewsById(id);
    } catch (e, s) {
      log("getNews()", error: e, stackTrace: s);
      rethrow;
    }
  }

  Future<List<Question>> getQuestions() async {
    try {
      return await _client.getQuestions();
    } catch (e, s) {
      log("getQuestions()", error: e, stackTrace: s);
      rethrow;
    }
  }

  // Future<void> updateProfile(
  //     {required String fullname,
  //     required String birthYear,
  //     required String idCard}) async {
  //   try {} catch (e, s) {
  //     log("updateProfile()", error: e, stackTrace: s);
  //   }
  // }

  // SmartCA Integration Methods
  /// Ký số bằng SmartCA qua Web API
  /// 
  /// [registrationId]: ID đăng ký hiến máu
  /// [dataToSign]: Dữ liệu cần ký (JSON string)
  /// [signatureType]: Loại chữ ký (donor, staff, doctor, nurse)
  /// 
  /// Returns: Map chứa chữ ký số (base64) và thông tin khác
  Future<Map<String, dynamic>?> signWithSmartCA({
    required String registrationId,
    required String dataToSign,
    required String signatureType,
  }) async {
    try {
      final response = await _client.signWithSmartCA({
        'registrationId': registrationId,
        'dataToSign': dataToSign,
        'signatureType': signatureType,
      });

      if (response.status == 200 && response.data != null) {
        return response.data as Map<String, dynamic>;
      } else {
        log("signWithSmartCA() failed: ${response.message}");
        return null;
      }
    } catch (e, s) {
      log("signWithSmartCA()", error: e, stackTrace: s);
      return null;
    }
  }

  /// Lấy danh sách chứng chỉ số của user hiện tại
  Future<List<Map<String, dynamic>>> getCertificates() async {
    try {
      final response = await _client.getCertificates();

      if (response.status == 200 && response.data != null) {
        final data = response.data as Map<String, dynamic>;
        if (data['certificates'] != null) {
          return List<Map<String, dynamic>>.from(data['certificates']);
        }
      }
      return [];
    } catch (e, s) {
      log("getCertificates()", error: e, stackTrace: s);
      return [];
    }
  }

  /// Upload chữ ký số đã ký vào đăng ký hiến máu
  /// 
  /// [registrationId]: ID đăng ký hiến máu
  /// [signatureType]: Loại chữ ký (donor, staff, doctor, nurse)
  /// [signatureBase64]: Chữ ký số (base64 encoded)
  /// [signatureInfo]: Thông tin bổ sung về chữ ký
  Future<bool> uploadSignature({
    required String registrationId,
    required String signatureType,
    required String signatureBase64,
    Map<String, dynamic>? signatureInfo,
  }) async {
    try {
      final response = await _client.uploadSignature(
        registrationId,
        {
          'signatureType': signatureType,
          'signature': signatureBase64,
          'signatureInfo': signatureInfo ?? {},
          'timestamp': DateTime.now().toIso8601String(),
        },
      );

      return response.status == 200;
    } catch (e, s) {
      log("uploadSignature()", error: e, stackTrace: s);
      return false;
    }
  }
}
