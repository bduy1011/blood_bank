import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app/config/routes.dart';
import '../../../base/base_view/base_view.dart';
import '../../../utils/app_utils.dart';

class ChangePasswordController extends BaseModelStateful {
  final TextEditingController oldPasswordController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

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

    return super.onInit();
  }

  @override
  Future<void> onClose() async {
    // Implement your hide dispose indicator logic here

    confirmPasswordController.dispose();
    passwordController.dispose();
    oldPasswordController.dispose();

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

  Future<void> changePassword() async {
    var password = passwordController.text;
    var confirmPassword = confirmPasswordController.text;
    var oldPassword = oldPasswordController.text;

    if (oldPassword.trim().isEmpty) {
      AppUtils.instance.showMessage("Chưa nhập mật khẩu cũ");
      return;
    }
    if (password.trim().isEmpty) {
      AppUtils.instance.showMessage("Chưa nhập mật khẩu");
      return;
    }
    if (password.trim() != confirmPassword.trim()) {
      AppUtils.instance
          .showMessage("Mật khẩu và xác nhận mật khẩu không giống nhau");
      return;
    }

    ///
    try {
      var body = {
        "userCode": appCenter.authentication?.userCode,
        "oldPassword": oldPassword,
        "newPassword": password,
        "confirmedNewPassword": password,
      };
      showLoading();
      var response = await backendProvider.changePassword(
        body: body,
      );
      hideLoading();
      if (response.status == 200) {
        // await appCenter.backendProvider.saveAuthentication(authenticated!);
        // autoGotoHomePage();

        await AppUtils.instance.showMessage("Thay đổi mật khẩu thành công");
        Get.back();
        return;
      }
      AppUtils.instance
          .showMessage("Thay đổi mật khẩu thất bại\n${response.message}");
    } catch (e, t) {
      log("setPassword()", error: e, stackTrace: t);
      // TODO
      AppUtils.instance.showMessage("Thay đổi mật khẩu thất bại");
    }
    hideLoading();
  }
}
