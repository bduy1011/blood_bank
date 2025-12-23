import 'dart:convert';
import 'dart:developer';

import 'package:blood_donation/app/app_util/enum.dart';
import 'package:blood_donation/base/base_view/base_view.dart';
import 'package:blood_donation/utils/extension/context_ext.dart';
import 'package:flutter/material.dart';

import '../../../models/district.dart';
import '../../../models/general_response.dart';
import '../../../models/province.dart';
import '../../../models/register_donation_blood_history_response.dart';
import '../../../models/ward.dart';
import '../../../utils/app_utils.dart';
import '../../../utils/redirect_to_google_utils.dart';
import '../../components/blood_filter.dart';

class BloodLocationsController extends BaseModelStateful {
  List<RegisterDonationBloodHistoryResponse> _dataHistory = [];
  List<RegisterDonationBloodHistoryResponse> dataHistorySearch = [];
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

  List<Province>? provinces;
  Province? province;
  List<District>? districts;
  District? district;
  List<Ward>? wards;
  DateTime? startDate = DateTime.now().subtract(const Duration(days: 14));
  DateTime? endDate = DateTime.now();
  Future<void> init() async {
    try {
      startDate = DateTime.now();
      endDate = startDate?.add(Duration(
        days: appCenter.soNgayHienThiLichLayMau,
      ));
      await loadData();
      showLoading();
      final province = await _getProvince();
      final ward = await _getWard();
      final district = await _getDistrict();

      if (province.status == 200) {
        provinces = province.data ?? [];
      }
      if (district.status == 200) {
        districts = district.data ?? [];
      }
      if (ward.status == 200) {
        wards = ward.data ?? [];
      }
      refresh();
    } catch (e, s) {
      log("init()", error: e, stackTrace: s);
    } finally {
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
          province: province,
          provinces: provinces,
          district: district,
          districts: districts,
          startDate: startDate,
          endDate: endDate,
          onChanged: (startDate, endDate, province, district, status) {
            this.startDate = startDate;
            this.endDate = endDate;
            this.province = province;
            this.district = district;
          },
        );
      },
    );
    if (rs == true) {
      loadData();
    }
  }

  Future<void> loadData() async {
    ///
    try {
      showLoading();
      final response =
          await appCenter.backendProvider.registerDonateBloodHistory(body: {
        "pageIndex": 1,
        "pageSize": 100000,
        "ngayTu": startDate?.toIso8601String(),
        "ngayDen": endDate?.toIso8601String(),
        "tinh": province?.codeProvince,
        // "xa": "string",
        "nguoiHienMauIds":
            appCenter.authentication?.dmNguoiHienMau?.nguoiHienMauId != null
                ? [appCenter.authentication?.dmNguoiHienMau?.nguoiHienMauId]
                : [],
        "huyen": district?.codeDistrict
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
              "${e.hoVaTen}${e.tenTinh}${e.tenHuyen}${e.tenXa}${e.tinhTrangDescription}"
                  .toLowerCase()
                  .contains("$text".toLowerCase()) ==
              true)
          .toList();
    }
    refresh();
  }

  Future<void> cancelRegisterDonate(
      RegisterDonationBloodHistoryResponse item) async {
    ///
    try {
      showLoading();
      // var response =
      var response = await appCenter.backendProvider.cancelRegisterDonateBlood(
          body: (item..tinhTrang = TinhTrangDangKyHienMau.Huy.value).toMap(),
          id: item.id ?? 0);
      hideLoading();
      if (response.status == 200) {
        AppUtils.instance.showToast("Hủy đăng ký thành công");
        loadData();
      }

      ///

      ///
      refresh();
    } catch (e, s) {
      log("cancelRegisterDonate()", error: e, stackTrace: s);
      hideLoading();
    }
  }

  Future<void> viewRoad(RegisterDonationBloodHistoryResponse item) async {
    ///
    try {
      showLoading();
      var response = await appCenter.backendProvider.getBloodDonationEventsByID(
          id: item.dotLayMauId ?? 0, ngayGio: item.ngay!);
      if (response.status == 200) {
        if (response.data?.firstOrNull?.googleMapLink?.isNotEmpty == true) {
          ProcessWebviewDialog.instance.openGoogleMapRoadToUrlAddress(
              response.data!.firstOrNull!.googleMapLink ?? "");
        } else {
          AppUtils.instance.showToast("Không tìm thấy đường đi");
        }
      }

      ///
      hideLoading();

      refresh();
    } catch (e, s) {
      log("init()", error: e, stackTrace: s);
    }
    hideLoading();
  }

  Future<void> exportQrCode(RegisterDonationBloodHistoryResponse item) async {
    ///
    try {
      ///max length byte
      ///23648
      showLoading();
      // var response =
      var response = await appCenter.backendProvider
          .getRegisterDonateBloodById(id: item.id.toString());
      hideLoading();
      if (response?.status == 200 && response?.data != null) {
        item.surveyQuestions = response!.data!.surveyQuestions;
      }

      var name = item.hoVaTen ?? "";

      ///
      var response2 = await appCenter.backendProvider
          .getBloodDonationEventsByID(
              id: item.dotLayMauId!, ngayGio: item.ngay!);
      if (response2.status == 200) {
        name = response2.data?.firstOrNull?.ten ?? name;
      }

      ///
      var data = jsonEncode(item.toJsonQrCode());
      log(data);
      AppUtils.instance.showQrCodeImage(
        id: item.id?.toString() ?? "0",
        data: data,
        nameBloodDonation: name,
        timeBloodDonation: item.ngay!,
        idBloodDonation: item.dotLayMauId!,
        idRegister: item.id!,
      );

      // refresh();
    } catch (e, s) {
      log("exportQrCode()", error: e, stackTrace: s);
      hideLoading();
    }
  }

  Future<GeneralResponse<Province>> _getProvince() {
    return appCenter.backendProvider.getProvince();
  }

  Future<GeneralResponse<Ward>> _getWard() {
    return appCenter.backendProvider.getWards();
  }

  Future<GeneralResponse<District>> _getDistrict() {
    return appCenter.backendProvider.getDistrict();
  }
}
