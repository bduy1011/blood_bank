import 'package:blood_donation/base/base_view/base_model_stateful.dart';
import 'package:blood_donation/core/localization/app_locale.dart';
import 'package:blood_donation/models/feedback_respose.dart';
import 'package:blood_donation/utils/app_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app/config/routes.dart';

class FeedbackController extends BaseModelStateful {
  List<FeedbackResponse> feedbacks = [];

  DateTime? fromDate = DateTime.now().subtract(const Duration(days: 30));
  DateTime? toDate = DateTime.now();

  Future<void> selectDateRange(BuildContext context) async {
    final initialDateRange = DateTimeRange(
      start: fromDate ?? DateTime.now().subtract(const Duration(days: 30)),
      end: toDate ?? DateTime.now(),
    );
    final pickedDateRange = await showDateRangePicker(
      context: context,
      initialDateRange: initialDateRange,
      firstDate: DateTime(2023),
      lastDate: DateTime(2100),
    );
    if (pickedDateRange != null) {
      refresh(fn: () {
        fromDate = pickedDateRange.start;
        toDate = pickedDateRange.end;
      });
      loadFeedback();
    }
  }

  @override
  Future<void> onInit() async {
    loadFeedback();
    super.onInit();
  }

  Future<void> loadFeedback() async {
    try {
      //
      if (appCenter.authentication?.cmnd?.isNotEmpty == true) {
        var body = {
          "pageIndex": 1,
          "pageSize": 100000,
          "ngayTu": fromDate?.toIso8601String(),
          "ngayDen": toDate?.toIso8601String()
        };
        var data = await appCenter.backendProvider.getGopY(body: body);
        hideLoading();
        if (data.status == 200) {
          feedbacks = data.data ?? [];
          refresh();
        } else {
          AppUtils.instance.showToast("${data.message}");
        }
      }
    } catch (e, t) {
      print(e);
      print(t);
      hideLoading();
    }
  }

  Future<void> createGopY(String hoten, String email, String noidung) async {
    try {
      //
      var body = {
        "id": 0,
        "ngay": DateTime.now().toIso8601String(),
        "nguoiHienMauId":
            appCenter.authentication?.dmNguoiHienMau?.nguoiHienMauId,
        "hoVaTen": hoten,
        "loaiGopY": "LienHe",
        "noiDung": noidung,
        "email": email,
        "soDT": appCenter.authentication?.dmNguoiHienMau?.soDT ??
            appCenter.authentication?.phoneNumber,
        "daXem": false,
        "dmNguoiHienMau": appCenter.authentication?.dmNguoiHienMau?.toJson()
      };
      var data = await appCenter.backendProvider.createGopY(body: body);
      hideLoading();
      if (data.status == 200) {
        AppUtils.instance.showToast(AppLocale.sendSuccess.translate(Get.context!));
        Get.back();
      } else {
        AppUtils.instance.showToast("${data.message}");
      }
    } catch (e, t) {
      print(e);
      print(t);
      hideLoading();
    }
  }

  Future<void> sendFeedback() async {
    //
    if (appCenter.authentication?.cmnd?.isNotEmpty == true) {
      await Get.toNamed(Routes.addFeedback);
      loadFeedback();
    } else {
      ///
      await AppUtils.instance.showMessage(
        AppLocale.pleaseUpdatePersonalInfoBeforeFeedback.translate(Get.context!),
        context: Get.context,
      );
      Get.offNamed(Routes.profile);
      loadFeedback();
    }
  }
}
