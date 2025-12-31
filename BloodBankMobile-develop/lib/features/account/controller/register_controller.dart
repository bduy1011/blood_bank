import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dart:typed_data';

import '../../../base/base_view/base_view.dart';
import '../../../core/localization/app_locale.dart';
import '../../../models/citizen.dart';
import '../../../utils/app_utils.dart';
import '../../scan_qr_code/scan_qr_code_screen.dart';
import '../presentation/confirm_otp.dart';
import '../presentation/signature_pad_page.dart';

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
  
  // Lưu chữ ký đã ký (dạng bytes)
  Uint8List? signatureBytes;
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
        AppUtils.instance.showToast(AppLocale.notEnterFullName.translate(context));
        return;
      }
      if (fullName.trim().length < 6) {
        AppUtils.instance.showToast(AppLocale.invalidFullName.translate(context));
        return;
      }
      if (userName.trim().isEmpty) {
        AppUtils.instance.showToast(AppLocale.notEnterUsername.translate(context));
        return;
      }
      if (!userName.isNum || !(userName.length == 12 || userName.length == 9)) {
        AppUtils.instance.showToast(AppLocale.invalidUsername.translate(context));
        return;
      }
      if (password.trim().isEmpty) {
        AppUtils.instance.showToast(AppLocale.notEnterPassword.translate(context));
        return;
      }
      if (password.trim().length < 6) {
        AppUtils.instance.showToast(AppLocale.passwordMinLength.translate(context));
        return;
      }
      if (password.trim() != confirmPassword.trim()) {
        AppUtils.instance
            .showToast(AppLocale.passwordNotMatch.translate(context));
        return;
      }

      AppUtils.instance.showLoading();
      final isAuthenticated = await backendProvider.register(
          fullName: fullName, username: userName, password: password);
      if (isAuthenticated?.isEmpty == null) {
        // emit(state.copyWith(isAuthenticated: true));
        AppUtils.instance.hideLoading();
        await AppUtils.instance.showMessage(
          AppLocale.registerAccountSuccess.translate(context),
          context: context,
        );
        await setUserName(userName);
        Get.back(result: true);
      } else {
        // emit(state.copyWith(isAuthenticated: false));
        AppUtils.instance
            .showToast("${AppLocale.registerAccountFailed.translate(context)}\n$isAuthenticated");
      }
    } catch (e, t) {
      log("register()", error: e, stackTrace: t);
      AppUtils.instance.showToast(AppLocale.registerAccountFailed.translate(context));
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
        AppUtils.instance.showToast(AppLocale.notEnterFullName.translate(context));
        return;
      }
      if (phoneNumber.trim().isEmpty) {
        AppUtils.instance.showToast(AppLocale.notEnterPhone.translate(context));
        return;
      }
      if (phoneNumber.trim().length != 10) {
        AppUtils.instance.showToast(AppLocale.invalidPhone.translate(context));
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
            .showToast("${AppLocale.registerAccountFailed.translate(context)}\n$isAuthenticated");
      }
    } catch (e, t) {
      log("registerByPhoneNumber()", error: e, stackTrace: t);
      AppUtils.instance.showToast(AppLocale.registerAccountFailed.translate(context));
    }
    AppUtils.instance.hideLoading();
  }

  // Quét QR code từ căn cước công dân để đăng ký
  // Sử dụng giao diện quét QR cũ (ScanQrCodeScreen) với overlay đẹp
  // Parse và map vào model Citizen, validate và prefill form
  Future<bool> scanQRCodeForRegistration(BuildContext context) async {
    try {
      var rs = await Get.to(
        () => ScanQrCodeScreen(
          title: AppLocale.scanQRCCCD.translate(context),
          onScan: (code) async {
            try {
              // Parse QR code thành Citizen model
              final citizen = Citizen.fromQRCode(code);

              // Validate thông tin
              if (!citizen.isValid()) {
                final errors = citizen.getValidationErrors();
                AppUtils.instance.showMessage(
                  errors.join("\n"),
                  context: Get.context,
                );
                return false;
              }

              // Prefill form với thông tin từ QR code
              // Cho phép chỉnh sửa sau khi prefill
              usernameRegisterController.text = citizen.idCard;
              fullNameRegisterController.text = citizen.fullName;

              // Hiển thị thông tin đã lấy được
              final buffer = StringBuffer();
              buffer.writeln("Đã lấy thông tin từ QR code:");
              buffer.writeln("");
              buffer.writeln("• Số CCCD: ${citizen.idCard}");
              buffer.writeln("• Họ tên: ${citizen.fullName}");
              
              if (citizen.dateOfBirth != null && citizen.isValidDateOfBirth()) {
                buffer.writeln("• Ngày sinh: ${citizen.getFormattedDateOfBirth()}");
              }
              
              if (citizen.gender != null && citizen.gender!.isNotEmpty) {
                buffer.writeln("• Giới tính: ${citizen.gender}");
              }
              
              if (citizen.address != null && citizen.address!.isNotEmpty) {
                buffer.writeln("• Địa chỉ: ${citizen.address}");
              }
              
              if (citizen.issueDate != null && citizen.issueDate!.isNotEmpty) {
                buffer.writeln("• Ngày cấp: ${citizen.getFormattedIssueDate()}");
              }
              
              buffer.writeln("");
              buffer.writeln("Bạn có thể chỉnh sửa thông tin trên form nếu cần.");

              AppUtils.instance.showMessage(
                buffer.toString(),
                context: Get.context,
                isAlignmentLeft: true,
              );

              AppUtils.instance.showToast(AppLocale.qrCodeReadSuccess.translate(context));
              return true;
            } catch (e) {
              log("parseQRCode()", error: e);
              AppUtils.instance.showToast(AppLocale.qrCodeReadError.translate(context));
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
      log("scanQRCodeForRegistration()", error: e, stackTrace: t);
      AppUtils.instance.showToast(AppLocale.qrScanError.translate(context));
      return false;
    }
  }

  // Chữ ký số - mở màn hình ký tay
  Future<void> mockDigitalSignature(BuildContext context) async {
    try {
      FocusScope.of(context).requestFocus(FocusNode());
      
      // Kiểm tra thông tin đã nhập
      final fullName = fullNameRegisterController.text.trim();
      final cccd = usernameRegisterController.text.trim();
      
      if (fullName.isEmpty) {
        AppUtils.instance.showToast(AppLocale.pleaseEnterFullNameBeforeSign.translate(context));
        return;
      }
      if (cccd.isEmpty) {
        AppUtils.instance.showToast(AppLocale.pleaseEnterIdCardBeforeSign.translate(context));
        return;
      }

      // Mở màn hình ký tay
      final signatureResult = await Get.to(
        () => const SignaturePadPage(),
        fullscreenDialog: true,
      );

      if (signatureResult != null && signatureResult is Uint8List) {
        // Lưu chữ ký
        signatureBytes = signatureResult;
        
        final timeNow = DateTime.now().toString().substring(0, 19);
        final message = "Chữ ký đã được lưu thành công!\n\nThông tin:\n- Họ tên: $fullName\n- CCCD: $cccd\n- Thời gian: $timeNow";
        
        final dialogContext = context.mounted ? context : Get.context;
        if (dialogContext == null) {
          AppUtils.instance.showToast(AppLocale.signatureSavedSuccess.translate(context));
          return;
        }
        
        var confirmed = await AppUtils.instance.showMessageConfirmCancel(
          "Chữ ký số",
          message,
          context: dialogContext,
        );
        
        final toastContext = Get.context!;
        if (confirmed) {
          AppUtils.instance.showToast(AppLocale.signatureConfirmed.translate(toastContext));
        } else {
          AppUtils.instance.showToast(AppLocale.signatureCancelled.translate(toastContext));
        }
      } else {
        AppUtils.instance.showToast(AppLocale.signatureNotComplete.translate(context));
      }
    } catch (e, t) {
      log("mockDigitalSignature()", error: e, stackTrace: t);
      AppUtils.instance.showToast("${AppLocale.signatureError.translate(context)} ${e.toString()}");
    }
  }
}
