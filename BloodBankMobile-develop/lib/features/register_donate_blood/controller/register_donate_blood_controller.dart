import 'dart:convert';
import 'dart:developer';

import 'package:blood_donation/app/config/routes.dart';
import 'package:blood_donation/base/base_view/base_view.dart';
import 'package:blood_donation/utils/extension/datetime_extension.dart';
import 'package:blood_donation/utils/extension/string_ext.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app/app_util/enum.dart';
import '../../../models/answer_question.dart';
import '../../../models/answer_question_detail.dart';
import '../../../models/blood_donation_event.dart';
import '../../../models/district.dart';
import '../../../models/general_response.dart';
import '../../../models/province.dart';
import '../../../models/question.dart';
import '../../../models/register_donation_blood.dart';
import '../../../models/register_donation_blood_response.dart';
import '../../../models/ward.dart';
import '../../../utils/app_utils.dart';
import '../../donation_schedule/presentation/history_dialog_page.dart';

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
  int page = 2;

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
    }
  }

  initProfile() {
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
    phoneNumberController.text =
        appCenter.authentication?.dmNguoiHienMau?.soDT ??
            appCenter.authentication?.phoneNumber ??
            "";
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
    return super.onClose();
  }

  /// Method to hide the ready indicator.
  @override
  Future<void> onReady() async {
    // Implement your hide ready indicator logic here
    checkValidateProfile();

    super.onReady();
  }

  Future<void> checkValidateProfile() async {
    if (appCenter.authentication?.cmnd?.isNotEmpty == true) {
      await init();
      if (event == null) {
        showDialogChooseEvent();
      } else {
        checkValidateEvent();
      }
    } else {
      ///
      await AppUtils.instance.showMessage(
        "Vui lòng nhập cập nhật thông tin cá nhân trước khi đăng ký hiến máu!",
        context: Get.context,
      );
      Get.offNamed(Routes.profile);
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
      checkValidateEvent();
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

  void updateNextPage(int newPage) {
    if (newPage == 3) {
      if (formKey.currentState?.validate() != true) {
        // You can perform actions with the form data here and extract the details
        // print('Name: $_name'); // Print the name
        // print('Email: $_email'); // Print the email
        AppUtils.instance.showMessage(
          "Vui lòng nhập đủ thông tin\nđể tiếp tục!",
          context: Get.context,
        );
        return;
      }
      // if (registerDonationBlood.hoVaTen?.isNotEmpty != true ||
      //     registerDonationBlood.namSinh?.toString().isNotEmpty != true ||
      //     registerDonationBlood.diaChiLienLac?.isNotEmpty != true ||
      //     registerDonationBlood.gioiTinh == null ||
      //     registerDonationBlood.cmnd?.isNotEmpty != true ||
      //     registerDonationBlood.maTinh?.isNotEmpty != true ||
      //     registerDonationBlood.maHuyen?.isNotEmpty != true ||
      //     registerDonationBlood.maXa?.isNotEmpty != true ||
      //     registerDonationBlood.soDT?.isNotEmpty != true) {
      //   AppUtils.instance.showMessage(
      //     "Vui lòng nhập đủ thông tin\nđể tiếp tục!",
      //     context: Get.context,
      //   );
      //   return;
      // }
    }
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
        await AppUtils.instance.showMessage(
          "Đăng ký thành công",
          context: Get.context,
        );

        registerDonationData.surveyQuestions ??=
            registerDonationBlood.surveyQuestions;

        ///
        await createImageQRCode(registerDonationData);

        Get.back();

        ///
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
}
