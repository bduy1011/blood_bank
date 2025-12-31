import 'dart:developer';

import 'package:blood_donation/core/localization/app_locale.dart';
import 'package:blood_donation/features/account/presentation/set_password%20copy.dart';
import 'package:blood_donation/utils/extension/getx_extension.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app/config/routes.dart';
import '../../../base/base_view/base_view.dart';
import '../../../utils/app_utils.dart';
import 'register_controller.dart';

class ConfirmOtpController extends BaseModelStateful {
  final TextEditingController otpController = TextEditingController();
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
  Future<void> onClose() async {
    // Implement your hide dispose indicator logic here

    try {
      otpController.dispose();
    } catch (e) {
      // TODO
    }
    super.onClose();
  }

  void autoGotoHomePage(BuildContext context) {
    if (appCenter.backendProvider.isAuthenticated) {
      try {
        Get.offAllNamed(Routes.appPage);
      } catch (e, s) {
        // TODO
        log("autoGotoHomePage()", error: e, stackTrace: s);
      }
    }
  }

  Future<void> onComplete(BuildContext context) async {
    // Implement your hide dispose indicator logic here
    // Get.to(() => const SetPassword());
    try {
      String fullName = Get.findOrNull<RegisterController>()
              ?.fullNameRegisterController
              .text ??
          "";

      String otpCode = otpController.text;
      FocusScope.of(context).requestFocus(FocusNode());
      AppUtils.instance.showLoading();
      final isAuthenticated = await backendProvider.checkOtp(
          fullName: fullName, phoneNumber: phoneNumber, otpCode: otpCode);
      AppUtils.instance.hideLoading();

      ///
      if (isAuthenticated != null) {
        Get.to(() => const SetPassword(), arguments: {
          "authentication": isAuthenticated,
        });
        // await _localStorage.saveAuthentication(
        //     authentication: authenticationResponse!.data!);
      } else {
        AppUtils.instance.showError("Mã OTP không chính xác");
      }
    } catch (e, t) {
      log("onComplete()", error: e, stackTrace: t);
      AppUtils.instance.showError("Mã OTP không chính xác $e");
    }
    AppUtils.instance.hideLoading();
  }

  Future<void> reSendOtp() async {
    ///
    ///
    String fullName =
        Get.findOrNull<RegisterController>()?.fullNameRegisterController.text ??
            "";
    AppUtils.instance.showLoading();
    final isAuthenticated = await backendProvider.reSendOtp(
        fullName: fullName, phoneNumber: phoneNumber, otpCode: "");
    if (isAuthenticated != null) {
      AppUtils.instance.showError(isAuthenticated);
    } else {
      AppUtils.instance.showToast(AppLocale.sendOtpSuccess.translate(Get.context!));
    }
    AppUtils.instance.hideLoading();
  }
}
