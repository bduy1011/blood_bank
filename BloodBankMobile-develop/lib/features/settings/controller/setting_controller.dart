import 'dart:developer';

import 'package:blood_donation/base/base_view/base_view.dart';
import 'package:blood_donation/core/localization/app_locale.dart';
import 'package:blood_donation/utils/app_utils.dart';
import 'package:get/get.dart';
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
    final context = Get.context!;
    var rs = await AppUtils.instance.showMessageConfirm(
      AppLocale.confirmDeleteAccount.translate(context),
      AppLocale.deleteAccountMessage.translate(context),
      context: context,
    );

    if (rs == true) {
      try {
        showLoading();
        var response = await backendProvider.deleteAccount(
          code: appCenter.authentication?.userCode ?? "",
        );
        if (response.status == 200) {
          backendProvider.logout();
          AppUtils.instance.showToast(AppLocale.deleteAccountSuccess.translate(context));
          hideLoading();
          return;
        }
        AppUtils.instance.showToast(AppLocale.deleteAccountFailed.translate(context));
      } catch (e, t) {
        log("deleteAccount()", error: e, stackTrace: t);
        AppUtils.instance.showToast(AppLocale.deleteAccountFailed.translate(context));
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

  void changeLanguage(AppLanguage language) {
    localization.translate(language.languageCode);
  }
}
