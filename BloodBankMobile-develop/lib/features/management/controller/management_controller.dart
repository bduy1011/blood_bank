import 'dart:developer';

import 'package:blood_donation/base/base_view/base_view.dart';
import 'package:blood_donation/utils/extension/datetime_extension.dart';
import 'package:get/get.dart';

import '../../../models/cau_hinh_ton_kho_view.dart';
import '../../../models/general_response.dart';
import '../../../utils/app_utils.dart';

class ManagementController extends BaseModelStateful {
  CauHinhTonKho? cauHinhTonKho;
  DateTime date = DateTime.now();

  bool get isUpdate => date.isAfter(
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day));

  String ghichu = "";

  final RxInt total = 0.obs;
  final RxInt totalBooking = 0.obs;

  ///
  int getTotal() {
    var t = cauHinhTonKho?.cauHinhTonKhoChiTietViews?.fold(
            0,
            (tt, cauHinhTonKhoChiTietView) =>
                (tt) + (getTotalDetail(cauHinhTonKhoChiTietView))) ??
        0;
    total.value = t;
    return t;
  }

  int getTotalDetail(CauHinhTonKhoChiTietViews cauHinhTonKhoChiTietViews) {
    return cauHinhTonKhoChiTietViews.cauHinhTonKhoChiTietConViews?.fold(
            0, (total, cauhinh) => (total ?? 0) + (cauhinh.soLuong ?? 0)) ??
        0;
  }

  int getTotalBooking() {
    var booking = cauHinhTonKho?.cauHinhTonKhoChiTietViews?.fold(
            0,
            (tt, cauHinhTonKhoChiTietView) =>
                (tt) + (getTotalDetail(cauHinhTonKhoChiTietView))) ??
        0;
    totalBooking.value = booking;
    return booking;
  }

  int getTotalBookingDetail(
      CauHinhTonKhoChiTietViews cauHinhTonKhoChiTietViews) {
    return cauHinhTonKhoChiTietViews.cauHinhTonKhoChiTietConViews?.fold(
            0,
            (total, cauhinh) =>
                (total ?? 0) + (cauhinh.soLuongDuocBooking ?? 0)) ??
        0;
  }

  void onChangeDate(DateTime date) async {
    this.date = date;
    await initTonKhoTemplate();
    getTotal();
    getTotalBooking();
    // await initTonKhoByDate();
  }

  Future<void> initTonKhoByDate() async {
    try {
      final response = await appCenter.backendProvider.getTonKho({
        "pageIndex": 1,
        "pageSize": 10000,
        // "ids": [0],
        "ngayTu": date.dateYYYYMMddString,
        "ngayDen": date.dateYYYYMMddString,
        "loaiSanPham": 1
      });
      if (response.status == 200) {
        // cauHinhTonKho = response.data;
      }
    } catch (e) {
      // TODO
    }
  }

  @override
  Future<void> onInit() async {
    ///
    init();
    super.onInit();
  }

  Future<void> init() async {
    try {
      showLoading();
      await initTonKhoTemplate();
      // await initTonKhoByDate();
      getTotal();
      getTotalBooking();
      refresh();
    } catch (e, s) {
      log("init()", error: e, stackTrace: s);
    }
    hideLoading();
  }

  Future<void> initTonKhoTemplate() async {
    try {
      final response = await appCenter.backendProvider.initTonKhoTemplate(date);
      if (response.status == 200) {
        cauHinhTonKho = response.data;
      }
    } catch (e) {
      // TODO
    }
  }

  Future<void> onSubmit() async {
    ///
    //

    Map<String, dynamic> body = {
      "id": cauHinhTonKho?.id ?? 0,
      "ngay": date.toIso8601String(),
      "cauHinhTonKhoChiTiets": cauHinhTonKho?.cauHinhTonKhoChiTietViews
          ?.map((e) => {
                "id": e.id ?? 0,
                "cauHinhTonKhoId": cauHinhTonKho?.id ?? 0,
                "loaiSanPham": e.loaiSanPham ?? 1,
                "cauHinhTonKhoChiTietCons": e.cauHinhTonKhoChiTietConViews
                    ?.map(
                      (eee) => {
                        "id": eee.id ?? 0,
                        "cauHinhTonKhoChiTietId": e.id ?? 0,
                        "soLuong": eee.soLuong ?? 0,
                        "soLuongDuocBooking": eee.soLuongDuocBooking ?? 0,
                        "maNhomMau": eee.maNhomMau,
                      },
                    )
                    .toList()
              })
          .toList(),
    };

    try {
      AppUtils.instance.showLoading();
      GeneralResponseMap? response;
      if ((cauHinhTonKho?.id ?? 0) != 0) {
        response = await appCenter.backendProvider
            .updateTonKho(cauHinhTonKho!.id.toString(), body);
      } else {
        response = await appCenter.backendProvider.createTonKho(body);
      }

      AppUtils.instance.hideLoading();
      if (response.status == 200) {
        AppUtils.instance.showToast("Cập nhật thông tin tồn kho thành công.");
        Get.back();
      } else {
        AppUtils.instance.showToast(
          response.message ?? "",
        );
      }
    } catch (e) {
      // TODO
      log("onSubmit $e");
    }
    AppUtils.instance.hideLoading();
  }
}
