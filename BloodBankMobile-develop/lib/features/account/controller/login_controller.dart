import 'dart:developer';

import 'package:blood_donation/base/base_view/base_view.dart';
import 'package:blood_donation/models/authentication.dart';
import 'package:blood_donation/utils/app_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../app/config/routes.dart';
import '../../../models/citizen.dart';
import '../../scan_qr_code/scan_qr_code_screen.dart';

class LoginController extends BaseModelStateful {
  ///
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  SharedPreferences? prefs;

  ///

  @override
  Future<void> onClose() async {
    // Implement your hide dispose indicator

    ///
    usernameController.dispose();
    passwordController.dispose();

    super.onClose();
  }

  @override
  Future<void> onInit() async {
    prefs = await SharedPreferences.getInstance();
    initUserName();

    ///
    super.onInit();
  }

  Future<void> initUserName() async {
    ///
    var userName = prefs?.getString("userName");
    if (userName?.isNotEmpty == true) {
      usernameController.text = userName ?? "";
    }
  }

  Future<void> setUserName() async {
    ///
    prefs?.setString("userName", usernameController.text);
  }

  @override
  Future<void> onReady() {
    // TODO: implement onReady
    // test();
    return super.onReady();
  }

  // test() async {
  //   Future.delayed(const Duration(seconds: 2), () {
  //     ///
  //     var json = jsonDecode(
  //         '''{ "id": 22, "ngay": "2024-11-24T07:30:00.000", "nguoiHienMauId": 340227, "hoVaTen": "TRẦN VĂN NỔI", "ngaySinh": null, "namSinh": null, "cmnd": "077080006127", "gioiTinh": null, "maXa": null, "tenXa": null, "maHuyen": "238", "tenHuyen": "Châu Đức", "maTinh": "77", "tenTinh": "BR Vũng Tàu", "diaChiLienLac": null, "soDT": "0367645612", "tinhTrang": 1, "maDonViCapMau": null, "traLoiCauHoiId": 68, "dotLayMauId": 27661, "surveyQuestions": [ { "id": 1, "surveyQuestionId": null, "yes": null, "no": true, "onDate": "2024-11-24T17:12:37.848037", "notes": null }, { "id": 2, "surveyQuestionId": null, "yes": null, "no": true, "onDate": "2024-11-24T17:12:37.849346", "notes": null }, { "id": 9, "surveyQuestionId": null, "yes": null, "no": true, "onDate": "2024-11-24T17:12:37.849360", "notes": null }, { "id": 3, "surveyQuestionId": null, "yes": null, "no": true, "onDate": "2024-11-24T17:12:37.849365", "notes": null }, { "id": 10, "surveyQuestionId": null, "yes": null, "no": true, "onDate": "2024-11-24T17:12:37.849366", "notes": null }, { "id": 4, "surveyQuestionId": null, "yes": null, "no": true, "onDate": "2024-11-24T17:12:37.849367", "notes": null }, { "id": 11, "surveyQuestionId": null, "yes": null, "no": true, "onDate": "2024-11-24T17:12:37.849368", "notes": null }, { "id": 12, "surveyQuestionId": null, "yes": null, "no": true, "onDate": "2024-11-24T17:12:37.849369", "notes": null }, { "id": 5, "surveyQuestionId": null, "yes": null, "no": true, "onDate": "2024-11-24T17:12:37.849370", "notes": null }, { "id": 13, "surveyQuestionId": null, "yes": null, "no": true, "onDate": "2024-11-24T17:12:37.849371", "notes": null }, { "id": 6, "surveyQuestionId": null, "yes": null, "no": true, "onDate": "2024-11-24T17:12:37.849372", "notes": null }, { "id": 14, "surveyQuestionId": null, "yes": null, "no": true, "onDate": "2024-11-24T17:12:37.849373", "notes": null }, { "id": 15, "surveyQuestionId": null, "yes": null, "no": true, "onDate": "2024-11-24T17:12:37.849374", "notes": null }, { "id": 7, "surveyQuestionId": null, "yes": null, "no": true, "onDate": "2024-11-24T17:12:37.849375", "notes": null }, { "id": 8, "surveyQuestionId": null, "yes": null, "no": true, "onDate": "2024-11-24T17:12:37.849375", "notes": null }, { "id": 16, "surveyQuestionId": null, "yes": null, "no": true, "onDate": "2024-11-24T17:12:37.849376", "notes": null } ] }''');
  //     var item = RegisterDonationBloodHistoryResponse.fromJson(json);
  //     var data = jsonEncode(item.toMapQrCode());
  //     log(data);
  //     AppUtils.instance.showQrCodeImage(data);
  //   });
  // }

  void autoGotoHomePage(BuildContext context) {
    // BYPASS: Luôn chuyển vào màn hình chính
    try {
      Get.offAllNamed(Routes.appPage);
    } catch (e, s) {
      // TODO
      log("autoGotoHomePage()", error: e, stackTrace: s);
    }
    // Code gốc:
    // if (appCenter.backendProvider.isAuthenticated) {
    //   try {
    //     Get.offAllNamed(Routes.appPage);
    //   } catch (e, s) {
    //     log("autoGotoHomePage()", error: e, stackTrace: s);
    //   }
    // }
  }

  ///00000000-5783-1f4a-0000-00004578bd37
  Future<void> login(
      {required String username,
      required String password,
      required BuildContext context}) async {
    try {
      FocusScope.of(context).requestFocus(FocusNode());
      
      // BYPASS LOGIN - Tự động vào màn hình chính khi nhấn nút đăng nhập
      AppUtils.instance.showLoading();
      
      // Tạo mock authentication để bypass
      final mockAuth = Authentication(
        accessToken: "mock_token_bypass_login_${DateTime.now().millisecondsSinceEpoch}",
        userCode: username.trim().isNotEmpty ? username : "test_user",
        name: username.trim().isNotEmpty ? username : "Test User",
        appRole: 30, // UserRole.user.value
        status: 1,
      );
      
      // Lưu authentication vào localStorage
      await appCenter.localStorage.saveAuthentication(authentication: mockAuth);
      appCenter.setAuthentication(mockAuth);
      backendProvider.notifyAuthentication(isAuthenticated: true);
      
      // Lưu username
      setUserName();
      
      // Chuyển vào màn hình chính
      await Future.delayed(const Duration(milliseconds: 500)); // Delay nhỏ để UX mượt hơn
      autoGotoHomePage(context);
      
      // Code gốc đã được comment để bypass
      // if (username.trim().isEmpty) {
      //   AppUtils.instance.showToast("Chưa nhập tên tài khoản hoặc CCCD/Căn cước");
      //   return;
      // }
      // if (password.trim().isEmpty) {
      //   AppUtils.instance.showToast("Chưa nhập mật khẩu");
      //   return;
      // }
      // final isAuthenticated =
      //     await backendProvider.login(username: username, password: password);
      // if (isAuthenticated != null) {
      //   setUserName();
      //   autoGotoHomePage(context);
      // } else {
      //   AppUtils.instance.showError(AppLocale.loginFail.translate(context));
      // }
    } catch (e, t) {
      log("login()", error: e, stackTrace: t);
      AppUtils.instance.showError("$e");
    }
    AppUtils.instance.hideLoading();
  }

  // Quét QR code từ căn cước công dân để đăng nhập
  // Sử dụng giao diện quét QR cũ (ScanQrCodeScreen) với overlay đẹp
  // Parse và map vào model Citizen, validate và prefill username
  Future<bool> scanQRCodeForLogin(BuildContext context) async {
    try {
      var rs = await Get.to(
        () => ScanQrCodeScreen(
          title: "Quét mã QR CCCD/Căn cước",
          onScan: (code) async {
            try {
              // Parse QR code thành Citizen model
              final citizen = Citizen.fromQRCode(code);

              // Validate CCCD
              if (!citizen.isValidIdCard()) {
                AppUtils.instance.showMessage(
                  "Số CCCD/Căn cước không hợp lệ (phải là 9 hoặc 12 ký tự số)",
                  context: Get.context,
                );
                return false;
              }

              // Prefill username với số CCCD
              usernameController.text = citizen.idCard;

              AppUtils.instance.showToast("Đã lấy số CCCD từ QR code thành công!");
              return true;
            } catch (e) {
              log("parseQRCode()", error: e);
              AppUtils.instance.showToast("Lỗi khi đọc thông tin từ QR code!");
              return false;
            }
          },
        ),
      );
      if (rs == "ok") {
        return true;
      }
      if (rs == "cancel") {
        return false;
      }
      return false;
    } catch (e, t) {
      log("scanQRCodeForLogin()", error: e, stackTrace: t);
      AppUtils.instance.showToast("Lỗi khi quét QR code!");
      return false;
    }
  }
}
