import 'dart:developer';

import 'package:blood_donation/utils/extension/context_ext.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../base/base_view/base_model_stateful.dart';
import '../../../models/blood_type.dart';
import '../../../models/donation_blood_history_response.dart';
import '../../../utils/webview_screen.dart';
import '../../components/blood_history_filter.dart';

class BloodLocationsHistoryController extends BaseModelStateful {
  List<DonationBloodHistoryResponse> _dataHistory = [];

  List<DonationBloodHistoryResponse> dataHistorySearch = [];
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
    init();
    super.onInit();
  }

  DateTime? startDate;

  DateTime? endDate;

  bool? isSanLocAmTinh;
  bool? isSanLocDuongTinh;
  bool? isSanLocKhongXacDinh;
  List<String> maNhomMaus = [];
  List<BloodType> bloodTypes = [];
  Future<void> init() async {
    try {
      // startDate = DateTime.now()
      //     .subtract(Duration(days: appCenter.soNgayChoHienMauLai));
      await loadData();
      showLoading();
      final response = await appCenter.backendProvider.getBloodTypes();
      if (response.status == 200) {
        bloodTypes = response.data ?? [];
        refresh();
      }
    } catch (e, s) {
      log("init()", error: e, stackTrace: s);
    } finally {
      hideLoading();
    }
  }

  Future<void> loadData() async {
    ///
    try {
      showLoading();
      final response =
          await appCenter.backendProvider.bloodDonationHistory(body: {
        "pageIndex": 1,
        "pageSize": 100000,
        "ngayThuTu": startDate?.toIso8601String(),
        "ngayThuDen": endDate?.toIso8601String(),
        "maNhomMaus": maNhomMaus,
        "nguoiHienMauIds":
            appCenter.authentication?.dmNguoiHienMau?.nguoiHienMauId != null
                ? [appCenter.authentication?.dmNguoiHienMau?.nguoiHienMauId]
                : [-1],
        "isSanLocAmTinh": isSanLocAmTinh,
        "isSanLocDuongTinh": isSanLocDuongTinh,
        "isSanLocKhongXacDinh": isSanLocKhongXacDinh,
      });
      if (response.status == 200) {
        _dataHistory = response.data ?? [];
        search(searchText);
      }
      refresh();
    } catch (e, s) {
      log("init()", error: e, stackTrace: s);
    } finally {
      hideLoading();
    }
  }

  String? searchText = "";

  Future<void> search(String? text) async {
    ///
    searchText = text;
    if (text?.trim().isNotEmpty != true) {
      dataHistorySearch = _dataHistory;
    } else {
      dataHistorySearch = _dataHistory
          .where((e) =>
              "${e.tenSanPham}${e.ketQuaKTBTDescription}${e.ketQuaHbsAgDescription}${e.ketQuaHIVDescription}${e.ketQuaHCVDescription}"
                  .toLowerCase()
                  .contains("$text".toLowerCase()) ==
              true)
          .toList();
    }
    refresh();
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
        return BloodHistoryFilter(
          startDate: startDate,
          endDate: endDate,
          isSanLocAmTinh: isSanLocAmTinh,
          isSanLocDuongTinh: isSanLocDuongTinh,
          isSanLocKhongXacDinh: isSanLocKhongXacDinh,
          bloodTypes: bloodTypes,
          maNhomMaus: maNhomMaus,
          onChanged: (startDate, endDate, isSanLocAmTinh, isSanLocDuongTinh,
              isSanLocKhongXacDinh, maNhomMaus) {
            this.startDate = startDate;
            this.endDate = endDate;
            this.isSanLocAmTinh = isSanLocAmTinh;
            this.isSanLocDuongTinh = isSanLocDuongTinh;
            this.isSanLocKhongXacDinh = isSanLocKhongXacDinh;
            this.maNhomMaus = maNhomMaus ?? [];
          },
        );
      },
    );
    if (rs == true) {
      loadData();
    }
  }

  onClickItem(DonationBloodHistoryResponse item) async {
    ///
    try {
      if (item.isHyperlink != null) {
        ///
        showLoading();
        var html = await appCenter.backendProvider.getHTMLLetter(
            item.id?.toString() ?? "", item.isHyperlink?.toString() ?? "");
        hideLoading();
        if (html.isNotEmpty) {
          ///
          Get.to(WebviewScreen(
            html: html,
          ));
        }
      }
    } catch (e) {
      // TODO
    }
    hideLoading();
  }
}
