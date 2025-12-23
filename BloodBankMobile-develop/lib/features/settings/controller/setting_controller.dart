import 'dart:developer';

import 'package:blood_donation/base/base_view/base_view.dart';
import 'package:blood_donation/utils/app_utils.dart';
import 'package:in_app_review/in_app_review.dart';

class SettingController extends BaseModelStateful {
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
  }

  @override
  Future<void> onClose() async {
    ///
    super.onClose();
  }

  void logout() {
    backendProvider.logout();
  }

  void deleteAccount() async {
    // backendProvider.logout();
    // print(appCenter.authentication?.toJson());

    ///
    // String? password;
    var rs = await AppUtils.instance.showMessageConfirm(
      "Xác nhận xóa tài khoản",
      "Tài khoản của bạn sẽ bị xóa\nvĩnh viễn",
    );

    if (rs == true) {
// ///
      try {
        showLoading();
        var response = await backendProvider.deleteAccount(
          code: appCenter.authentication?.userCode ?? "",
        );
        if (response.status == 200) {
          backendProvider.logout();
          AppUtils.instance.showToast("Xóa tài khoản thành công");
          hideLoading();
          return;
        }
        AppUtils.instance.showToast("Xóa tài khoản thất bại");
      } catch (e, t) {
        log("deleteAccount()", error: e, stackTrace: t);
        // TODO
        AppUtils.instance.showToast("Xóa tài khoản thất bại");
      }
      hideLoading();
    }
  }

  Future<void> reviewAPP() async {
    try {
      final InAppReview inAppReview = InAppReview.instance;

      if (await inAppReview.isAvailable()) {
        inAppReview.requestReview();
      }
    } catch (e) {
      // TODO
      print(e);
    }
  }
}
