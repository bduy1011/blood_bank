import 'dart:developer';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:blood_donation/base/base_view/base_view.dart';
import 'package:blood_donation/utils/extension/context_ext.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app/app_util/enum.dart';
import '../../../app/config/routes.dart';
import '../../../models/blood_type.dart';
import '../../../models/giaodich_response.dart';
import '../../../utils/app_utils.dart';
import '../../components/blood_filter.dart';

class HistoryRegisterBuyBloodController extends BaseModelStateful {
  TinhTrangGiaoDich type = TinhTrangGiaoDich.ChoXacNhan;
  List<GiaodichResponse> historys = [];
  AutoSizeGroup autoSizeGroupTab = AutoSizeGroup();
  List<BloodType> bloodTypes = [];
  DateTime? startDate = DateTime.now().subtract(const Duration(days: 14));
  DateTime? endDate = DateTime.now().add(const Duration(days: 14));
  @override
  Future<void> onInit() async {
    init();
    super.onInit();
  }

  Future<void> init() async {
    try {
      startDate = DateTime.now().subtract(Duration(
        days: appCenter.soNgayHienThiLichLayMau,
      ));
      endDate = DateTime.now().add(Duration(
        days: appCenter.soNgayHienThiLichLayMau,
      ));
      loadData();
      showLoading();

      ///
      final response = await appCenter.backendProvider.getBloodTypes();
      if (response.status == 200) {
        bloodTypes = response.data ?? [];
        refresh();
      }
    } catch (e, s) {
      log("init()", error: e, stackTrace: s);
    }
  }

  void changeTab({required TinhTrangGiaoDich type}) async {
    this.type = type;
    await loadData();
    refresh();
  }

  ///

  Future<void> loadData() async {
    ///
    try {
      showLoading();

      final response = await appCenter.backendProvider.loadGiaoDich({
        "pageIndex": 1,
        "pageSize": 10000,
        "ngayTu": startDate?.toIso8601String(),
        "ngayDen": endDate?.toIso8601String(),
        "tinhTrangs": type == TinhTrangGiaoDich.DaDuyet
            ? [
                TinhTrangGiaoDich.DuyetMotPhan.value,
                TinhTrangGiaoDich.DaDuyet.value
              ]
            : [type.value],
      });
      if (response.status == 200) {
        historys = (response.data ?? []);
        search();
      } else {
        historys = [];
      }
      refresh();
    } catch (e, s) {
      log("init()", error: e, stackTrace: s);
    }
    hideLoading();
  }

  void search() {
    //
  }
  Future<void> updateItem(GiaodichResponse item) async {
    ///
    // if (item.tinhTrang == TinhTrangGiaoDich.ThucHien.value) {
    //   AppUtils.instance.showToast("Không thể cập nhật giao dịch đã duyệt");
    //   return;
    // }
    var rs = await Get.toNamed(Routes.registerBuyBlood, arguments: {
      "giaodichResponse": item,
    });
    if (rs is Map && rs["isUpdate"] == true) {
      loadData();
    }
  }

  Future<void> deleteItem(GiaodichResponse item) async {
    ///
    var result = await AppUtils.instance.showMessageConfirmCancel(
      "Xác nhận",
      "Xác nhận hủy yêu cầu nhượng máu này?",
      context: Get.context,
    );
    if (result == true) {
      try {
        showLoading();
        final response = await appCenter.backendProvider
            .deleteGiaoDich(item.giaoDichId?.toString() ?? "");
        if (response.status == 200) {
          historys.remove(item);
          refresh();
          AppUtils.instance.showToast("Hủy yêu cầu nhượng máu thành công");
        } else {
          AppUtils.instance.showToast("Hủy yêu cầu nhượng máu thất bại");
        }
      } catch (e, s) {
        log("deleteItem()", error: e, stackTrace: s);
      }
      hideLoading();
    }
  }

  Future<void> onFilter(BuildContext context) async {
    var rs = await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      barrierColor: context.myTheme.colorScheme.scaffoldBackgroundColor,
      shape: const RoundedRectangleBorder(),
      backgroundColor: context.myTheme.colorScheme.scaffoldBackgroundColor,
      builder: (context) {
        return BloodFilter(
          startDate: startDate,
          endDate: endDate,
          onChanged: (startDate, endDate, province, district, status) {
            this.startDate = startDate;
            this.endDate = endDate;
          },
        );
      },
    );
    if (rs == true) {
      loadData();
    }
  }
}
