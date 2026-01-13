import 'dart:developer';

import 'package:blood_donation/base/base_view/base_view.dart';
import 'package:blood_donation/core/localization/app_locale.dart';
import 'package:blood_donation/models/authentication.dart';
import 'package:blood_donation/utils/app_utils.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

import '../../../app/config/routes.dart';
import '../../../models/donation_blood_history_response.dart';
import '../../../models/news_response.dart';
import '../../../models/slide_model.dart';
import '../../../models/system_config.dart';
import '../../../models/user_role.dart';
import '../models/home_category.dart';

class HomeController extends BaseModelStateful {
  RxList<SlideModel> slides = <SlideModel>[].obs;
  RxList<NewsResponse> news = <NewsResponse>[].obs;

  List<HomeCategory> categories = [];
  RefreshController? refreshController =
      RefreshController(initialRefresh: false);

  Future<void> logout() async {
    try {
      final context = Get.context!;
      // Xác nhận trước khi đăng xuất
      var rs = await AppUtils.instance.showMessageConfirm(
        AppLocale.confirmLogout.translate(context),
        AppLocale.logoutMessage.translate(context),
        context: context,
      );

      if (rs == true) {
        showLoading();
        await backendProvider.logout();
        hideLoading();
        AppUtils.instance.showToast(AppLocale.logout.translate(context));
      }
    } catch (e, t) {
      log("logout()", error: e, stackTrace: t);
      hideLoading();
      final context = Get.context;
      if (context != null) {
        AppUtils.instance.showToast(AppLocale.logoutFailed.translate(context));
      }
    }
  }

  @override
  Future<void> onInit() async {
    refreshController = RefreshController(initialRefresh: false);
    initCategory();
    init();

    super.onInit();
  }

  Future<void> onRefresh() async {
    try {
      await _getSystemConfig();
      await _getSlides();
      await _getNews();
      await getHistory();
      await reLoadInformation();
      refresh();
    } catch (e) {
      ///
    }
    refreshController?.refreshCompleted();
  }

  Future<void> reLoadInformation() async {
    ///
    try {
      await appCenter.backendProvider.reLoadInformation();
    } catch (e) {
      // TODO
    }
  }

  List<DonationBloodHistoryResponse> listHistory = [];
  Future<void> getHistory() async {
    ///
    try {
      if (appCenter.authentication?.dmNguoiHienMau != null) {
        final response =
            await appCenter.backendProvider.bloodDonationHistory(body: {
          "pageIndex": 1,
          "pageSize": 100000,
          "nguoiHienMauIds":
              appCenter.authentication?.dmNguoiHienMau?.nguoiHienMauId != null
                  ? [appCenter.authentication?.dmNguoiHienMau?.nguoiHienMauId]
                  : [-1],
        });
        if (response.status == 200) {
          listHistory = response.data ?? [];
          if (listHistory.isNotEmpty) {
            listHistory.sort((a, b) => b.ngayThu!.compareTo(a.ngayThu!));
            appCenter.authentication?.ngayHienMauGanNhat =
                listHistory.firstOrNull?.ngayThu;
            appCenter.authentication?.soLanHienMau = listHistory.length;
            await backendProvider.saveAuthentication(appCenter.authentication!);
          }
        }
      }

      refresh();
    } catch (e, s) {
      log("getHistory()", error: e, stackTrace: s);
    }
  }

  Future<void> onTapSlideItem(SlideModel item) async {
    print(item.path);
    //
    if (item.path == "/dangKyHienMau") {
      if (appCenter.authentication?.role == UserRole.hospital) {
        Get.toNamed(Routes.registerBuyBlood);
      } else {
        Get.toNamed(Routes.registerDonateBlood);
      }
      return;
    }
    if (item.path == "/lichSuHienMau") {
      if (appCenter.authentication?.role == UserRole.hospital) {
        //
      } else {
        Get.toNamed(Routes.bloodHistoryLocations);
      }
      return;
    }
    if (item.path?.contains("/news?id") == true) {
      var id = item.path!.split("=").last;
      var response = await appCenter.backendProvider.getNewsById(id);
      if (response.status == 200) {
        Get.toNamed(Routes.news, arguments: {"news": response.data});
      }
    }
  }

  void initCategory() {
    switch (appCenter.authentication?.role) {
      case UserRole.user:
      case UserRole.userRegister:
        categories = [
          HomeCategory.registerDonateBlood,
          HomeCategory.bloodDonationSchedule,
          HomeCategory.bloodDonationHistory,
          HomeCategory.bloodDonationRegister,
          HomeCategory.questionAndAnswer,
          HomeCategory.feedbackSupport,

          ///test
          // HomeCategory.registerBuyBlood,
          // HomeCategory.historyRegisterBuyBlood,
          // HomeCategory.management,
          // HomeCategory.approveBuyBlood,
        ];
        break;
      case UserRole.admin:
      case UserRole.manager:
        categories = [
          HomeCategory.registerDonateBlood,
          HomeCategory.bloodDonationSchedule,
          HomeCategory.bloodDonationHistory,
          HomeCategory.bloodDonationRegister,
          HomeCategory.homeManagement,
          HomeCategory.approveBuyBlood,
          // HomeCategory.questionAndAnswer,
        ];
        break;
      case UserRole.hospital:
        categories = [
          HomeCategory.registerBuyBlood,
          HomeCategory.historyRegisterBuyBlood,
        ];
        break;
      default:
        categories = [];
    }
  }

  onTapMenu(HomeCategory item) {
    switch (item) {
      case HomeCategory.bloodDonationRegister:
        Get.toNamed(Routes.historyDonateBlood);
        break;
      case HomeCategory.bloodDonationHistory:
        Get.toNamed(Routes.bloodHistoryLocations);
        break;
      case HomeCategory.registerDonateBlood:
        Get.toNamed(Routes.registerDonateBlood);
        break;
      case HomeCategory.registerBuyBlood:
        Get.toNamed(Routes.registerBuyBlood);
        break;
      case HomeCategory.historyRegisterBuyBlood:
        Get.toNamed(Routes.historyRegisterBuyBlood);
        break;
      case HomeCategory.approveBuyBlood:
        Get.toNamed(Routes.approveBuyBlood);
        break;
      case HomeCategory.questionAndAnswer:
        Get.toNamed(Routes.questionAnswer);
        break;
      // case HomeCategory.bloodUsers:
      //   context.router.pushNamed(Routes.bloodUsers);
      //   break;
      case HomeCategory.bloodDonationSchedule:
        Get.toNamed(Routes.history);
        // AutoTabsRouter.of(context).setActiveIndex(
        //     NavigationType.history.index);
        break;
      case HomeCategory.feedbackSupport:
        Get.toNamed(Routes.feedback);
        // AutoTabsRouter.of(context).setActiveIndex(
        //     NavigationType.history.index);
        break;
      case HomeCategory.homeManagement:
        Get.toNamed(Routes.management);
        break;
      default:
    }
  }

  Future<void> init() async {
    try {
      showLoading();
      await _getSystemConfig();
      await _getSlides();
      await _getNews();
      await getHistory();
      await reLoadInformation();
    } catch (e, s) {
      log("init()", error: e, stackTrace: s);
    } finally {
      hideLoading();
    }
  }

  Future<void> _getSlides() async {
    final response = await backendProvider.getSystemSlides();
    if (response.status == 200) {
      final List<SlideModel> slides = [];
      for (var slide in response.data ?? []) {
        try {
          if ((await http.head(Uri.parse(slide.url))).statusCode == 200) {
            slides.add(slide);
          }
        } catch (_) {}
      }
      this.slides.value = slides;
    }
  }

  Future<void> _getNews() async {
    final response = await backendProvider.getNews();
    if (response.status == 200) {
      news.value = response.data ?? [];
    }
  }

// {
//       "key": "MaxTuNgayDenNgayLichLayMau",
//       "value": "30",
//       "note": "Khoảng cách cho phép tìm kiếm từ ngày - đến ngày của đợt hiến máu"
//     },
//     {
//       "key": "PhanTramSoLuongLuuDong",
//       "value": "10",
//       "note": "Phần trăm số lượng được phép đăng ký trên 1 đợt lấy máu lưu động (VD: DotLayMau.SoLuongDuKien = 300 thì max đc 300 + 300 *10/100 = 330)"
//     },
//     {
//       "key": "PhanTramSoLuongTaiCho",
//       "value": "15",
//       "note": "Phần trăm số lượng được phép đăng ký trên 1 đợt lấy máu tại chỗ  (VD: DotLayMau.SoLuongDuKien = 300 thì max đc 300 + 300 *15/100 = 345)"
//     },
//     {
//       "key": "SoNgayChoHienMauLai",
//       "value": "90",
//       "note": "Số ngày cho hiến máu lại kể từ ngày hiến máu gần nhất"
//     },
//     {
//       "key": "SoNgayHienThiLichLayMau",
//       "value": "14",
//       "note": "Số ngày hiển thị lịch lấy máu để cho người hiến máu đăng ký"
//     }
  Future<void> _getSystemConfig() async {
    try {
      var data = await appCenter.backendProvider.getSystemConfig();

      if (data.status == 200) {
        //
        for (SystemConfig sys in data.data ?? []) {
          switch (sys.key) {
            case "MaxTuNgayDenNgayLichLayMau":
              appCenter.maxTuNgayDenNgayLichLayMau = int.parse(
                  sys.value ?? appCenter.maxTuNgayDenNgayLichLayMau.toString());
              break;
            case "PhanTramSoLuongLuuDong":
              appCenter.phanTramSoLuongLuuDong = int.parse(
                  sys.value ?? appCenter.phanTramSoLuongLuuDong.toString());
              break;
            case "PhanTramSoLuongTaiCho":
              appCenter.phanTramSoLuongTaiCho = int.parse(
                  sys.value ?? appCenter.phanTramSoLuongTaiCho.toString());
              break;
            case "SoNgayChoHienMauLai":
              appCenter.soNgayChoHienMauLai = int.parse(
                  sys.value ?? appCenter.soNgayChoHienMauLai.toString());
              break;
            case "SoNgayChoHienTieuCauLai":
              appCenter.soNgayChoHienTieuCauLai = int.parse(
                  sys.value ?? appCenter.soNgayChoHienTieuCauLai.toString());
              break;
            case "SoNgayHienThiLichLayMau":
              appCenter.soNgayHienThiLichLayMau = int.parse(
                  sys.value ?? appCenter.soNgayHienThiLichLayMau.toString());
              break;
            case "ShowQRCodeOnlyDangKyId":
              appCenter.showQRCodeOnlyDangKyId = int.parse(
                  sys.value ?? appCenter.showQRCodeOnlyDangKyId.toString());
              break;
            default:
              break;
          }
        }
      }
    } catch (e) {
      // TODO
    }
  }
}
