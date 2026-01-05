import 'dart:developer';

import 'package:blood_donation/app/app_util/app_center.dart';
import 'package:blood_donation/base/base_view/base_view.dart';
import 'package:blood_donation/core/backend/backend_provider.dart';
import 'package:blood_donation/core/localization/app_locale.dart';
import 'package:blood_donation/models/authentication.dart';
import 'package:blood_donation/utils/app_utils.dart';
import 'package:blood_donation/utils/biometric_auth_service.dart';
import 'package:blood_donation/utils/secure_token_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../app/config/routes.dart';

class LoginController extends BaseModelStateful {
  ///
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  SharedPreferences? prefs;

  ///

  @override
  Future<void> onClose() async {
    // Implement your hide dispose indicator

    ///
    usernameController.dispose();
    passwordController.dispose();

    super.onClose();
  }

  @override
  Future<void> onInit() async {
    prefs = await SharedPreferences.getInstance();
    initUserName();

    ///
    super.onInit();
  }

  Future<void> initUserName() async {
    ///
    var userName = prefs?.getString("userName");
    if (userName?.isNotEmpty == true) {
      usernameController.text = userName ?? "";
    }
  }

  Future<void> setUserName() async {
    ///
    prefs?.setString("userName", usernameController.text);
  }

  final SecureTokenService _tokenService = SecureTokenService();
  final BackendProvider _backendProvider = BackendProvider();
  final AppCenter _appCenter = GetIt.instance<AppCenter>();

  /// Lưu tokens vào secure storage sau khi login thành công
  /// 
  /// [authentication]: Authentication object từ server (có accessToken)
  /// [refreshToken]: Refresh token từ server (optional, có thể null)
  Future<void> saveTokensToSecureStorage({
    required Authentication authentication,
    String? refreshToken,
  }) async {
    try {
      if (authentication.accessToken != null && authentication.accessToken!.isNotEmpty) {
        await _tokenService.saveTokens(
          accessToken: authentication.accessToken!,
          refreshToken: refreshToken,
        );
        log("Tokens saved to secure storage successfully");
      }
    } catch (e) {
      log("saveTokensToSecureStorage error: $e");
    }
  }

  /// Kiểm tra xem có tokens đã lưu trong secure storage không
  Future<bool> hasStoredTokens() async {
    return await _tokenService.hasTokens();
  }

  /// Xóa tokens khỏi secure storage (khi logout)
  Future<void> clearStoredTokens() async {
    await _tokenService.clearTokens();
  }

  /// Đăng nhập bằng biometric (FaceID/Fingerprint)
  /// 
  /// Flow:
  /// 1. Xác thực bằng biometric (local_auth.authenticate())
  /// 2. Lấy tokens từ secure storage
  /// 3. Kiểm tra access token có hết hạn không
  /// 4. Nếu hết hạn → Refresh token
  /// 5. Set authentication và vào app
  Future<void> loginWithBiometric(BuildContext context) async {
    try {
      final biometricService = BiometricAuthService();
      
      // Bước 1: Kiểm tra xem có tokens đã lưu không (chỉ để biết có cần tạo mock token không)
      final hasTokens = await hasStoredTokens();
      
      // Bước 2: Gọi authenticate trực tiếp - để local_auth tự xử lý và hiển thị dialog
      // Không check isAvailable() trước vì có thể chặn dialog hiển thị
      // local_auth sẽ tự hiển thị dialog Face ID/vân tay và xử lý lỗi nếu có
      final didAuthenticate = await biometricService.authenticate(
        reason: AppLocale.biometricAuthReason.translate(context),
        context: context,
      );

      // Chỉ báo lỗi nếu user cancel hoặc fail, không báo nếu chưa kịp hiển thị dialog
      if (!didAuthenticate) {
        // Không hiển thị toast ngay, vì có thể user chỉ cancel
        // Chỉ hiển thị nếu thực sự có lỗi (sẽ được xử lý ở catch)
        return;
      }

      log("Biometric authentication successful");
      // Hiển thị loading sau khi xác thực thành công
      AppUtils.instance.showLoading();

      // Bước 4: Nếu chưa có tokens (test mode), tự động tạo mock token
      if (!hasTokens) {
        log("No tokens found, creating mock token for test mode");
        try {
          // Tạo mock authentication để test
          final mockAuth = Authentication(
            accessToken: "mock_token_biometric_${DateTime.now().millisecondsSinceEpoch}",
            userCode: "test_user_biometric",
            name: "Test User (Biometric)",
            appRole: 30,
            status: 1,
          );
          
          // Lưu authentication vào localStorage
          await _appCenter.localStorage.saveAuthentication(authentication: mockAuth);
          _appCenter.setAuthentication(mockAuth);
          _backendProvider.notifyAuthentication(isAuthenticated: true);
          
          // Lưu tokens vào secure storage
          await saveTokensToSecureStorage(
            authentication: mockAuth,
            refreshToken: null,
          );
          
          log("Mock token created and saved successfully");
          AppUtils.instance.hideLoading();
          AppUtils.instance.showToast(AppLocale.biometricAuthSuccess.translate(context));
          
          // Vào app
          autoGotoHomePage(context);
          return;
        } catch (e, t) {
          log("Error creating mock token", error: e, stackTrace: t);
          AppUtils.instance.hideLoading();
          AppUtils.instance.showToast('Lỗi khi tạo token. Vui lòng thử lại.');
          return;
        }
      }

      // Bước 5: Lấy tokens từ secure storage (nếu đã có)
      log("Getting access token from secure storage...");
      final accessToken = await _tokenService.getAccessToken();
      if (accessToken == null || accessToken.isEmpty) {
        log("Access token is null or empty");
        AppUtils.instance.hideLoading();
        AppUtils.instance.showToast('Không tìm thấy thông tin đăng nhập. Vui lòng đăng nhập lại.');
        return;
      }
      log("Access token retrieved: ${accessToken.substring(0, accessToken.length > 20 ? 20 : accessToken.length)}...");

      // Bước 6: Kiểm tra token có hết hạn không
      final isExpired = await _tokenService.isAccessTokenExpired();
      
      String? finalAccessToken = accessToken;
      
      // Kiểm tra nếu là mock token (test mode)
      final isMockToken = accessToken.startsWith('mock_token_');
      
      if (isExpired && !isMockToken) {
        // Bước 7: Refresh token nếu hết hạn (chỉ với token thật)
        try {
          final newToken = await _backendProvider.refreshToken();
          if (newToken != null && newToken.isNotEmpty) {
            finalAccessToken = newToken;
            // Cập nhật token mới vào secure storage
            await _tokenService.updateAccessToken(newToken);
            log("Token refreshed successfully");
          } else {
            // Refresh thất bại, cần đăng nhập lại
            await clearStoredTokens();
            AppUtils.instance.hideLoading();
            AppUtils.instance.showToast(
              'Phiên đăng nhập đã hết hạn. Vui lòng đăng nhập lại.',
            );
            return;
          }
        } catch (e) {
          log("refreshToken error: $e");
          // Refresh thất bại, cần đăng nhập lại
          await clearStoredTokens();
          AppUtils.instance.hideLoading();
          AppUtils.instance.showToast(
            'Không thể làm mới token. Vui lòng đăng nhập lại.',
          );
          return;
        }
      }

      // Bước 8: Load thông tin user từ server (hoặc mock trong test mode)
      try {
        // Trong test mode (chưa có API), luôn dùng mock authentication
        // Khi có API thật, sẽ kiểm tra isMockToken để quyết định
        if (isMockToken) {
          log("Using mock token, creating mock authentication");
          // Test mode: Tạo mock authentication từ token
          // Parse userCode từ mock token nếu có thể
          String userCode = "test_user";
          String name = "Test User";
          
          // Thử lấy từ localStorage nếu có
          final existingAuth = _appCenter.localStorage.authentication;
          if (existingAuth != null) {
            userCode = existingAuth.userCode ?? userCode;
            name = existingAuth.name ?? name;
          }
          
          final mockAuth = Authentication(
            accessToken: finalAccessToken,
            userCode: userCode,
            name: name,
            appRole: 30,
            status: 1,
          );
          
          // Lưu authentication
          await _appCenter.localStorage.saveAuthentication(authentication: mockAuth);
          _appCenter.setAuthentication(mockAuth);
          _backendProvider.notifyAuthentication(isAuthenticated: true);
          
          log("Mock authentication set successfully");
          AppUtils.instance.hideLoading();
          AppUtils.instance.showToast(AppLocale.biometricAuthSuccess.translate(context));
          
          // Vào app
          autoGotoHomePage(context);
        } else {
          // Production mode: Load từ server
          // Tuy nhiên, nếu chưa có API, fallback về mock để test
          log("Non-mock token detected, attempting to load from server...");
          try {
            // Tạo authentication object từ token
            final auth = Authentication(
              accessToken: finalAccessToken,
            );
            
            // Set authentication tạm thời để có thể gọi API
            _appCenter.setAuthentication(auth);
            _backendProvider.notifyAuthentication(isAuthenticated: true);
            
            // Load thông tin đầy đủ từ server
            final fullAuth = await _backendProvider.reLoadInformation();
            if (fullAuth != null) {
              // Lưu authentication đầy đủ
              await _appCenter.localStorage.saveAuthentication(authentication: fullAuth);
              _appCenter.setAuthentication(fullAuth);
              _backendProvider.notifyAuthentication(isAuthenticated: true);
              
              log("User information loaded from server successfully");
              AppUtils.instance.hideLoading();
              AppUtils.instance.showToast(AppLocale.biometricAuthSuccess.translate(context));
              
              // Vào app
              autoGotoHomePage(context);
            } else {
              throw Exception("Failed to load user information from server");
            }
          } catch (apiError) {
            // Nếu API không có hoặc lỗi, fallback về mock mode để test
            log("API call failed, falling back to mock mode: $apiError");
            String userCode = "test_user";
            String name = "Test User";
            
            final existingAuth = _appCenter.localStorage.authentication;
            if (existingAuth != null) {
              userCode = existingAuth.userCode ?? userCode;
              name = existingAuth.name ?? name;
            }
            
            final mockAuth = Authentication(
              accessToken: finalAccessToken,
              userCode: userCode,
              name: name,
              appRole: 30,
              status: 1,
            );
            
            await _appCenter.localStorage.saveAuthentication(authentication: mockAuth);
            _appCenter.setAuthentication(mockAuth);
            _backendProvider.notifyAuthentication(isAuthenticated: true);
            
            log("Fallback to mock authentication successful");
            AppUtils.instance.hideLoading();
            AppUtils.instance.showToast(AppLocale.biometricAuthSuccess.translate(context));
            
            autoGotoHomePage(context);
          }
        }
      } catch (e) {
        log("reLoadInformation error: $e");
        AppUtils.instance.hideLoading();
        AppUtils.instance.showToast(
          'Không thể tải thông tin người dùng. Vui lòng đăng nhập lại.',
        );
        await clearStoredTokens();
      }
    } catch (e, t) {
      log("loginWithBiometric() error", error: e, stackTrace: t);
      AppUtils.instance.hideLoading();
      // Hiển thị thông báo lỗi chi tiết hơn để debug
      final errorMessage = e.toString();
      log("Error details: $errorMessage");
      AppUtils.instance.showToast(
        'Lỗi: ${errorMessage.length > 50 ? errorMessage.substring(0, 50) + "..." : errorMessage}',
      );
    }
  }

  /// Kiểm tra và tự động đăng nhập bằng biometric khi mở app
  Future<void> checkAndAutoLoginWithBiometric(BuildContext context) async {
    try {
      // Kiểm tra xem có tokens đã lưu không
      final hasTokens = await hasStoredTokens();
      if (!hasTokens) {
        return;
      }

      final biometricService = BiometricAuthService();
      final isAvailable = await biometricService.isAvailable();
      if (!isAvailable) {
        return;
      }

      // Tự động đăng nhập bằng biometric
      await loginWithBiometric(context);
    } catch (e, t) {
      log("checkAndAutoLoginWithBiometric()", error: e, stackTrace: t);
    }
  }

  @override
  Future<void> onReady() {
    // TODO: implement onReady
    // test();
    return super.onReady();
  }

  // test() async {
  //   Future.delayed(const Duration(seconds: 2), () {
  //     ///
  //     var json = jsonDecode(
  //         '''{ "id": 22, "ngay": "2024-11-24T07:30:00.000", "nguoiHienMauId": 340227, "hoVaTen": "TRẦN VĂN NỔI", "ngaySinh": null, "namSinh": null, "cmnd": "077080006127", "gioiTinh": null, "maXa": null, "tenXa": null, "maHuyen": "238", "tenHuyen": "Châu Đức", "maTinh": "77", "tenTinh": "BR Vũng Tàu", "diaChiLienLac": null, "soDT": "0367645612", "tinhTrang": 1, "maDonViCapMau": null, "traLoiCauHoiId": 68, "dotLayMauId": 27661, "surveyQuestions": [ { "id": 1, "surveyQuestionId": null, "yes": null, "no": true, "onDate": "2024-11-24T17:12:37.848037", "notes": null }, { "id": 2, "surveyQuestionId": null, "yes": null, "no": true, "onDate": "2024-11-24T17:12:37.849346", "notes": null }, { "id": 9, "surveyQuestionId": null, "yes": null, "no": true, "onDate": "2024-11-24T17:12:37.849360", "notes": null }, { "id": 3, "surveyQuestionId": null, "yes": null, "no": true, "onDate": "2024-11-24T17:12:37.849365", "notes": null }, { "id": 10, "surveyQuestionId": null, "yes": null, "no": true, "onDate": "2024-11-24T17:12:37.849366", "notes": null }, { "id": 4, "surveyQuestionId": null, "yes": null, "no": true, "onDate": "2024-11-24T17:12:37.849367", "notes": null }, { "id": 11, "surveyQuestionId": null, "yes": null, "no": true, "onDate": "2024-11-24T17:12:37.849368", "notes": null }, { "id": 12, "surveyQuestionId": null, "yes": null, "no": true, "onDate": "2024-11-24T17:12:37.849369", "notes": null }, { "id": 5, "surveyQuestionId": null, "yes": null, "no": true, "onDate": "2024-11-24T17:12:37.849370", "notes": null }, { "id": 13, "surveyQuestionId": null, "yes": null, "no": true, "onDate": "2024-11-24T17:12:37.849371", "notes": null }, { "id": 6, "surveyQuestionId": null, "yes": null, "no": true, "onDate": "2024-11-24T17:12:37.849372", "notes": null }, { "id": 14, "surveyQuestionId": null, "yes": null, "no": true, "onDate": "2024-11-24T17:12:37.849373", "notes": null }, { "id": 15, "surveyQuestionId": null, "yes": null, "no": true, "onDate": "2024-11-24T17:12:37.849374", "notes": null }, { "id": 7, "surveyQuestionId": null, "yes": null, "no": true, "onDate": "2024-11-24T17:12:37.849375", "notes": null }, { "id": 8, "surveyQuestionId": null, "yes": null, "no": true, "onDate": "2024-11-24T17:12:37.849375", "notes": null }, { "id": 16, "surveyQuestionId": null, "yes": null, "no": true, "onDate": "2024-11-24T17:12:37.849376", "notes": null } ] }''');
  //     var item = RegisterDonationBloodHistoryResponse.fromJson(json);
  //     var data = jsonEncode(item.toMapQrCode());
  //     log(data);
  //     AppUtils.instance.showQrCodeImage(data);
  //   });
  // }

  void autoGotoHomePage(BuildContext context) {
    // BYPASS: Luôn chuyển vào màn hình chính
    try {
      Get.offAllNamed(Routes.appPage);
    } catch (e, s) {
      // TODO
      log("autoGotoHomePage()", error: e, stackTrace: s);
    }
    // Code gốc:
    // if (appCenter.backendProvider.isAuthenticated) {
    //   try {
    //     Get.offAllNamed(Routes.appPage);
    //   } catch (e, s) {
    //     log("autoGotoHomePage()", error: e, stackTrace: s);
    //   }
    // }
  }

  ///00000000-5783-1f4a-0000-00004578bd37
  Future<void> login(
      {required String username,
      required String password,
      required BuildContext context}) async {
    try {
      FocusScope.of(context).requestFocus(FocusNode());
      
      // BYPASS LOGIN - Tự động vào màn hình chính khi nhấn nút đăng nhập
      AppUtils.instance.showLoading();
      
      // Tạo mock authentication để bypass
      final mockAuth = Authentication(
        accessToken: "mock_token_bypass_login_${DateTime.now().millisecondsSinceEpoch}",
        userCode: username.trim().isNotEmpty ? username : "test_user",
        name: username.trim().isNotEmpty ? username : "Test User",
        appRole: 30, // UserRole.user.value
        status: 1,
      );
      
      // Lưu authentication vào localStorage
      await appCenter.localStorage.saveAuthentication(authentication: mockAuth);
      appCenter.setAuthentication(mockAuth);
      backendProvider.notifyAuthentication(isAuthenticated: true);
      
      // Lưu username
      setUserName();
      
      // Lưu tokens vào secure storage để dùng cho biometric login
      // Note: Trong production, sẽ lấy refreshToken từ server response
      await saveTokensToSecureStorage(
        authentication: mockAuth,
        refreshToken: null, // TODO: Lấy từ server response khi có
      );
      
      // Chuyển vào màn hình chính
      await Future.delayed(const Duration(milliseconds: 500)); // Delay nhỏ để UX mượt hơn
      autoGotoHomePage(context);
      
      // Code gốc đã được comment để bypass
      // if (username.trim().isEmpty) {
      //   AppUtils.instance.showToast("Chưa nhập tên tài khoản hoặc CCCD/Căn cước");
      //   return;
      // }
      // if (password.trim().isEmpty) {
      //   AppUtils.instance.showToast("Chưa nhập mật khẩu");
      //   return;
      // }
      // final isAuthenticated =
      //     await backendProvider.login(username: username, password: password);
      // if (isAuthenticated != null) {
      //   setUserName();
      //   autoGotoHomePage(context);
      // } else {
      //   AppUtils.instance.showError(AppLocale.loginFail.translate(context));
      // }
    } catch (e, t) {
      log("login()", error: e, stackTrace: t);
      AppUtils.instance.showError("$e");
    }
    AppUtils.instance.hideLoading();
  }
}
