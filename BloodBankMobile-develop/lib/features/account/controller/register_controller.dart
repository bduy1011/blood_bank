import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../base/base_view/base_view.dart';
import '../../../utils/app_utils.dart';
import '../presentation/confirm_otp.dart';

class RegisterController extends BaseModelStateful {
  final TextEditingController phoneController = TextEditingController();
  //
  final TextEditingController fullNameRegisterController =
      TextEditingController();
  final TextEditingController usernameRegisterController =
      TextEditingController();
  final TextEditingController passwordRegisterController =
      TextEditingController();
  final TextEditingController confirmPasswordRegisterController =
      TextEditingController();
  SharedPreferences? prefs;
  @override
  Future<void> onClose() async {
    // Implement your hide dispose indicator logic here
    fullNameRegisterController.dispose();
    usernameRegisterController.dispose();
    confirmPasswordRegisterController.dispose();
    passwordRegisterController.dispose();

    phoneController.dispose();
    super.onClose();
  }

  @override
  Future<void> onInit() async {
    ///
    prefs = await SharedPreferences.getInstance();
    super.onInit();
  }

  Future<void> register(BuildContext context) async {
    ///
    try {
      FocusScope.of(context).requestFocus(FocusNode());
      var fullName = fullNameRegisterController.text.toUpperCase().trim();
      var userName = usernameRegisterController.text.trim().replaceAll(" ", "");
      var password = passwordRegisterController.text.trim();
      var confirmPassword = confirmPasswordRegisterController.text;

      if (fullName.trim().isEmpty) {
        AppUtils.instance.showToast("Chưa nhập họ tên");
        return;
      }
      if (fullName.trim().length < 6) {
        AppUtils.instance.showToast("Họ tên không hợp lệ");
        return;
      }
      if (userName.trim().isEmpty) {
        AppUtils.instance.showToast("Chưa nhập tên tài khoản");
        return;
      }
      if (!userName.isNum || !(userName.length == 12 || userName.length == 9)) {
        AppUtils.instance.showToast(
            "Tên đăng nhập phải là CCCD/Căn cước có độ dài 9 hoặc 12 ký tự!");
        return;
      }
      if (password.trim().isEmpty) {
        AppUtils.instance.showToast("Chưa nhập mật khẩu");
        return;
      }
      if (password.trim().length < 6) {
        AppUtils.instance.showToast("Mật khẩu phải từ 6 ký tự");
        return;
      }
      if (password.trim() != confirmPassword.trim()) {
        AppUtils.instance
            .showToast("Mật khẩu và xác nhận mật khẩu không giống nhau");
        return;
      }

      AppUtils.instance.showLoading();
      final isAuthenticated = await backendProvider.register(
          fullName: fullName, username: userName, password: password);
      if (isAuthenticated?.isEmpty == null) {
        // emit(state.copyWith(isAuthenticated: true));
        AppUtils.instance.hideLoading();
        await AppUtils.instance.showMessage(
          "Đăng ký tài khoản thành công!",
          context: Get.context,
        );
        await setUserName(userName);
        Get.back(result: true);
      } else {
        // emit(state.copyWith(isAuthenticated: false));
        AppUtils.instance
            .showToast("Đăng ký tài khoản thất bại!\n$isAuthenticated");
      }
    } catch (e, t) {
      log("register()", error: e, stackTrace: t);
      AppUtils.instance.showToast("Đăng ký tài khoản thất bại!");
    }
    AppUtils.instance.hideLoading();
  }

  Future<void> setUserName(String userName) async {
    ///
    try {
      await prefs?.setString("userName", userName);
    } catch (e) {
      // TODO
      print(e);
    }
  }

  Future<void> registerByPhoneNumber(BuildContext context) async {
    // Get.to(() => const ConfirmOtp());

    ///
    try {
      FocusScope.of(context).requestFocus(FocusNode());
      var fullName = fullNameRegisterController.text;
      var phoneNumber = phoneController.text.replaceAll(" ", "");

      if (fullName.trim().isEmpty) {
        AppUtils.instance.showToast("Chưa nhập họ tên tài khoản");
        return;
      }
      if (phoneNumber.trim().isEmpty) {
        AppUtils.instance.showToast("Chưa nhập số điện thoại");
        return;
      }
      if (phoneNumber.trim().length != 10) {
        AppUtils.instance.showToast("Số điện thoại không đúng");
        return;
      }

      AppUtils.instance.showLoading();
      final isAuthenticated = await backendProvider.registerByPhoneNumber(
          fullName: fullName, phoneNumber: phoneNumber);
      AppUtils.instance.hideLoading();
      if (isAuthenticated == null) {
        // emit(state.copyWith(isAuthenticated: true));
        Get.to(() => const ConfirmOtp());
      } else {
        // emit(state.copyWith(isAuthenticated: false));
        AppUtils.instance
            .showToast("Đăng ký tài khoản thất bại!\n$isAuthenticated");
      }
    } catch (e, t) {
      log("registerByPhoneNumber()", error: e, stackTrace: t);
      AppUtils.instance.showToast("Đăng ký tài khoản thất bại!");
    }
    AppUtils.instance.hideLoading();
  }
}
