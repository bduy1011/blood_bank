import 'package:blood_donation/app/app_util/enum.dart';
import 'package:blood_donation/base/base_view/base_view.dart';
import 'package:blood_donation/core/localization/app_locale.dart';
import 'package:blood_donation/utils/extension/getx_extension.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app/app_page/controller/app_page_controller.dart';
import '../../../app/config/routes.dart';
import '../../../models/blood_donor.dart';
import '../../../utils/app_utils.dart';
import '../../../utils/phone_number_formater.dart';
import '../../home/controller/home_controller.dart';
import '../../scan_qr_code/scan_qr_code_screen.dart';

class ProfileController extends BaseModelStateful {
  final TextEditingController fullnameController = TextEditingController();
  final TextEditingController birthYearController = TextEditingController();
  final TextEditingController idCardController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController passwordNumberController =
      TextEditingController();

  // TODO: Remove this flag when API is ready
  static const bool bypassUpdateAPI = true; // Set to false when API is ready

  String? get note => getNote();

  @override
  void onBack() {
    // TODO: implement onBack
  }

  @override
  void onTapRightMenu() {
    // TODO: implement onTapRightMenu
  }

  @override
  Future<void> onInit() async {
    ///

    super.onInit();
    try {
      fullnameController.text = appCenter.authentication?.name ?? "";
      phoneNumberController.text = PhoneNumberFormatter.formatString(
          (appCenter.authentication?.phoneNumber ?? "").replaceAll(" ", ""));
      idCardController.text = appCenter.authentication?.cmnd ?? "";
    } catch (e) {
      // TODO
      // print(e);
    }
  }

  String? getNote() {
    if (appCenter.authentication?.dmNguoiHienMau != null) {
      return "Dữ liệu đã được cập nhật theo\r\nCCCD/Căn cước.\r\nNếu bạn muốn thay đổi vui lòng liên hệ\r\nTrung Tâm Truyền Máu Chợ Rẫy";
    } else if (appCenter.authentication?.appRole ==
        AppRole.DangKyMuaMau.value) {
      return "Đây là tài khoản đăng ký nhượng máu\r\nKhông thể chỉnh sửa thông tin.";
    }
    return null;
  }

  void updateProfile(BuildContext context) async {
    // backendProvider.logout();
    // print(appCenter.authentication?.toJson());
    FocusScope.of(context).requestFocus(FocusNode());
    var cccd = idCardController.text.trim().replaceAll(" ", "");
    var phoneNumber = phoneNumberController.text.trim().replaceAll(" ", "");

    ///
    if (!cccd.isNum || !(cccd.length == 12 || cccd.length == 9)) {
      AppUtils.instance.showToast(AppLocale.invalidIdCard.translate(Get.context!));
      return;
    }
    if (!phoneNumber.isNum || phoneNumber.length != 10) {
      AppUtils.instance.showToast(AppLocale.invalidPhone.translate(Get.context!));
      return;
    }

    ///
    try {
      // TODO: Remove bypass when API is ready
      if (bypassUpdateAPI) {
        showLoading();
        // Simulate API delay
        await Future.delayed(const Duration(milliseconds: 500));
        
        // Update local state without calling API
        if (appCenter.authentication != null) {
          appCenter.authentication!.phoneNumber = phoneNumber;
          appCenter.authentication!.name = fullnameController.text.trim();
          appCenter.authentication!.cmnd = cccd; // Ensure cmnd is set
          
          // Save to storage
          await backendProvider.saveAuthentication(appCenter.authentication!);
          
          // Reload from storage to ensure sync
          var savedAuth = appCenter.localStorage.authentication;
          if (savedAuth != null) {
            appCenter.setAuthentication(savedAuth);
          } else {
            // If not in storage, ensure current authentication is set
            appCenter.setAuthentication(appCenter.authentication);
          }
        }
        
        AppUtils.instance.showToast(AppLocale.updateAccountSuccess.translate(Get.context!));
        hideLoading();
        refresh();
        Get.findOrNull<HomeController>()?.onRefresh();
        
        // In bypass mode, if user came from another page (can pop), auto go back
        // This allows user to return to register donate blood page automatically
        var navigator = Get.key.currentState;
        if (navigator != null && navigator.canPop()) {
          // User came from another page (like register donate blood), go back
          Get.back();
        }
        // If can't pop, user stays on profile page
        return;
      }

      var body = {
        "userCode": appCenter.authentication?.userCode,
        "name": fullnameController.text.trim(),
        "phoneNumber": phoneNumber,
        "password": "",
        "idCardNr": cccd,
        "appRole": appCenter.authentication?.appRole ?? 30, // Default to User role if null
        "active": true,
      };
      showLoading();
      var isModIdCard = idCardController.text != appCenter.authentication?.cmnd;
      var response = await backendProvider.updateAccount(
        body: body,
        code: appCenter.authentication!.userCode!,
        isModIdCard: isModIdCard,
      );
      if (response.status == 200) {
        var dmNguoiHienMau =
            isModIdCard ? null : appCenter.authentication?.dmNguoiHienMau;
        if (response.data?.dmNguoiHienMau != null) {
          // dmNguoiHienMau = await getDMNguoiHienMau(
          //     idCardController.text, phoneNumberController.text);
          dmNguoiHienMau = response.data?.dmNguoiHienMau;
        }
        appCenter.authentication?.dmNguoiHienMau = dmNguoiHienMau;
        appCenter.authentication?.phoneNumber = phoneNumber;
        appCenter.authentication?.name = fullnameController.text;
        appCenter.authentication?.cmnd = cccd;
        appCenter.authentication?.accessToken = isModIdCard
            ? response.data?.accessToken
            : appCenter.authentication?.accessToken;
        appCenter.authentication?.ngayHienMauGanNhat =
            response.data?.ngayHienMauGanNhat;
        appCenter.authentication?.soLanHienMau = response.data?.soLanHienMau;
        appCenter.authentication?.duongTinhGanNhat =
            response.data?.duongTinhGanNhat;

        await backendProvider.saveAuthentication(appCenter.authentication!);

        AppUtils.instance.showToast(AppLocale.updateAccountSuccess.translate(Get.context!));
        hideLoading();
        refresh();
        Get.findOrNull<HomeController>()?.onRefresh();

        ///
        // Don't auto navigate to home - let user manually navigate
        // This prevents interrupting user flow when they come from register donate blood page
        // User can press back button to return to previous page

        return;
      }
      AppUtils.instance
          .showToast("${AppLocale.updateAccountFailed.translate(Get.context!)}\n${response.message ?? ""}");
    } catch (e, t) {
      print(e);
      print(t);
      // TODO
      AppUtils.instance.showToast(AppLocale.updateAccountFailed.translate(Get.context!));
    }
    hideLoading();
  }

  void backToHome() {
    try {
      Get.findOrNull<AppPageController>()?.onChangeHomeTab();
    } catch (e) {
      print(e);
    }

    ///
    Get.until((route) {
      var currentRoute = route.settings.name;
      debugPrint("Get.currentRoute --- $currentRoute");
      if (currentRoute == Routes.appPage) {
        return true;
      } else {
        return false;
      }
    });
  }

  Future<BloodDonor?> getDMNguoiHienMau(
      String idCard, String phoneNumber) async {
    ///
    try {
      var dataResponse = await backendProvider.getDMNguoiHienMauByIdCard(
          idCard: idCard, phoneNumber: phoneNumber);
      if (dataResponse.status == 200) {
        //
        return dataResponse.data;
      }
    } catch (e) {
      // TODO
    }
    return null;
  }

// 074202000733|281290246|Lê Nguyễn Anh Vũ|16112002|Nam|Tổ 6, Khu Phố 1,, Uyên Hưng, Tân Uyên, Bình Dương|13042021
  Future<bool> scanQRCode() async {
    var rs = await Get.to(
      () => ScanQrCodeScreen(
        title: AppLocale.scanQRCCCD.translate(Get.context!),
        onScan: (code) async {
          //
          var ls = code.split("|");
          idCardController.text = ls[0];
          fullnameController.text = ls[2];
          return true;
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
  }

  @override
  Future<void> onClose() async {
    ///
    fullnameController.dispose();
    birthYearController.dispose();
    idCardController.dispose();
    phoneNumberController.dispose();
    passwordNumberController.dispose();
    super.onClose();
  }
}
