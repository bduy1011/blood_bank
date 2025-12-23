import 'dart:developer';

import 'package:blood_donation/app/app_util/enum.dart';
import 'package:blood_donation/base/base_view/base_view.dart';
import 'package:blood_donation/models/giao_dich_template.dart';
import 'package:blood_donation/utils/extension/datetime_extension.dart';
import 'package:get/get.dart';

import '../../../app/config/routes.dart';
import '../../../models/cau_hinh_ton_kho_view.dart';
import '../../../models/dm_don_vi_cap_mau_response.dart';
import '../../../models/general_response.dart';
import '../../../models/giaodich_response.dart';
import '../../../utils/app_utils.dart';

class RegisterBuyBloodController extends BaseModelStateful {
  GiaoDichTemplate? _giaoDichTemplate;
  GiaoDichTemplate? giaoDichTemplate;
  List<DmDonViCapMauResponse>? dmDonViCapMaus;
  DateTime date = DateTime.now();
  DmDonViCapMauResponse? dmDonViCapMauCurrent;
  CauHinhTonKho? cauHinhTonKho;
  GiaodichResponse? giaodichResponse;

  bool get isUpdate =>
      giaodichResponse == null ||
      giaodichResponse?.tinhTrang == TinhTrangGiaoDich.ChoXacNhan.value;

  String ghichu = "";

  RxInt total = 0.obs;
  RxInt totalDuyet = 0.obs;

  ///
  int getTotal() {
    var t = giaoDichTemplate?.giaoDichChiTietViews?.fold(
            0,
            (tt, giaoDichChiTiet) =>
                (tt) + (getTotalDetail(giaoDichChiTiet))) ??
        0;
    total.value = t;
    return t;
  }

  int getTotalDuyet() {
    var t = giaoDichTemplate?.giaoDichChiTietViews?.fold(
            0,
            (tt, giaoDichChiTiet) =>
                (tt) + (getTotalDetailDuyet(giaoDichChiTiet))) ??
        0;
    totalDuyet.value = t;
    return t;
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

  @override
  Future<void> onInit() async {
    ///
    getArgument();

    super.onInit();
  }

  @override
  Future<void> onReady() async {
    ///
    checkInfo();
    super.onReady();
  }

  bool checkInfo() {
    if (appCenter.authentication?.cmnd?.isNotEmpty == true) {
      init();
      return true;
    } else {
      ///
      AppUtils.instance
          .showMessage(
        "Vui lòng nhập cập nhật thông tin cá nhân trước khi tạo yêu cầu nhượng máu!",
        context: Get.context,
      )
          .then((v) {
        Get.offNamed(Routes.profile);
      });
      return false;
    }
  }

  void getArgument() {
    try {
      giaodichResponse = Get.arguments["giaodichResponse"] as GiaodichResponse?;
      if (giaodichResponse != null) {
        date = giaodichResponse?.ngay ?? DateTime.now();
        ghichu = giaodichResponse?.ghiChu ?? "";
      }
    } catch (e) {
      // TODO
    }
  }

  Future<void> getGiaoDichById() async {
    ///
    try {
      final response = await appCenter.backendProvider
          .getGiaoDichById(giaodichResponse?.giaoDichId?.toString() ?? "");
      if (response.status == 200) {
        //merge
        _giaoDichTemplate?.giaoDichId = response.data?.giaoDichId;
        _giaoDichTemplate?.loaiPhieu = response.data?.loaiPhieu;
        _giaoDichTemplate?.ngay = response.data?.ngay;
        _giaoDichTemplate?.tinhTrang = response.data?.tinhTrang;
        _giaoDichTemplate?.tinhTrangDescription =
            response.data?.tinhTrangDescription;
        _giaoDichTemplate?.isLocked = response.data?.isLocked;
        _giaoDichTemplate?.giaoDichChiTietViews?.forEach((element) {
          var giaoDichChiTiet = response.data?.giaoDichChiTietViews
              ?.firstWhereOrNull(
                  (element1) => element1.loaiSanPham == element.loaiSanPham);
          if (giaoDichChiTiet != null) {
            element.giaoDichConViews?.forEach((element2) {
              var giaoDichCon = giaoDichChiTiet.giaoDichConViews
                  ?.firstWhereOrNull(
                      (element3) => element3.maNhomMau == element2.maNhomMau);

              element.giaoDichChiTietId = giaoDichChiTiet.giaoDichChiTietId;
              element.giaoDichId = giaoDichChiTiet.giaoDichId;
              if (giaoDichCon != null) {
                element2.soLuong = giaoDichCon.soLuong;
                element2.soLuongDuyet = giaoDichCon.soLuongDuyet;
                element2.id = giaoDichCon.id;
                element2.giaoDichChiTietId = giaoDichCon.giaoDichChiTietId;
                element2.daDuyet = giaoDichCon.daDuyet;
              }
            });
          }
        });
      }
    } catch (e) {
      // TODO
    }
  }

  Future<void> init() async {
    try {
      showLoading();
      // await initBloodType();

      await initDmDonViCapMau();
      await initGiaoDichTemplate();
      if (giaodichResponse != null) {
        await getGiaoDichById();
      }
      await initTonMau();
      getTotal();
      getTotalDuyet();
      refresh();
    } catch (e, s) {
      hideLoading();
      log("init()", error: e, stackTrace: s);
    }
    hideLoading();
  }

  Future<void> initGiaoDichTemplate() async {
    try {
      final response = await appCenter.backendProvider.getTemplateNhuongMau();
      if (response.status == 200) {
        _giaoDichTemplate = response.data;
      }
    } catch (e) {
      // TODO
    }
  }

  Future<void> initTonMau() async {
    try {
      if (isUpdate == false) {
        initOrderView();
        return;
      }
      final response = await appCenter.backendProvider.getTonKho({
        "pageIndex": 1,
        "pageSize": 10000,
        "ngayTu": date.dateYYYYMMddString,
        "ngayDen": date.dateYYYYMMddString,
        "loaiSanPham": 1
      });
      if (response.status == 200) {
        var ls = response.data ?? [];
        if (ls.isNotEmpty) {
          ls.sort((b, a) => (a.id ?? 0).compareTo(b.id ?? 0));

          final response2 = await appCenter.backendProvider
              .getTonKhoById("${ls.firstOrNull?.id ?? 0}");

          if (response2.status == 200) {
            cauHinhTonKho = response2.data;

            ///check validate ton mau
            if (cauHinhTonKho != null) {
              ///có tồn trong ngày
              ///remove item hết tồn
              for (CauHinhTonKhoChiTietViews element
                  in cauHinhTonKho?.cauHinhTonKhoChiTietViews ?? []) {
                element.cauHinhTonKhoChiTietConViews = element
                    .cauHinhTonKhoChiTietConViews
                    ?.where((e) =>
                        (e.soLuong ?? 0) - (e.soLuongDuocBooking ?? 0) > 0)
                    .toList();
              }
              if (cauHinhTonKho?.cauHinhTonKhoChiTietViews?.firstWhereOrNull(
                      (e) =>
                          e.cauHinhTonKhoChiTietConViews?.isNotEmpty == true) ==
                  null) {
                AppUtils.instance.showMessage(
                  "Hiện không có tồn trong ngày ${date.dateTimeString}, vui lòng chọn ngày khác!",
                  context: Get.context,
                );
                cauHinhTonKho = null;
                return;
              }
              mergeTonKho();
            } else {
              ///không tồn trong ngày
              AppUtils.instance.showMessage(
                "Hiện không có tồn trong ngày ${date.dateTimeString}, vui lòng chọn ngày khác!",
                context: Get.context,
              );
            }
          }
        } else {
          ///không tồn trong ngày
          AppUtils.instance.showMessage(
            "Hiện không có tồn trong ngày ${date.dateTimeString}, vui lòng chọn ngày khác!",
            context: Get.context,
          );
        }
      }
    } catch (e) {
      // TODO
      AppUtils.instance.showMessage(
        "Lỗi lấy tồn trong ngày ${date.dateTimeString}, vui lòng liên hệ Kỹ thuật viên!",
        context: Get.context,
      );
    }
  }

  void initOrderView() {
    giaoDichTemplate = _giaoDichTemplate;
    giaoDichTemplate?.giaoDichChiTietViews =
        _giaoDichTemplate?.giaoDichChiTietViews?.where((e) {
      var giaoDichCon =
          e.giaoDichConViews?.firstWhereOrNull((ee) => (ee.soLuong ?? 0) > 0);
      return giaoDichCon != null;
    }).toList();
    //
  }

  void mergeTonKho() {
    ///reset
    for (GiaoDichChiTietViews element
        in _giaoDichTemplate?.giaoDichChiTietViews ?? []) {
      //
      for (GiaoDichConViews element2 in element.giaoDichConViews ?? []) {
        ///
        element2.soLuongTon = 0;
      }
    }

    ///
    _giaoDichTemplate?.giaoDichChiTietViews?.forEach((element) {
      var tonKhoChiTiet = cauHinhTonKho?.cauHinhTonKhoChiTietViews
          ?.firstWhereOrNull(
              (element1) => element1.loaiSanPham == element.loaiSanPham);

      ///
      if (tonKhoChiTiet != null) {
        for (GiaoDichConViews element2 in element.giaoDichConViews ?? []) {
          var tonKhoChiTietCon = tonKhoChiTiet.cauHinhTonKhoChiTietConViews
              ?.firstWhereOrNull(
                  (element3) => element3.maNhomMau == element2.maNhomMau);

          if (tonKhoChiTietCon != null) {
            element2.soLuongTon = (tonKhoChiTietCon.soLuong ?? 0) -
                (tonKhoChiTietCon.soLuongDuocBooking ?? 0);
          }
        }
        element.giaoDichConViews = element.giaoDichConViews
            ?.where((e) => (e.soLuongTon ?? 0) > 0)
            .toList();
      }
    });

    ///remove giaoDich not exists tồn
    giaoDichTemplate = _giaoDichTemplate;
    giaoDichTemplate?.giaoDichChiTietViews =
        giaoDichTemplate?.giaoDichChiTietViews?.where((e) {
      var giaoDichCon = e.giaoDichConViews
          ?.where((ee) => (ee.soLuongTon ?? 0) > 0)
          .firstOrNull;
      return giaoDichCon != null;
    }).toList();
  }

  bool checkAvailableTonKho() {
    if (cauHinhTonKho == null) {
      AppUtils.instance.showMessage(
        "Hiện không có tồn trong ngày ${date.dateTimeString}, Vui lòng chọn ngày khác!",
        context: Get.context,
      );
      return false;
    }
    var message = "";
    for (GiaoDichChiTietViews element
        in giaoDichTemplate?.giaoDichChiTietViews ?? []) {
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

  Future<void> initDmDonViCapMau() async {
    try {
      final response = await appCenter.backendProvider.getDmDonViCapMau();
      if (response.status == 200) {
        dmDonViCapMaus = response.data;
        if (giaodichResponse != null) {
          dmDonViCapMauCurrent = dmDonViCapMaus?.firstWhereOrNull(
              (element) => element.maDonVi == giaodichResponse?.maDonViCapMau);
        } else {
          if ((dmDonViCapMaus?.length ?? 0) <= 1) {
            dmDonViCapMauCurrent = dmDonViCapMaus?.firstOrNull;
          }
        }
      }
    } catch (e) {
      // TODO
    }
  }

  Future<void> onSubmit() async {
    ///
    //
    if (dmDonViCapMauCurrent == null) {
      AppUtils.instance.showToast("Vui lòng chọn đơn vị cấp máu.");
      return;
    }
    if (!checkAvailableTonKho()) {
      return;
    }

    Map<String, dynamic> body = {
      "giaoDichId": giaoDichTemplate?.giaoDichId ?? 0,
      "loaiPhieu": giaoDichTemplate?.loaiPhieu,
      "tinhTrang": giaoDichTemplate?.tinhTrang,
      "ngay": date.toIso8601String(),
      "maDonViCapMau": dmDonViCapMauCurrent?.maDonVi,
      "ghiChu": ghichu,
      "createdBy":
          giaoDichTemplate?.createdBy ?? appCenter.authentication?.cmnd,
      "createdDate": giaoDichTemplate?.createdDate?.toIso8601String() ??
          DateTime.now().toIso8601String(),
      "updatedBy":
          (giaodichResponse != null) ? appCenter.authentication?.cmnd : null,
      "updatedDate":
          (giaodichResponse != null) ? DateTime.now().toIso8601String() : null,
      "isLocked": giaoDichTemplate?.isLocked,
      "giaoDichChiTiets": giaoDichTemplate?.giaoDichChiTietViews
          ?.map((e) => {
                "giaoDichChiTietId": e.giaoDichChiTietId ?? 0,
                "giaoDichId": giaoDichTemplate?.giaoDichId ?? 0,
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
      "donViCapMau": dmDonViCapMauCurrent?.toJson(),
    };
    try {
      AppUtils.instance.showLoading();
      GeneralResponseMap? response;
      if (giaodichResponse != null) {
        response = await appCenter.backendProvider.updateGiaoDich(
            giaodichResponse?.giaoDichId?.toString() ?? "", body);
      } else {
        response = await appCenter.backendProvider.createGiaoDich(body);
      }
      hideLoading();
      if (response.status == 200) {
        AppUtils.instance.showToast(
          giaodichResponse != null
              ? "Cập nhật yêu cầu nhượng máu thành công."
              : "Tạo yêu cầu nhượng máu thành công.",
        );
        for (GiaoDichChiTietViews element
            in giaoDichTemplate?.giaoDichChiTietViews ?? []) {
          //
          for (GiaoDichConViews element1 in element.giaoDichConViews ?? []) {
            element1.soLuong = 0;
          }
        }
        if (giaodichResponse != null) {
          Get.back(result: {"isUpdate": true});
        } else {
          Get.offNamed(Routes.historyRegisterBuyBlood);
        }
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
