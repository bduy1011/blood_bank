import 'dart:developer';

import 'package:blood_donation/utils/extension/getx_extension.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app/config/routes.dart';
import '../../../base/base_view/base_view.dart';
import '../../../models/authentication.dart';
import '../../../utils/app_utils.dart';
import 'register_controller.dart';

class SetPasswordController extends BaseModelStateful {
  final TextEditingController passwordRegisterController =
      TextEditingController();
  final TextEditingController confirmPasswordRegisterController =
      TextEditingController();

  ///
  Authentication? authenticated;
  String get phoneNumber =>
      (Get.findOrNull<RegisterController>()?.phoneController.text ?? "")
          .replaceAll(" ", "");
  @override
  void onBack() {
    // TODO: implement onBack
  }

  @override
  void onTapRightMenu() {
    // TODO: implement onTapRightMenu
  }
  @override
  Future<void> onInit() {
    // TODO: implement onInit
    if (Get.arguments != null && Get.arguments["authentication"] != null) {
      authenticated = Get.arguments["authentication"];
    }
    return super.onInit();
  }

  @override
  Future<void> onClose() async {
    // Implement your hide dispose indicator logic here

    confirmPasswordRegisterController.dispose();
    passwordRegisterController.dispose();

    super.onClose();
  }

  void autoGotoHomePage() {
    if (appCenter.backendProvider.isAuthenticated) {
      try {
        Get.offAllNamed(Routes.appPage);
      } catch (e, s) {
        // TODO
        log("autoGotoHomePage()", error: e, stackTrace: s);
      }
    }
  }

  Future<void> setPassword() async {
    var password = passwordRegisterController.text;
    var confirmPassword = confirmPasswordRegisterController.text;

    if (password.trim().isEmpty) {
      AppUtils.instance.showToast("Chưa nhập mật khẩu");
      return;
    }
    if (password.trim() != confirmPassword.trim()) {
      AppUtils.instance
          .showToast("Mật khẩu và xác nhận mật khẩu không giống nhau");
      return;
    }

    ///
    try {
      var body = {
        "userCode": phoneNumber,
        "oldPassword": "123456",
        "newPassword": password,
        "confirmedNewPassword": password,
      };
      showLoading();
      var response = await backendProvider.changePasswordByRegister(
        body: body,
        token: "Bearer ${authenticated?.accessToken}",
      );
      hideLoading();
      if (response.status == 200) {
        await appCenter.backendProvider.saveAuthentication(authenticated!);
        autoGotoHomePage();
        AppUtils.instance.showToast("Cập nhật tài khoản thành công");
        return;
      }
      AppUtils.instance.showToast("Cập nhật tài khoản thất bại");
    } catch (e, t) {
      log("setPassword()", error: e, stackTrace: t);
      // TODO
      AppUtils.instance.showToast("Cập nhật tài khoản thất bại");
    }
    hideLoading();
  }
}
