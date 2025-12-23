import 'package:blood_donation/base/base_view/base_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/app_utils.dart';

class ForgotPasswordController extends BaseModelStateful {
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController idCardController = TextEditingController();

  @override
  Future<void> onClose() {
    // TODO: implement onClose
    phoneController.dispose();
    fullNameController.dispose();
    idCardController.dispose();
    return super.onClose();
  }

  Future<void> requestForgotPassword(BuildContext context) async {
//
    try {
      var hoTen = fullNameController.text.trim();
      var cmnd = idCardController.text.trim().replaceAll(" ", "");
      var soDT = phoneController.text.trim().replaceAll(" ", "");

      if (hoTen.isEmpty) {
        AppUtils.instance.showMessage(
          "Vui lòng nhập họ tên",
          context: context,
        );
        return;
      }
      if (cmnd.isEmpty) {
        AppUtils.instance.showMessage(
          "Vui lòng nhập cccd",
          context: context,
        );
        return;
      }
      if (soDT.isEmpty) {
        AppUtils.instance.showMessage(
          "Vui lòng nhập số điện thoại",
          context: context,
        );
        return;
      }
      if (soDT.length != 10 || !soDT.isNum) {
        AppUtils.instance.showMessage(
          "Số điện thoại không đúng định dạng",
          context: context,
        );
        return;
      }
      showLoading();
      var data = await appCenter.backendProvider.requestForgotPassword(
        body: {
          "id": 0,
          "hoTen": hoTen,
          "cmnd": cmnd,
          "soDT": soDT,
          "createdDate": DateTime.now().toIso8601String(),
          "deviceId": AppUtils.instance.deviceId,
        },
      );
      hideLoading();
      if (data.status == 200) {
        await AppUtils.instance.showMessage(
          "Thông tin đã được gửi!",
          context: context,
        );
        fullNameController.text = "";
        idCardController.text = "";
        phoneController.text = "";
        Get.back();
      } else {
        AppUtils.instance.showError("Lỗi gửi thông tin ${data.message}");
      }
    } catch (e) {
      // TODO
      print("$e");
    }
    hideLoading();
  }
}
