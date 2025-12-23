import 'package:blood_donation/app/config/routes.dart';
import 'package:blood_donation/models/authentication.dart';
import 'package:blood_donation/models/user_role.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:injectable/injectable.dart';

import '../../core/backend/backend_provider.dart';
import '../../core/storage/local_storage.dart';
import '../config/app_router.dart';
import '../theme/themes.dart';
import 'app_state.dart';

@singleton
class AppCenter {
// extends BaseCubit<AppState> {
  // AppCubit()
  //     : super(AppState(
  //           status: PageStatus.loading, appTheme: AppThemeData.light()));
  AppState state =
      AppState(status: PageStatus.loading, appTheme: AppThemeData.light());
  final AppRouter appRouter = AppRouter();
  Function()? _onAuthentication;
  LocalStorage get localStorage => LocalStorage();
  BackendProvider get backendProvider => BackendProvider();

  Authentication? authentication;

  ///system config
  int maxTuNgayDenNgayLichLayMau = 30;
  int phanTramSoLuongLuuDong = 10;
  int phanTramSoLuongTaiCho = 15;
  int soNgayChoHienMauLai = 90;
  int soNgayChoHienTieuCauLai = 14;
  int soNgayHienThiLichLayMau = 14;
  int showQRCodeOnlyDangKyId = 0;

  void checkAuthentication({required BuildContext context}) async {
    // Khôi phục logic gốc - chỉ bypass khi nhấn nút đăng nhập
    if (backendProvider.isAuthenticated) {
      state = state.copyWith(status: PageStatus.idle);
    } else {
      ///refresh Token
      if (authentication?.accessToken?.isNotEmpty == true) {
        var token = await BackendProvider().refreshToken();
        if (token?.isNotEmpty == true) {
          authentication?.accessToken = token;
          localStorage.saveAuthentication(authentication: authentication!);
          return;
        }
      }

      ///
      await localStorage.clearAuthentication();
      Future.delayed(const Duration(milliseconds: 500), () {
        {
          Get.offAllNamed(Routes.login);
        }
      });
    }
  }

  @disposeMethod
  void dispose() {
    // logic to dispose instance
    if (_onAuthentication != null) {
      backendProvider.isAuthenticatedNotifier
          .removeListener(_onAuthentication!);
    }
  }

  void init({required BuildContext context}) async {
    authentication = localStorage.authentication;
    _onAuthentication = () {
      checkAuthentication(context: context);
    };
    backendProvider.isAuthenticatedNotifier.addListener(_onAuthentication!);
    checkAuthentication(context: context);
  }

  void setAuthentication(Authentication? authen) {
    authentication = authen;
  }
}
