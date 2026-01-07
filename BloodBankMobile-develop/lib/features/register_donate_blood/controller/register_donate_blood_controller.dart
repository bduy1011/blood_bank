import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';

import 'package:blood_donation/app/config/routes.dart';
import 'package:blood_donation/base/base_view/base_view.dart';
import 'package:blood_donation/core/localization/app_locale.dart';
import 'package:blood_donation/utils/extension/datetime_extension.dart';
import 'package:blood_donation/utils/extension/string_ext.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app/app_util/enum.dart';
import '../../../models/answer_question.dart';
import '../../../models/answer_question_detail.dart';
import '../../../models/blood_donation_event.dart';
import '../../../models/citizen.dart';
import '../../../models/district.dart';
import '../../../models/general_response.dart';
import '../../../models/province.dart';
import '../../../models/question.dart';
import '../../../models/register_donation_blood.dart';
import '../../../models/register_donation_blood_response.dart';
import '../../../models/ward.dart';
import '../../../utils/app_utils.dart';
import '../../../utils/phone_number_formater.dart';
import '../../donation_schedule/presentation/history_dialog_page.dart';
import '../../scan_qr_code/scan_qr_code_screen.dart';

class RegisterDonateBloodController extends BaseModelStateful {
  BloodDonationEvent? event;
  final Rx<bool?> usetoRegister = (null as bool?).obs;
  List<Province> provinces = [];
  List<Ward> wards = [];
  List<District> districts = [];
  List<Question> questions = [];
  Province? codeProvince;
  District? codeDistrict;
  Ward? codeWard;
  TextEditingController nameController = TextEditingController();
  TextEditingController namSinhController = TextEditingController();
  TextEditingController diaChiController = TextEditingController();
  TextEditingController idCardController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController ngheNghiepController = TextEditingController();
  TextEditingController coQuanController = TextEditingController();

  RegisterDonationBlood registerDonationBlood = RegisterDonationBlood(
    id: 0,
    nguoiHienMauId: 0,
    hoVaTen: '',
    tinhTrang: TinhTrangDangKyHienMau.DaDangKy.value,
    traLoiCauHoiId: 0,
    maDonViCapMau: '1',
    dotLayMauId: 0,
    traLoiCauHoi: AnswerQuestion(
      id: 0,
      ngay: DateTime.now(),
      ghiChu: '',
      traLoiCauHoiChiTiets: [],
    ),
  );
  int page = 2; // Start at form page

  // Digital signature flow variables
  Uint8List? donorSignatureBytes;
  Uint8List? staffSignatureBytes;
  Uint8List? doctorSignatureBytes;
  Uint8List? nurseSignatureBytes;

  // Vital signs
  TextEditingController systolicController = TextEditingController();
  TextEditingController diastolicController = TextEditingController();
  TextEditingController heartRateController = TextEditingController();
  TextEditingController temperatureController = TextEditingController();

  @override
  void onBack() async {
    // TODO: implement onBack
    var result = await AppUtils.instance.showMessageConfirmCancel(
      "Xác nhận",
      "Xác nhận thoát màn hình đăng ký hiến máu",
      context: Get.context,
    );
    if (result == true) {
      Get.back();
    }
  }

  @override
  Future<void> onInit() async {
    ///
    getArgument();
    super.onInit();
  }

  getArgument() {
    if (Get.arguments != null && Get.arguments["event"] != null) {
      event = Get.arguments["event"];
      initProfile();
    } else {
      ///show dialog choose event
      // Vẫn gọi initProfile() để load dữ liệu từ authentication ngay cả khi không có event
      initProfile();
    }
  }

  initProfile() {
    // Reload authentication từ storage để đảm bảo có dữ liệu mới nhất
    try {
      var savedAuth = appCenter.localStorage.authentication;
      if (savedAuth != null) {
        appCenter.setAuthentication(savedAuth);
      }
    } catch (e) {
      // Ignore error
    }
    
    updateProfile(
      date: event?.ngayGio,
      dotLayMauId: event?.dotLayMauId,
      nguoiHienMauId: appCenter.authentication?.dmNguoiHienMau?.nguoiHienMauId,
      soDT: appCenter.authentication?.dmNguoiHienMau?.soDT ??
          appCenter.authentication?.phoneNumber,

      ///
      name: appCenter.authentication?.dmNguoiHienMau?.hoVaTen ??
          appCenter.authentication?.name,
      namSinh: appCenter.authentication?.dmNguoiHienMau?.namSinh?.toIntOrNull,
      ngaySinh: appCenter.authentication?.dmNguoiHienMau?.ngaySinh,
      gioiTinh: appCenter.authentication?.dmNguoiHienMau?.gioiTinh,
      idCard: appCenter.authentication?.cmnd ??
          appCenter.authentication?.dmNguoiHienMau?.cmnd,
      codeProvince: appCenter.authentication?.dmNguoiHienMau?.maTinh,
      nameProvince: appCenter.authentication?.dmNguoiHienMau?.tenTinh,
      codeDistrict: appCenter.authentication?.dmNguoiHienMau?.maHuyen,
      nameDistrict: appCenter.authentication?.dmNguoiHienMau?.tenHuyen,
      codeWard: appCenter.authentication?.dmNguoiHienMau?.maXa,
      nameWard: appCenter.authentication?.dmNguoiHienMau?.tenXa,
      //
      diaChiLienLac: appCenter.authentication?.dmNguoiHienMau?.diaChiLienLac,
      //
      email: appCenter.authentication?.dmNguoiHienMau?.email,
      ngheNghiep: appCenter.authentication?.dmNguoiHienMau?.ngheNghiep,
    );
    
    phoneNumberController.text = PhoneNumberFormatter.formatString(
        (appCenter.authentication?.dmNguoiHienMau?.soDT ??
                appCenter.authentication?.phoneNumber ??
                "")
            .replaceAll(" ", ""));
    idCardController.text = appCenter.authentication?.cmnd ??
        appCenter.authentication?.dmNguoiHienMau?.cmnd ??
        "";
    nameController.text = appCenter.authentication?.dmNguoiHienMau?.hoVaTen ??
        appCenter.authentication?.name ??
        "";

    ///
    if (appCenter.authentication?.dmNguoiHienMau != null) {
      namSinhController.text =
          appCenter.authentication?.dmNguoiHienMau?.namSinh ?? "";
      diaChiController.text =
          appCenter.authentication?.dmNguoiHienMau?.diaChiLienLac ?? "";
      emailController.text =
          appCenter.authentication?.dmNguoiHienMau?.email ?? "";
      ngheNghiepController.text =
          appCenter.authentication?.dmNguoiHienMau?.ngheNghiep ?? "";
    }

    refresh();
  }

  /// Cập nhật các field từ dữ liệu Profile (Họ và tên, CCCD, Số điện thoại)
  void updateFieldsFromProfile({
    required String name,
    required String idCard,
    required String phoneNumber,
  }) {
    // Cập nhật các controller
    nameController.text = name;
    idCardController.text = idCard;
    phoneNumberController.text = PhoneNumberFormatter.formatString(
        phoneNumber.replaceAll(" ", ""));

    // Cập nhật registerDonationBlood
    updateProfile(
      name: name,
      idCard: idCard.replaceAll(" ", ""),
      soDT: phoneNumber.replaceAll(" ", ""),
    );

    refresh();
  }

  @override
  Future<void> onClose() {
    // TODO: implement onClose
    nameController.dispose();
    idCardController.dispose();
    phoneNumberController.dispose();
    namSinhController.dispose();
    diaChiController.dispose();
    emailController.dispose();
    ngheNghiepController.dispose();
    coQuanController.dispose();
    systolicController.dispose();
    diastolicController.dispose();
    heartRateController.dispose();
    temperatureController.dispose();
    return super.onClose();
  }

  /// Method to hide the ready indicator.
  @override
  Future<void> onReady() async {
    log("🟡 [RegisterDonateBloodController] onReady() - Màn hình sẵn sàng");
    // Implement your hide ready indicator logic here
    checkValidateProfile();
    
    // Reload profile data from authentication when screen is ready
    // This ensures data is up-to-date when returning from Profile page
    // Gọi initProfile() ngay cả khi event == null để load dữ liệu từ authentication
    log("🟡 [RegisterDonateBloodController] onReady() - Gọi initProfile() để load dữ liệu từ authentication");
    initProfile();

    super.onReady();
  }

  @override
  void onDidUpdateWidget() {
    log("🟡 [RegisterDonateBloodController] onDidUpdateWidget() - Widget được update");
    // Reload profile data when widget is updated (e.g., when returning from Profile page)
    // This ensures data is up-to-date after updating profile
    // Gọi initProfile() ngay cả khi event == null để load dữ liệu mới từ authentication
    log("🟡 [RegisterDonateBloodController] onDidUpdateWidget() - Gọi initProfile() để reload dữ liệu từ authentication");
    initProfile();
    super.onDidUpdateWidget();
  }

  Future<void> checkValidateProfile() async {
    // Reload authentication from storage to ensure we have latest data
    try {
      var savedAuth = appCenter.localStorage.authentication;
      if (savedAuth != null) {
        appCenter.setAuthentication(savedAuth);
      }
    } catch (e) {
      // Ignore error, continue with current authentication
    }

    // Check if cmnd exists and is not empty
    var cmnd = appCenter.authentication?.cmnd?.trim();

    if (cmnd != null &&
        cmnd.isNotEmpty &&
        (cmnd.length == 9 || cmnd.length == 12)) {
      await init();
      if (event == null) {
        showDialogChooseEvent();
      } else {
        await checkValidateEvent();
        // After validation, stay on current page (form page 2)
      }
    } else {
      ///
      await AppUtils.instance.showMessage(
        AppLocale.pleaseUpdatePersonalInfoBeforeRegister
            .translate(Get.context!),
        context: Get.context,
      );
      // Use Get.toNamed instead of Get.offNamed to allow user to go back
      // Listen result để reload dữ liệu khi quay lại từ Profile
      await Get.toNamed(Routes.profile);
      // Khi quay lại từ Profile, reload dữ liệu từ authentication
      initProfile();
    }
  }

  showDialogChooseEvent() async {
    ///
    var result = await Get.to(
      () => const HistoryDialogPage(),
      fullscreenDialog: true,
    );
    if (result != null) {
      event = result["event"];
      refresh();
      initProfile();
      await checkValidateEvent();
      refresh();
    } else {
      Get.back();
    }
  }

  void updateProfile({
    String? codeProvince,
    String? nameProvince,
    String? codeDistrict,
    String? nameDistrict,
    String? codeWard,
    String? nameWard,
    String? name,
    DateTime? date,
    String? idCard,
    String? soDT,
    int? dotLayMauId,
    int? nguoiHienMauId,
    DateTime? ngaySinh,
    int? namSinh,
    bool? gioiTinh,
    String? diaChiLienLac,
    String? email,
    String? ngheNghiep,
    String? coQuan,
  }) {
    registerDonationBlood = registerDonationBlood.copyWith(
      maTinh: codeProvince ?? registerDonationBlood.maTinh,
      hoVaTen: name ?? registerDonationBlood.hoVaTen,
      cmnd: idCard ?? registerDonationBlood.cmnd,
      tenTinh: nameProvince ?? registerDonationBlood.tenTinh,
      maHuyen: codeDistrict ?? registerDonationBlood.maHuyen,
      tenHuyen: nameDistrict ?? registerDonationBlood.tenHuyen,
      maXa: codeWard ?? registerDonationBlood.maXa,
      tenXa: nameWard ?? registerDonationBlood.tenXa,
      ngay: date ?? registerDonationBlood.ngay,
      soDT: soDT ?? registerDonationBlood.soDT,
      dotLayMauId: dotLayMauId ?? registerDonationBlood.dotLayMauId,
      nguoiHienMauId: nguoiHienMauId ?? registerDonationBlood.nguoiHienMauId,

      ///
      ngaySinh: ngaySinh ?? registerDonationBlood.ngaySinh,
      namSinh: namSinh,
      gioiTinh: gioiTinh,
      diaChiLienLac: diaChiLienLac,

      ///
      email: email,
      ngheNghiep: ngheNghiep,
      coQuan: coQuan,
    );
  }

  Future<void> submitAnswers(
      {required Map<int, bool?> answers, String? note, DateTime? day}) async {
    final answerQuestion =
        registerDonationBlood.traLoiCauHoi ??= AnswerQuestion(
      traLoiCauHoiChiTiets: [],
      id: 0,
      ngay: DateTime.now(),
      ghiChu: '',
    );

    answerQuestion.traLoiCauHoiChiTiets?.clear();
    List<SurveyQuestions> surveyQuestions = [];
    final List<AnswerQuestionDetail> updatedDetails = [];
    for (final question in questions) {
      bool? yesAnswer = registerDonationBlood.gioiTinh == true &&
              question.maleSkip == true
          ? null
          : answers[question.id]; // nếu là Nam thì bỏ qua các câu maleSkip=true
      bool? noAnswer = yesAnswer != null ? !yesAnswer : null;

      DateTime? onDate;
      String? ghiChu;
      if (question.attribute == SurveyQuestionAttribute.InputDate.value) {
        onDate = day;
      } else if (question.attribute ==
          SurveyQuestionAttribute.InputText.value) {
        ghiChu = note ?? '';
      }

      final answerDetail = AnswerQuestionDetail(
          id: question.id ?? 0,
          surveyQuestionId: question.id ?? 0,
          yesAnswer: yesAnswer,
          noAnswer: noAnswer,
          onDate: onDate,
          ghiChu: ghiChu,
          traLoiCauHoiId: question.id ?? 0);

      updatedDetails.add(answerDetail);
      surveyQuestions.add(SurveyQuestions(
          id: question.id ?? 0,
          content: question.content,
          yes: yesAnswer,
          no: noAnswer,
          onDate: onDate,
          notes: ghiChu,
          maleSkip: question.maleSkip));
    }

    if (await checkBeforeSave(updatedDetails) == false) {
      return;
    }

    registerDonationBlood = registerDonationBlood.copyWith(
      traLoiCauHoi: answerQuestion.copyWith(
        answerQuestionDetails: updatedDetails,
      ),
      surveyQuestions: surveyQuestions,
    );
    registerDonateBlood();
  }

  Future<bool> checkBeforeSave(
      List<AnswerQuestionDetail> updatedDetails) async {
    if (updatedDetails.any((e) => e.yesAnswer == true)) {
      var rs = await AppUtils.instance.showMessageConfirmCancel(
        "Xác nhận",
        "Một (hoặc nhiều) câu trả lời đang chọn là 'Có'\r\nBạn có muốn đăng ký ?",
        context: Get.context,
      );
      return rs;
    }
    return true;
  }

  Future<bool> checkValidateByDateEvent() async {
    try {
      showLoading();
      ////
      var dateEvent = event?.ngayGio;
      if (dateEvent == null) {
        return false;
      }
      final response =
          await appCenter.backendProvider.registerDonateBloodHistory(body: {
        "pageIndex": 1,
        "pageSize": 1,
        "ngayTu": DateTime(dateEvent.year, dateEvent.month, dateEvent.day)
            .toIso8601String(),
        "ngayDen":
            DateTime(dateEvent.year, dateEvent.month, dateEvent.day, 23, 59, 59)
                .toIso8601String(),
        "nguoiHienMauIds":
            appCenter.authentication?.dmNguoiHienMau?.nguoiHienMauId != null
                ? [appCenter.authentication?.dmNguoiHienMau?.nguoiHienMauId]
                : [],
        "tinhTrangs": [
          TinhTrangDangKyHienMau.DaDangKy.value,
          TinhTrangDangKyHienMau.DaTiepNhan.value,
        ],
      });
      hideLoading();
      if (response.status == 200) {
        ///
        if (response.data?.isNotEmpty == true) {
          ///
          await AppUtils.instance.showMessage(
            "Bạn đã đăng ký lịch hiến máu (khác) trong ngày. Vui lòng kiểm tra và hủy trước khi đăng ký mới!",
            context: Get.context,
          );
          Get.back();
          return false;
        }
      }
    } catch (e) {
      // TODO
      hideLoading();
    }
    return true;
  }

  Future<bool> checkValidateEvent() async {
    ///
    if (event != null && appCenter.authentication?.cmnd?.isNotEmpty == true) {
      //
      try {
        if (appCenter.authentication?.ngayHienMauGanNhat != null) {
          var khoangCachNgayDuocHienLai =
              event?.loaiMau == LoaiMau.TieuCau.value
                  ? appCenter.soNgayChoHienTieuCauLai
                  : appCenter.soNgayChoHienMauLai;

          var ngayDuocHien = appCenter.authentication!.ngayHienMauGanNhat!
              .add(Duration(days: khoangCachNgayDuocHienLai));
          ngayDuocHien =
              DateTime(ngayDuocHien.year, ngayDuocHien.month, ngayDuocHien.day);

          var ngayHienTai = DateTime.now();
          ngayHienTai =
              DateTime(ngayHienTai.year, ngayHienTai.month, ngayHienTai.day);

          if (ngayDuocHien.isAfter(ngayHienTai)) {
            var loaiHien =
                event?.loaiMau == LoaiMau.TieuCau.value ? "tiểu cầu" : "máu";
            await AppUtils.instance.showMessage(
              "Bạn chưa đủ số ngày quy định ($khoangCachNgayDuocHienLai ngày) để hiến $loaiHien.\nLần hiến $loaiHien gần nhất của bạn là ${appCenter.authentication!.ngayHienMauGanNhat!.ddmmyyyy}",
              context: Get.context,
            );
            Get.back();
            return false;
          }
        }

        // showLoading();
        // final response =
        //     await appCenter.backendProvider.registerDonateBloodHistory(body: {
        //   "pageIndex": 1,
        //   "pageSize": 1,
        //   "dotLayMauIds": [event?.dotLayMauId],
        //   "tinhTrangs": [
        //     TinhTrangDangKyHienMau.DaDangKy.value,
        //     TinhTrangDangKyHienMau.DaTiepNhan.value,
        //   ],
        //   "nguoiHienMauIds":
        //       appCenter.authentication?.dmNguoiHienMau?.nguoiHienMauId != null
        //           ? [appCenter.authentication?.dmNguoiHienMau?.nguoiHienMauId]
        //           : [],
        //   "cmnd":
        //       appCenter.authentication?.dmNguoiHienMau?.nguoiHienMauId != null
        //           ? ""
        //           : appCenter.authentication?.cmnd ?? "",
        // });
        // hideLoading();
        // if (response.status == 200) {
        //   if (response.data?.isNotEmpty == true) {
        //     await AppUtils.instance.showMessage(
        //       "Bạn đã đăng ký đợt hiến máu này!",
        //       context: Get.context,
        //     );
        //     Get.back();
        //     return false;
        //   }
        // }

        var rs = await checkValidateByDateEvent();
        if (!rs) {
          return false;
        }

        ///
        // showLoading();
        // final responseHistory =
        //     await appCenter.backendProvider.bloodDonationHistory(body: {
        //   "pageIndex": 1,
        //   "pageSize": 100000,
        //   "ngayThuTu": DateTime.now()
        //       .subtract(Duration(days: appCenter.soNgayChoHienMauLai))
        //       .toIso8601String(),
        //   "ngayThuDen": event!.ngayGio!.toIso8601String(),
        //   "nguoiHienMauIds":
        //       appCenter.authentication?.dmNguoiHienMau?.nguoiHienMauId != null
        //           ? [appCenter.authentication?.dmNguoiHienMau?.nguoiHienMauId]
        //           : [-1],
        // });
        // hideLoading();
        // if (responseHistory.status == 200) {
        //   if (responseHistory.data?.isNotEmpty == true) {
        //     await AppUtils.instance.showMessage(
        //       "Bạn chưa đủ số ngày quy định (${appCenter.soNgayChoHienMauLai} ngày) để hiến máu. Lần hiến máu gần nhất của bạn là ${responseHistory.data!.firstOrNull?.ngayThu?.ddmmyyyy}",
        //       context: Get.context,
        //     );
        //     Get.back();
        //     return false;
        //   }
        // }
      } catch (e, t) {
        print(e);
        print(t);
        // TODO
        hideLoading();
      }
    }
    return true;
  }

  Future<void> init() async {
    try {
      showLoading();
      final province = await _getProvince();
      final ward = await _getWard();
      final district = await _getDistrict();
      final questions = await getQuestions();
      if (questions.isNotEmpty) {
        this.questions = questions;
      }
      if (province.status == 200) {
        provinces = province.data ?? [];
        if (appCenter.authentication?.dmNguoiHienMau?.maTinh != null) {
          //
          codeProvince = provinces.firstWhereOrNull((e) =>
              e.codeCountry ==
              appCenter.authentication!.dmNguoiHienMau?.maTinh);
          if (codeProvince != null) {
            updateProfile(
              codeProvince: codeProvince?.codeProvince,
              nameProvince: codeProvince?.nameProvince,
            );
          }
        }
      }
      if (district.status == 200) {
        districts = district.data ?? [];
        if (appCenter.authentication?.dmNguoiHienMau?.maHuyen != null) {
          //
          codeDistrict = districts.firstWhereOrNull((e) =>
              e.codeDistrict ==
              appCenter.authentication!.dmNguoiHienMau?.maHuyen);
          if (codeDistrict != null) {
            updateProfile(
              codeDistrict: codeDistrict?.codeDistrict,
              nameDistrict: codeDistrict?.nameDistrict,
            );
          }
        }
      }
      if (ward.status == 200) {
        wards = ward.data ?? [];
        if (appCenter.authentication?.dmNguoiHienMau?.maXa != null) {
          //
          codeWard = wards.firstWhereOrNull((e) =>
              e.codeWards == appCenter.authentication!.dmNguoiHienMau?.maXa);
          if (codeWard != null) {
            updateProfile(
              codeWard: codeWard?.codeWards,
              nameWard: codeWard?.nameWards,
            );
          }
        }
      }
      refresh();
    } catch (e, s) {
      log("init()", error: e, stackTrace: s);
    } finally {
      hideLoading();
    }
  }

  final formKey = GlobalKey<FormState>();

  // TODO: Remove bypass when ready for production
  static const bool bypassValidation = true; // Set to false when ready
  static const bool bypassToSignature =
      true; // Set to true to jump directly to signature page (page 4)

  void updateNextPage(int newPage) {
    page = newPage;
    refresh();
  }

  void updatePrevPage(int newPage) {
    page = newPage;
    refresh();
  }

  Future<RegisterDonationBloodResponse?> registerDonateBlood() async {
    try {
      showLoading();
      final response = await appCenter.backendProvider.registerDonateBlood(
        body: registerDonationBlood.toJson(),
      );
      if (response.status == 200) {
        var registerDonationData = response.data!;
        hideLoading();

        // Update registerDonationBlood with the response data (including ID)
        registerDonationBlood = registerDonationData;
        registerDonationData.surveyQuestions ??=
            registerDonationBlood.surveyQuestions;

        await AppUtils.instance.showMessage(
          "Đăng ký thành công",
          context: Get.context,
        );

        // Go back after successful registration
        Get.back();
      } else {
        AppUtils.instance.showToast(
          response.message ?? "",
        );
      }
      return response;
    } catch (e, s) {
      log("registerDonateBlood()", error: e, stackTrace: s);
    } finally {
      hideLoading();
    }
    return null;
  }

  Future<void> createImageQRCode(RegisterDonationBlood dataRegister) async {
    ////
    var data = jsonEncode(dataRegister.toJsonQrCode());
    log(data);
    await AppUtils.instance.showQrCodeImage(
      id: dataRegister.id?.toString() ?? "0",
      data: data,
      nameBloodDonation: event!.ten!,
      timeBloodDonation: event!.ngayGio!,
      idBloodDonation: event!.dotLayMauId!,
      idRegister: dataRegister.id!,
    );
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

  Future<List<Question>> getQuestions() async {
    return appCenter.backendProvider.getQuestions();
  }

  Future<void> completeBloodDonation() async {
    try {
      if (registerDonationBlood.id == null || registerDonationBlood.id == 0) {
        AppUtils.instance.showToast(
          AppLocale.errorOccurredPleaseRetry.translate(Get.context!),
        );
        return;
      }

      showLoading();

      // Update status to "Đã hiến máu"
      final updatedData = registerDonationBlood.copyWith(
        tinhTrang: TinhTrangDangKyHienMau.DaHienMau.value,
      );

      final response =
          await appCenter.backendProvider.cancelRegisterDonateBlood(
        body: updatedData.toJson(),
        id: registerDonationBlood.id!,
      );

      if (response.status == 200) {
        // Send thank you letter
        try {
          await appCenter.backendProvider.getHTMLLetter(
            registerDonationBlood.id.toString(),
            'thank_you',
          );
        } catch (e) {
          log("Error sending thank you letter: $e");
          // Continue even if thank you letter fails
        }

        hideLoading();

        await AppUtils.instance.showMessage(
          AppLocale.bloodDonationCompleted.translate(Get.context!),
          context: Get.context,
        );

        Get.back();
      } else {
        hideLoading();
        AppUtils.instance.showToast(
          response.message ??
              AppLocale.updateStatusFailed.translate(Get.context!),
        );
      }
    } catch (e, s) {
      log("completeBloodDonation()", error: e, stackTrace: s);
      hideLoading();
      AppUtils.instance.showToast(
        AppLocale.errorOccurredPleaseRetry.translate(Get.context!),
      );
    }
  }

  // Quét QR code từ căn cước công dân để map dữ liệu vào form đăng ký hiến máu
  Future<void> scanQRCodeForRegistration(BuildContext context) async {
    try {
      await Get.to(
        () => ScanQrCodeScreen(
          title: AppLocale.scanQRCCCD.translate(context),
          onScan: (code) async {
            try {
              // Parse QR code thành Citizen model
              final citizen = Citizen.fromQRCode(code);

              // Validate thông tin
              if (!citizen.isValid()) {
                final errors = citizen.getValidationErrors();
                AppUtils.instance.showMessage(
                  errors.join("\n"),
                  context: Get.context,
                );
                return false;
              }

              // Map dữ liệu vào form
              // CCCD/Căn cước
              idCardController.text = citizen.idCard;
              updateProfile(idCard: citizen.idCard);

              // Họ và tên
              nameController.text = citizen.fullName;
              updateProfile(name: citizen.fullName);

              // Năm sinh (từ ngày sinh ddmmyyyy)
              if (citizen.dateOfBirth != null && citizen.isValidDateOfBirth()) {
                final dateOfBirth = citizen.getDateOfBirthAsDateTime();
                if (dateOfBirth != null) {
                  namSinhController.text = dateOfBirth.year.toString();
                  updateProfile(
                    namSinh: dateOfBirth.year,
                    ngaySinh: dateOfBirth,
                  );
                }
              }

              // Giới tính
              if (citizen.gender != null) {
                final isMale = citizen.gender!.toLowerCase().contains("nam");
                updateProfile(gioiTinh: isMale);
              }

              // Địa chỉ
              if (citizen.address != null && citizen.address!.isNotEmpty) {
                diaChiController.text = citizen.address!;
                updateProfile(diaChiLienLac: citizen.address);
              }

              // Hiển thị toast thành công
              AppUtils.instance.showToast(
                AppLocale.qrCodeReadSuccess.translate(context),
              );

              refresh();
              return true;
            } catch (e) {
              log("scanQRCodeForRegistration()", error: e);
              AppUtils.instance.showToast(
                AppLocale.qrCodeReadError.translate(context),
              );
              return false;
            }
          },
        ),
      );
    } catch (e, t) {
      log("scanQRCodeForRegistration()", error: e, stackTrace: t);
      AppUtils.instance.showToast(
        AppLocale.qrScanError.translate(context),
      );
    }
  }
}
