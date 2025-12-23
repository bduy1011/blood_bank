import 'dart:developer';

import 'package:blood_donation/base/base_view/base_view.dart';
import 'package:blood_donation/utils/extension/context_ext.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app/app_util/enum.dart';
import '../../../app/config/routes.dart';
import '../../../models/blood_donation_event.dart';
import '../../../models/district.dart';
import '../../../models/general_response.dart';
import '../../../models/province.dart';
import '../../../models/ward.dart';
import '../../../utils/app_utils.dart';
import '../../components/blood_filter.dart';

class DonationScheduleController extends BaseModelStateful {
  final List<BloodDonationEvent> _bloodDonationEvents = [];
  String searchText = "";
  List<BloodDonationEvent> get bloodDonationEventsSearch {
    return _bloodDonationEvents
        .where((e) =>
            "${e.ten} ${e.diaDiemToChuc} ${e.tenXa} ${e.tenHuyen}  ${e.tenTinh}"
                .toLowerCase()
                .contains(searchText.toLowerCase()))
        .toList();
  }

  // TextEditingController searchTextController = TextEditingController();
  @override
  Future<void> onClose() async {
    ///
    // searchTextController.dispose();
    super.onClose();
  }

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
    // searchTextController.addListener(onSearch);
    super.onInit();
  }

  onSearch(String text) {
    searchText = text;
    refresh();
  }

  bool checkValidate() {
    if (appCenter.authentication?.duongTinhGanNhat == true) {
      AppUtils.instance.showMessage(
          "Kết quả xét nghiệm gần nhất của bạn là Phản ứng, nên không thể đăng ký hiến máu");
      return false;
    }

    return true;
  }

  Future<void> gotoDonationBlood(BloodDonationEvent? event) async {
    if (checkValidate() == false) {
      return;
    }
    if (event?.isDuocDangKy == true) {
      var loaiHien =
          event?.loaiMau == LoaiMau.TieuCau.value ? "tiểu cầu" : "máu";
      var rs = await AppUtils.instance.showMessageConfirmCancel(
        "Xác nhận hiến $loaiHien",
        "Đồng ý đăng ký hiến $loaiHien\r\ntại địa điểm này?",
        context: Get.context,
      );
      if (rs == true) {
        Get.toNamed(Routes.registerDonateBlood, arguments: {"event": event});
      }
    }
  }

  Future<void> backToDonationBlood(BloodDonationEvent? event) async {
    if (checkValidate() == false) {
      return;
    }
    if (event?.isDuocDangKy == true) {
      var loaiHien =
          event?.loaiMau == LoaiMau.TieuCau.value ? "tiểu cầu" : "máu";
      var rs = await AppUtils.instance.showMessageConfirmCancel(
        "Xác nhận hiến $loaiHien",
        "Đồng ý đăng ký hiến $loaiHien\r\ntại địa điểm này?",
        context: Get.context,
      );
      if (rs == true) {
        Get.back(result: {"event": event});
      }
    }
  }

  Future<void> init() async {
    try {
      showLoading();

      startDate = DateTime.now();
      endDate = startDate?.add(Duration(
        days: appCenter.soNgayHienThiLichLayMau,
      ));
      loadData();
    } catch (e, s) {
      log("init()", error: e, stackTrace: s);
    } finally {
      hideLoading();
    }
    try {
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
    } catch (e) {
      // TODO
    }
  }

  Future<void> loadData() async {
    try {
      var body = {
        "pageIndex": 1,
        "pageSize": 100000,
        "tuNgay": startDate?.toIso8601String(),
        "denNgay": endDate?.toIso8601String(),
        "huyen": district?.codeDistrict,
        "tinh": province?.codeProvince,
        "tinhTrangs": listStatus
            .where((e) => e.description == tinhTrang)
            .map((e) => e.value)
            .toList(),
      };
      showLoading();
      var response =
          await appCenter.backendProvider.getBloodDonationFilter(body: body);
      if (response.status == 200) {
        _bloodDonationEvents.clear();
        _bloodDonationEvents.addAll(response.data ?? []);
        refresh();
      }
      hideLoading();
    } catch (e) {
      // TODO
    }
    hideLoading();
  }

  List<Province>? provinces;
  Province? province;
  List<District>? districts;
  District? district;

  List<Ward>? wards;
  DateTime? startDate = DateTime.now();
  DateTime? endDate = DateTime.now();
  List<TinhTrangDotLayMau> listStatus = [
    TinhTrangDotLayMau.TaoDotMoi,
    TinhTrangDotLayMau.DaChot,
    TinhTrangDotLayMau.Huy,
  ];
  String? tinhTrang = TinhTrangDotLayMau.TaoDotMoi.description;
  Future<GeneralResponse<Province>> _getProvince() {
    return appCenter.backendProvider.getProvince();
  }

  Future<GeneralResponse<Ward>> _getWard() {
    return appCenter.backendProvider.getWards();
  }

  Future<GeneralResponse<District>> _getDistrict() {
    return appCenter.backendProvider.getDistrict();
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
          listStatus: listStatus.map((e) => e.description).toList(),
          status: tinhTrang,
          limidDate: appCenter.maxTuNgayDenNgayLichLayMau,
          onChanged: (startDate, endDate, province, district, tinhTrang) {
            this.startDate = startDate;
            this.endDate = endDate;
            this.province = province;
            this.district = district;
            this.tinhTrang = tinhTrang;
          },
        );
      },
    );
    if (rs == true) {
      loadData();
    }
  }
}
