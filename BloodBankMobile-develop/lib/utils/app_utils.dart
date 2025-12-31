import 'dart:io';

import 'package:android_id/android_id.dart';
import 'package:blood_donation/app/app_util/app_center.dart';
import 'package:blood_donation/core/localization/app_locale.dart';
import 'package:blood_donation/utils/extension/string_ext.dart';
import 'package:blood_donation/utils/firebase_manager.dart';
import 'package:blood_donation/utils/widget/alert_update_app.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:toastification/toastification.dart';
import 'package:uuid/uuid.dart';

import '../models/app_version.dart';
import './extension/context_ext.dart';
import 'agoris_utils.dart';
import 'widget/dialog_input_widget.dart';
import 'widget/dialog_widget.dart';
import 'widget/loading_widget.dart';
import 'widget/view_qr_data_image.dart';

class AppUtils {
  static final AppUtils instance = AppUtils._internal();
  AppUtils._internal();

  final loadingController = AppLoadingController();
  String appVersion = "";
  String deviceId = "";

  showLoading({bool hasBlurBackground = true, String? message}) {
    loadingController.showLoading(blurBG: hasBlurBackground, msg: message);
  }

  hideLoading({bool hasBlurBackground = true}) {
    loadingController.hideLoading();
  }

  Future<void> showMessage(String message,
      {BuildContext? context, bool? isAlignmentLeft}) {
    return showDialog(
      context: context ?? Get.context!,
      builder: (context) {
        return AppDialog(message: message, isAlignmentLeft: isAlignmentLeft);
      },
    );
  }

  Future<bool> showMessageConfirmInput(String title, String message,
      Function(String text) onChange, String labelText,
      {BuildContext? context, bool obscureText = false}) async {
    var isConfirm = false;
    await showDialog(
      context: context ?? Get.context!,
      barrierDismissible: true,
      builder: (context) {
        return AppDialogInput(
          message: message,
          title: title,
          buttonTitle: AppLocale.confirm.translate(context ?? Get.context!),
          onTap: () {
            isConfirm = true;
            Get.back();
          },
          labelText: labelText,
          onChange: onChange,
          obscureText: obscureText,
        );
      },
    );
    return isConfirm;
  }

  Future<bool> showMessageConfirm(String title, String message,
      {BuildContext? context}) async {
    var isConfirm = false;
    await showDialog(
      context: context ?? Get.context!,
      barrierDismissible: true,
      builder: (context) {
        return AppDialog(
            message: message,
            title: title,
            buttonTitle: AppLocale.confirm.translate(context ?? Get.context!),
            onTap: () {
              isConfirm = true;
              Get.back();
            });
      },
    );
    return isConfirm;
  }

  Future<bool> showMessageConfirmCancel(String title, String message,
      {BuildContext? context}) async {
    var isConfirm = false;
    await showDialog(
      context: context ?? Get.context!,
      barrierDismissible: true,
      builder: (context) {
        return AppDialog(
          message: message,
          title: title,
          buttonTitle: AppLocale.confirm.translate(context ?? Get.context!),
          isCancel: true,
          onTap: () {
            isConfirm = true;
            Get.back();
          },
        );
      },
    );
    return isConfirm;
  }

  showToast(String message) {
    toastification.dismissAll(delayForAnimation: false);
    toastification.show(
      context: Get.overlayContext,
      title:
          // RichText(
          //     text: TextSpan(children: [
          //   TextSpan(text: message, style: Get.context?.myTheme.textThemeT1.body),
          //   TextSpan(text: "\n", style: Get.context?.myTheme.textThemeT1.body),
          Container(
        alignment: Alignment.center,
        child: Text(message,
            style: Get.context?.myTheme.textThemeT1.body
                .copyWith(color: Colors.white, fontSize: 14)),
      ),
      // ])),
      backgroundColor: Colors.black87,
      autoCloseDuration: const Duration(seconds: 3),
      style: ToastificationStyle.flat,
      showProgressBar: false,
      showIcon: false,
      closeButtonShowType: CloseButtonShowType.none,
      alignment: Alignment.bottomCenter,
    );
  }

  void showOptionalDialog({
    required String message,
    required VoidCallback onPressedAltBtn,
    required VoidCallback onPressedBtn,
  }) {
    showDialog(
      context: Get.context!,
      builder: (context) {
        return AppOptionalDialog(
            message: message,
            onPressedAltBtn: onPressedAltBtn,
            onPressedBtn: onPressedBtn);
      },
    );
  }

  showError(String message) {
    showDialog(
      context: Get.context!,
      builder: (context) {
        return AppDialog(message: message);
      },
    );
  }

  Future<void> showQrCodeImage({
    required String id,
    required String data,
    required String nameBloodDonation,
    required DateTime timeBloodDonation,
    required int idBloodDonation,
    required int idRegister,
  }) async {
    try {
      if (GetIt.instance<AppCenter>().showQRCodeOnlyDangKyId == 1) {
        data = id;
      }

      var dataEncrypt = AlgorisUtils.encrypt(data);
      dataEncrypt = "00000+++++${dataEncrypt.replaceAll("=", "|")}";
      // print(dataEncrypt);

      await Get.to(
        () => ViewQrImageData(
          data: dataEncrypt,
          nameBloodDonation: nameBloodDonation,
          timeBloodDonation: timeBloodDonation,
          idBloodDonation: idBloodDonation.toString(),
          idRegister: idRegister.toString(),
        ),
        fullscreenDialog: true,
      );
    } catch (e) {
      print(e);
      showToast(AppLocale.errorOccurredPleaseRetry.translate(Get.context!));
      // TODO
    }
  }

  Future<void> onReady(BuildContext context) async {
    FireBaseManager.instance.initFireBaseMessage();
    deviceId = await AppUtils.instance.getMacAddressMobile();
    appVersion = await getReleaseVersion();
    await 1.delay();
    FireBaseManager.instance.getDataAppVersion((version) {
      print("version  ${version?.toJson()}");

      ///
      checkShowUpdateVersion(context, version);
    });
    // FireBaseManager.instance.createPath(endpoint: "", data: {"a": "b"});
    // TODO
  }

  Future<String> getReleaseVersion() async {
    final contents = await rootBundle.loadString("pubspec.yaml");
    final lines = contents.split('\n');

    for (var line in lines) {
      if (line.startsWith('version:')) {
        appVersion = line.split(':')[1].trim().split('+')[0].trim();
      }
    }
    return appVersion;
  }

  Future<void> checkShowUpdateVersion(
    BuildContext context,
    AppVersion? version,
  ) async {
    ///
    if (version == null) {
      return;
    }

    var updateUrl = version.linkUpdateIos ?? version.linkUpdateAndroid ?? "";
    var newVersion =
        (((Platform.isIOS ? version.iosVersion : version.androidVersion) ?? "0")
                    .replaceAll(".", ""))
                .toIntOrZero ??
            0;
    var currentVersion = appVersion.replaceAll(".", "").toIntOrZero ?? 0;
    if (Platform.isIOS) {
      updateUrl = version.linkUpdateIos ?? "";
    } else {
      updateUrl = version.linkUpdateAndroid ?? "";
    }
    print("newVersion  $newVersion  currentVersion  $currentVersion");

    if ((version.isShowUpdate == true) &&
        (newVersion > currentVersion) &&
        updateUrl != "" &&
        (version.deadLineUpdate())) {
      AlertUpdate.show(
          context: context,
          version.updateTitle ?? "Đã có version mới",
          version.updateContent ?? "Vui lòng cập nhật version mới!",
          updateUrl,
          version.isForceUpdate ?? false, updateAction: (isUpdate) {
        ///
      });
    }
  }

  ///08e78138-bd12-5cf9-8b5f-c4f2966996d3
  ///11fb6e7f-f58f-548b-9ff4-a5813ba5ab60
  ///00000000-0000-0000-0000-000000000000
  ///test
  Future<String> getMacAddressMobile() async {
    try {
      String uniqueDeviceId =
          (await _getId()) ?? "00000000-0000-0000-0000-000000000000";
      //await MobileDeviceIdentifier().getDeviceId();
      // const Uuid().v5(null, DateTime.now().toIso8601String());
      return uniqueDeviceId;
    } catch (e) {
      // TODO
      return "";
    }
  }

  Future<String?> _getId() async {
    var deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) {
      // import 'dart:io'
      var iosDeviceInfo = await deviceInfo.iosInfo;
      return iosDeviceInfo.identifierForVendor
          ?.toLowerCase(); // unique ID on iOS
    } else if (Platform.isAndroid) {
      // var androidDeviceInfo = await deviceInfo.androidInfo;
      return (await const AndroidId().getId())
          ?.toLowerCase(); // unique ID on Android
    }
    return null;
  }

  String formatUUID(String uuidString) {
    return const Uuid().v5(null, uuidString);
    // Ensure the string has 32 characters
    // if (uuidString.length != 32) {
    //   return uuidString;
    // }

    // // Insert hyphens at the correct positions
    // return '${uuidString.substring(0, 8)}-'
    //     '${uuidString.substring(8, 12)}-'
    //     '${uuidString.substring(12, 16)}-'
    //     '${uuidString.substring(16, 20)}-'
    //     '${uuidString.substring(20)}';
  }
}
