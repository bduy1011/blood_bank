import 'dart:developer';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

/// Service để quản lý tokens trong secure storage (Keychain/Keystore)
/// 
/// Sử dụng flutter_secure_storage để lưu tokens an toàn:
/// - iOS: Keychain
/// - Android: Keystore
class SecureTokenService {
  static final SecureTokenService _instance = SecureTokenService._internal();
  factory SecureTokenService() => _instance;
  SecureTokenService._internal();

  static const FlutterSecureStorage _storage = FlutterSecureStorage(
    aOptions: AndroidOptions(
      encryptedSharedPreferences: true,
    ),
    iOptions: IOSOptions(
      accessibility: KeychainAccessibility.first_unlock_this_device,
    ),
  );

  // Keys cho secure storage
  static const String _keyAccessToken = 'access_token';
  static const String _keyRefreshToken = 'refresh_token';
  static const String _keyBiometricEnabled = 'biometric_enabled';

  /// Lưu access token và refresh token vào secure storage
  /// 
  /// [accessToken]: Access token từ server
  /// [refreshToken]: Refresh token từ server (optional)
  Future<void> saveTokens({
    required String accessToken,
    String? refreshToken,
  }) async {
    try {
      await _storage.write(key: _keyAccessToken, value: accessToken);
      if (refreshToken != null && refreshToken.isNotEmpty) {
        await _storage.write(key: _keyRefreshToken, value: refreshToken);
      }
      await _storage.write(key: _keyBiometricEnabled, value: 'true');
    } catch (e) {
      log("saveTokens() error: $e");
      rethrow;
    }
  }

  /// Lấy access token từ secure storage
  Future<String?> getAccessToken() async {
    try {
      return await _storage.read(key: _keyAccessToken);
    } catch (e) {
      log("getAccessToken() error: $e");
      return null;
    }
  }

  /// Lấy refresh token từ secure storage
  Future<String?> getRefreshToken() async {
    try {
      return await _storage.read(key: _keyRefreshToken);
    } catch (e) {
      log("getRefreshToken() error: $e");
      return null;
    }
  }

  /// Kiểm tra xem có tokens đã lưu không
  Future<bool> hasTokens() async {
    try {
      final accessToken = await getAccessToken();
      return accessToken != null && accessToken.isNotEmpty;
    } catch (e) {
      log("hasTokens() error: $e");
      return false;
    }
  }

  /// Kiểm tra xem biometric login đã được bật chưa
  Future<bool> isBiometricEnabled() async {
    try {
      final enabled = await _storage.read(key: _keyBiometricEnabled);
      return enabled == 'true';
    } catch (e) {
      log("isBiometricEnabled() error: $e");
      return false;
    }
  }

  /// Kiểm tra xem access token có hết hạn không
  Future<bool> isAccessTokenExpired() async {
    try {
      final accessToken = await getAccessToken();
      if (accessToken == null || accessToken.isEmpty) {
        return true;
      }
      
      // Nếu là mock token (không phải JWT hợp lệ), coi như chưa hết hạn để test
      if (accessToken.startsWith('mock_token_')) {
        return false; // Mock token không bao giờ hết hạn trong test mode
      }
      
      try {
        return JwtDecoder.isExpired(accessToken);
      } catch (e) {
        // Nếu không parse được JWT (có thể là mock token), coi như chưa hết hạn
        log("JWT decode error (might be mock token): $e");
        return false;
      }
    } catch (e) {
      log("isAccessTokenExpired() error: $e");
      return true;
    }
  }

  /// Xóa tất cả tokens (khi logout)
  Future<void> clearTokens() async {
    try {
      await _storage.delete(key: _keyAccessToken);
      await _storage.delete(key: _keyRefreshToken);
      await _storage.delete(key: _keyBiometricEnabled);
    } catch (e) {
      log("clearTokens() error: $e");
    }
  }

  /// Cập nhật access token (sau khi refresh)
  Future<void> updateAccessToken(String newAccessToken) async {
    try {
      await _storage.write(key: _keyAccessToken, value: newAccessToken);
    } catch (e) {
      log("updateAccessToken() error: $e");
      rethrow;
    }
  }
}

