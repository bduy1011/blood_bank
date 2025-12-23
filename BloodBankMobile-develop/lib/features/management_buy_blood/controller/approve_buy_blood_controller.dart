import 'dart:developer';

import 'package:blood_donation/base/base_view/base_view.dart';
import 'package:blood_donation/utils/extension/context_ext.dart';
import 'package:blood_donation/utils/extension/datetime_extension.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app/app_util/enum.dart';
import '../../../models/cau_hinh_ton_kho_view.dart';
import '../../../models/dm_don_vi_cap_mau_response.dart';
import '../../../models/general_response.dart';
import '../../../models/giao_dich_template.dart';
import '../../../models/giaodich_response.dart';
import '../../../utils/app_utils.dart';
import '../presentation/approve_register_buy_blood_page.dart';

class ApproveBuyBloodController extends BaseModelStateful {
  TinhTrangGiaoDich type = TinhTrangGiaoDich.ChoXacNhan;
  DateTime startDate = DateTime.now().subtract(const Duration(days: 14));
  DateTime endDate = DateTime.now();
  List<GiaodichResponse> historys = [];
  List<GiaodichResponse> _historys = [];
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
    loadData();
    super.onInit();
  }

  @override
  Future<void> onClose() async {
    ///
    super.onClose();
  }

  Future<void> loadData() async {
    ///
    try {
      showLoading();

      final response = await appCenter.backendProvider.loadGiaoDich({
        "pageIndex": 1,
        "pageSize": 10000,
        "ngayTu": startDate.toIso8601String(),
        "ngayDen": endDate.toIso8601String(),
        "tinhTrangs": type == TinhTrangGiaoDich.DaDuyet
            ? [
                TinhTrangGiaoDich.DuyetMotPhan.value,
                TinhTrangGiaoDich.DaDuyet.value
              ]
            : [type.value],
      });
      if (response.status == 200) {
        _historys = (response.data ?? []);
        onSearch(textSearch);
      } else {
        _historys = [];
        onSearch(textSearch);
      }
      refresh();
    } catch (e, s) {
      log("init()", error: e, stackTrace: s);
    }
    hideLoading();
  }

  Future<DmDonViCapMauResponse?> initDmDonViCapMau(
      GiaodichResponse item) async {
    try {
      final response = await appCenter.backendProvider.getDmDonViCapMau();
      if (response.status == 200) {
        var dmDonViCapMaus = response.data;
        var dmDonViCapMauCurrent = dmDonViCapMaus?.firstWhereOrNull(
            (element) => element.maDonVi == item.maDonViCapMau);
        return dmDonViCapMauCurrent;
        // dmDonViCapMauCurrent = dmDonViCapMaus?.firstOrNull;
      }
    } catch (e) {
      // TODO
      return null;
    }
    return null;
  }

  void mergeTonKho(
      GiaoDichTemplate giaoDichDetail, CauHinhTonKho cauHinhTonKho) {
    ///reset
    for (GiaoDichChiTietViews element
        in giaoDichDetail.giaoDichChiTietViews ?? []) {
      //
      for (GiaoDichConViews element2 in element.giaoDichConViews ?? []) {
        ///
        element2.soLuongTon = 0;
      }
    }

    ///
    giaoDichDetail.giaoDichChiTietViews?.forEach((element) {
      var tonKhoChiTiet = cauHinhTonKho.cauHinhTonKhoChiTietViews
          ?.firstWhereOrNull(
              (element1) => element1.loaiSanPham == element.loaiSanPham);

      ///
      if (tonKhoChiTiet != null) {
        element.giaoDichConViews?.forEach((element2) {
          var tonKhoChiTietCon = tonKhoChiTiet.cauHinhTonKhoChiTietConViews
              ?.firstWhereOrNull(
                  (element3) => element3.maNhomMau == element2.maNhomMau);

          if (tonKhoChiTietCon != null) {
            element2.soLuongTon = (tonKhoChiTietCon.soLuong ?? 0) -
                (tonKhoChiTietCon.soLuongDuocBooking ?? 0);
          }
        });
      }
    });
  }

  Future<bool> initTonMau(GiaoDichTemplate giaoDichDetail) async {
    try {
      final response = await appCenter.backendProvider.getTonKho({
        "pageIndex": 1,
        "pageSize": 10000,
        "ngayTu": giaoDichDetail.ngay!.dateYYYYMMddString,
        "ngayDen": giaoDichDetail.ngay!.dateYYYYMMddString,
        "loaiSanPham": 1
      });
      if (response.status == 200) {
        var ls = response.data ?? [];
        if (ls.isNotEmpty) {
          ls.sort((b, a) => (a.id ?? 0).compareTo(b.id ?? 0));

          final response2 = await appCenter.backendProvider
              .getTonKhoById("${ls.firstOrNull?.id ?? 0}");

          if (response2.status == 200) {
            var cauHinhTonKho = response2.data;

            ///check validate ton mau
            if (cauHinhTonKho != null) {
              ///có tồn trong ngày
              ///remove item hết tồn
              for (CauHinhTonKhoChiTietViews element
                  in cauHinhTonKho.cauHinhTonKhoChiTietViews ?? []) {
                element.cauHinhTonKhoChiTietConViews = element
                    .cauHinhTonKhoChiTietConViews
                    ?.where((e) =>
                        (e.soLuong ?? 0) - (e.soLuongDuocBooking ?? 0) > 0)
                    .toList();
              }
              if (cauHinhTonKho.cauHinhTonKhoChiTietViews?.firstWhereOrNull(
                      (e) =>
                          e.cauHinhTonKhoChiTietConViews?.isNotEmpty == true) ==
                  null) {
                AppUtils.instance.showMessage(
                  "Hiện không có tồn trong ngày ${giaoDichDetail.ngay!.dateTimeString}, vui lòng cập nhật tồn!",
                  context: Get.context,
                );
                cauHinhTonKho = null;
                return false;
              }
              mergeTonKho(giaoDichDetail, cauHinhTonKho);
              return true;
            } else {
              ///không tồn trong ngày
              AppUtils.instance.showMessage(
                "Hiện không có tồn trong ngày ${giaoDichDetail.ngay!.dateTimeString}, vui lòng cập nhật tồn!",
                context: Get.context,
              );
            }
          }
        } else {
          ///không tồn trong ngày
          AppUtils.instance.showMessage(
            "Hiện không có tồn trong ngày ${giaoDichDetail.ngay!.dateTimeString}, vui lòng cập nhật tồn!",
            context: Get.context,
          );
        }
      }
    } catch (e) {
      // TODO
      AppUtils.instance.showMessage(
        "Lỗi lấy tồn trong ngày ${giaoDichDetail.ngay!.dateTimeString}, vui lòng liên hệ Kỹ thuật viên!",
        context: Get.context,
      );
    }
    return false;
  }

  void onHaftApprove(BuildContext context, GiaodichResponse item) async {
    try {
      // if (item.tinhTrang != TinhTrangGiaoDich.ChoXacNhan.value) {
      //   return;
      // }
      var isEdit = item.tinhTrang == TinhTrangGiaoDich.ChoXacNhan.value;
      showLoading();
      final response = await appCenter.backendProvider
          .getGiaoDichById(item.giaoDichId?.toString() ?? "");
      var dmDonViCapMauResponse = await initDmDonViCapMau(item);
      hideLoading();
      if (response.status == 200 && response.data != null) {
        //
        var giaoDichDetail = response.data!;
        giaoDichDetail.dmDonViCapMauResponse = dmDonViCapMauResponse;

        ///check tồn
        showLoading();
        var isMergeTon = await initTonMau(giaoDichDetail);
        hideLoading();

        if (!isMergeTon) {
          return;
        }

        ///
        if (isEdit) {
          giaoDichDetail.giaoDichChiTietViews?.forEach((e) {
            e.giaoDichConViews?.forEach((eee) {
              eee.soLuongDuyet = eee.soLuong;
            });
          });
        }

        await showModalBottomSheet(
          isDismissible: false,
          useSafeArea: true,
          isScrollControlled: true,
          barrierColor: context.myTheme.colorScheme.scaffoldBackgroundColor,
          context: context,
          builder: (context) {
            return ApproveRegisterBuyBloodPage(
              item: giaoDichDetail,
              itemList: item,
              controller: this,
              isEdit: isEdit,
            );
          },
        );
        loadData();
      }

      //
    } catch (e) {
      hideLoading();
      // TODO
    }
  }

  int getTotal(GiaoDichTemplate giaoDichTemplate) {
    return giaoDichTemplate.giaoDichChiTietViews?.fold(
            0,
            (total, giaoDichChiTiet) =>
                (total ?? 0) + (getTotalDetail(giaoDichChiTiet))) ??
        0;
  }

  int getTotalDuyet(GiaoDichTemplate giaoDichTemplate) {
    return giaoDichTemplate.giaoDichChiTietViews?.fold(
            0,
            (total, giaoDichChiTiet) =>
                (total ?? 0) + (getTotalDetailDuyet(giaoDichChiTiet))) ??
        0;
  }

  int getTotalDetail(GiaoDichChiTietViews giaoDichChiTiet) {
    return giaoDichChiTiet.giaoDichConViews?.fold(
            0, (total, giaoDich) => (total ?? 0) + (giaoDich.soLuong ?? 0)) ??
        0;
  }

  int getTotalDetailDuyet(GiaoDichChiTietViews giaoDichChiTiet) {
    return giaoDichChiTiet.giaoDichConViews?.fold(0,
            (total, giaoDich) => (total ?? 0) + (giaoDich.soLuongDuyet ?? 0)) ??
        0;
  }

  bool checkAvailableTonKho(GiaoDichTemplate giaoDichTemplate) {
    var message = "";
    for (GiaoDichChiTietViews element
        in giaoDichTemplate.giaoDichChiTietViews ?? []) {
      //
      for (GiaoDichConViews element2 in element.giaoDichConViews ?? []) {
        ///
        if ((element2.soLuong ?? 0) > (element2.soLuongTon ?? 0)) {
          message +=
              "Số lượng ${element2.maNhomMauDescription} của ${element.loaiSanPhamDescription} (${element2.soLuong ?? 0}) không được lớn hơn (${element2.soLuongTon ?? 0})\n";
        }
      }
    }
    if (message.isNotEmpty) {
      AppUtils.instance.showMessage(
        message,
        context: Get.context,
        isAlignmentLeft: true,
      );
      return false;
    }

    ///
    return true;
  }

  void onApprove(
      GiaoDichTemplate giaoDichTemplate, GiaodichResponse item) async {
    var total = getTotal(giaoDichTemplate);
    var totalApprove = getTotalDuyet(giaoDichTemplate);

    if (totalApprove <= 0) {
      await AppUtils.instance.showMessageConfirmCancel(
        "Thông báo",
        "Vui lòng nhập số lượng duyệt",
        context: Get.context,
      );
      return;
    }
    if (!checkAvailableTonKho(giaoDichTemplate)) {
      return;
    }

    ///
    Map<String, dynamic> body = {
      "giaoDichId": giaoDichTemplate.giaoDichId ?? 0,
      "loaiPhieu": giaoDichTemplate.loaiPhieu,
      "tinhTrang": totalApprove >= total
          ? TinhTrangGiaoDich.DaDuyet.value
          : TinhTrangGiaoDich.DuyetMotPhan.value,
      "ngay": giaoDichTemplate.ngay?.toIso8601String(),
      "maDonViCapMau": giaoDichTemplate.maDonViCapMau,
      "ghiChu": giaoDichTemplate.ghiChu,
      "createdBy": giaoDichTemplate.createdBy,
      "createdDate": giaoDichTemplate.createdDate?.toIso8601String() ??
          DateTime.now().toIso8601String(),
      "updatedBy": appCenter.authentication?.userCode,
      "updatedDate": DateTime.now().toIso8601String(),
      "isLocked": giaoDichTemplate.isLocked,
      "giaoDichChiTiets": giaoDichTemplate.giaoDichChiTietViews
          ?.map((e) => {
                "giaoDichChiTietId": e.giaoDichChiTietId ?? 0,
                "giaoDichId": giaoDichTemplate.giaoDichId ?? 0,
                "loaiSanPham": e.loaiSanPham,
                "dienGiai": e.dienGiai,
                // "giaoDich":"string",
                "giaoDichCons": e.giaoDichConViews
                    ?.where((ee) => (ee.soLuong ?? 0) > 0)
                    .map(
                      (eee) => {
                        "id": eee.id ?? 0,
                        "maNhomMau": eee.maNhomMau,
                        "soLuong": eee.soLuong,
                        "giaoDichChiTietId": e.giaoDichChiTietId ?? 0,
                        "soLuongDuyet": eee.soLuongDuyet,
                      },
                    )
                    .toList()
              })
          .toList(),
      "donViCapMau": giaoDichTemplate.dmDonViCapMauResponse?.toJson(),
    };
    try {
      AppUtils.instance.showLoading();
      GeneralResponseMap? response;
      response = await appCenter.backendProvider
          .approveGiaoDich(giaoDichTemplate.giaoDichId?.toString() ?? "", body);
      hideLoading();
      if (response.status == 200) {
        AppUtils.instance.showToast("Duyệt yêu cầu nhượng máu thành công.");

        Get.back(result: {"approve": true});
      } else {
        AppUtils.instance.showToast(
          response.message ?? "",
        );
      }
    } catch (e) {
      // TODO
      log("approveGiaoDich $e");
    }
    AppUtils.instance.hideLoading();
  }

  void onCancel(
      GiaoDichTemplate giaoDichTemplate, GiaodichResponse item) async {
    var result = await AppUtils.instance.showMessageConfirmCancel(
      "Xác nhận",
      "Xác nhận từ chối phiếu này",
      context: Get.context,
    );
    if (result == true) {
      //
      Map<String, dynamic> body = {
        "giaoDichId": giaoDichTemplate.giaoDichId ?? 0,
        "loaiPhieu": giaoDichTemplate.loaiPhieu,
        "tinhTrang": TinhTrangGiaoDich.TuChoi.value,
        "ngay": giaoDichTemplate.ngay?.toIso8601String(),
        "maDonViCapMau": giaoDichTemplate.maDonViCapMau,
        "ghiChu": giaoDichTemplate.ghiChu,
        "createdBy": giaoDichTemplate.createdBy,
        "createdDate": giaoDichTemplate.createdDate?.toIso8601String() ??
            DateTime.now().toIso8601String(),
        "updatedBy": appCenter.authentication?.userCode,
        "updatedDate": DateTime.now().toIso8601String(),
        "isLocked": giaoDichTemplate.isLocked,
        "giaoDichChiTiets": giaoDichTemplate.giaoDichChiTietViews
            ?.map((e) => {
                  "giaoDichChiTietId": e.giaoDichChiTietId ?? 0,
                  "giaoDichId": giaoDichTemplate.giaoDichId ?? 0,
                  "loaiSanPham": e.loaiSanPham,
                  "dienGiai": e.dienGiai,
                  // "giaoDich":"string",
                  "giaoDichCons": e.giaoDichConViews
                      ?.where((ee) => (ee.soLuong ?? 0) > 0)
                      .map(
                        (eee) => {
                          "id": eee.id ?? 0,
                          "maNhomMau": eee.maNhomMau,
                          "soLuong": eee.soLuong,
                          "giaoDichChiTietId": e.giaoDichChiTietId ?? 0,
                          "soLuongDuyet": 0,
                        },
                      )
                      .toList()
                })
            .toList(),
        "donViCapMau": giaoDichTemplate.dmDonViCapMauResponse?.toJson(),
      };
      try {
        AppUtils.instance.showLoading();
        GeneralResponseMap? response;
        response = await appCenter.backendProvider.cancelGiaoDich(
            giaoDichTemplate.giaoDichId?.toString() ?? "", body);
        hideLoading();
        if (response.status == 200) {
          AppUtils.instance.showToast("Từ chối yêu cầu nhượng máu thành công.");

          Get.back(result: {"approve": false});
        } else {
          AppUtils.instance.showToast(
            response.message ?? "",
          );
        }
      } catch (e) {
        // TODO
        log("cancelGiaoDich $e");
      }
      hideLoading();
    }

    ///
    ///
    // try {
    //   showLoading();

    //   final response = await appCenter.backendProvider.loadGiaoDich({
    //     "pageIndex": 1,
    //     "pageSize": 10000,
    //     "ngayTu": startDate.toIso8601String(),
    //     "ngayDen": endDate.toIso8601String(),
    //     "tinhTrangs": type == TinhTrangGiaoDich.DaDuyet
    //         ? [
    //             TinhTrangGiaoDich.DuyetMotPhan.value,
    //             TinhTrangGiaoDich.DaDuyet.value
    //           ]
    //         : [type.value],
    //   });
    //   if (response.status == 200) {
    //     historys = (response.data ?? []);
    //   } else {
    //     historys = [];
    //   }
    //   refresh();
    // } catch (e, s) {
    //   log("onApprove()", error: e, stackTrace: s);
    // }
    // hideLoading();
  }

  String textSearch = "";
  void onSearch(String text) {
    ///
    textSearch = text;
    if (textSearch.trim().isNotEmpty) {
      ///
      historys = _historys
          .where((e) => "${e.giaoDichId}${e.creatorName}${e.ghiChu}"
              .toLowerCase()
              .contains(textSearch.toLowerCase()))
          .toList();
    } else {
      historys = _historys;
    }
    refresh();
  }

  void changeTab({required TinhTrangGiaoDich type}) {
    this.type = type;
    refresh();
    loadData();
  }
}
