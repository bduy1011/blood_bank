import 'dart:developer';
import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';

class BiometricAuthService {
  static final BiometricAuthService _instance = BiometricAuthService._internal();
  factory BiometricAuthService() => _instance;
  BiometricAuthService._internal();

  final LocalAuthentication _localAuth = LocalAuthentication();
  bool? _isEmulator;

  /// Kiểm tra xem có đang chạy trên emulator không
  Future<bool> isRunningOnEmulator() async {
    if (_isEmulator != null) return _isEmulator!;
    
    try {
      if (Platform.isAndroid) {
        final deviceInfo = DeviceInfoPlugin();
        final androidInfo = await deviceInfo.androidInfo;
        // Emulator thường có model chứa "sdk" hoặc "google_sdk"
        _isEmulator = androidInfo.model.toLowerCase().contains('sdk') ||
            androidInfo.model.toLowerCase().contains('google_sdk') ||
            androidInfo.manufacturer.toLowerCase() == 'google' ||
            androidInfo.isPhysicalDevice == false;
      } else if (Platform.isIOS) {
        final deviceInfo = DeviceInfoPlugin();
        final iosInfo = await deviceInfo.iosInfo;
        // Simulator có model chứa "simulator"
        _isEmulator = iosInfo.model.toLowerCase().contains('simulator') ||
            !iosInfo.isPhysicalDevice;
      } else {
        _isEmulator = false;
      }
      return _isEmulator ?? false;
    } catch (e) {
      log("isRunningOnEmulator error: $e");
      return false;
    }
  }

  /// Kiểm tra xem thiết bị có hỗ trợ biometric không
  Future<bool> isDeviceSupported() async {
    try {
      return await _localAuth.isDeviceSupported();
    } catch (e) {
      log("isDeviceSupported error: $e");
      return false;
    }
  }

  /// Kiểm tra xem có biometric nào được đăng ký không
  Future<bool> canCheckBiometrics() async {
    try {
      return await _localAuth.canCheckBiometrics;
    } catch (e) {
      log("canCheckBiometrics error: $e");
      return false;
    }
  }

  /// Lấy danh sách các loại biometric có sẵn
  Future<List<BiometricType>> getAvailableBiometrics() async {
    try {
      return await _localAuth.getAvailableBiometrics();
    } catch (e) {
      log("getAvailableBiometrics error: $e");
      return [];
    }
  }

  /// Xác thực bằng biometric (với mock mode cho emulator)
  Future<bool> authenticate({
    String? reason,
    bool useErrorDialogs = true,
    bool stickyAuth = true,
    BuildContext? context,
  }) async {
    try {
      // Kiểm tra nếu đang chạy trên emulator
      final isEmulator = await isRunningOnEmulator();
      if (isEmulator && context != null) {
        // Sử dụng mock dialog cho emulator
        return await _authenticateMock(context, reason);
      }

      // Sử dụng biometric thật trên thiết bị thật
      final bool didAuthenticate = await _localAuth.authenticate(
        localizedReason: reason ?? 'Vui lòng xác thực để đăng nhập',
        options: AuthenticationOptions(
          useErrorDialogs: useErrorDialogs,
          stickyAuth: stickyAuth,
          biometricOnly: false,
        ),
      );
      return didAuthenticate;
    } on PlatformException catch (e) {
      log("authenticate error: $e");
      return false;
    } catch (e) {
      log("authenticate error: $e");
      return false;
    }
  }

  /// Mock authentication dialog cho emulator
  Future<bool> _authenticateMock(BuildContext context, String? reason) async {
    return await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            children: [
              Icon(Icons.fingerprint, color: Colors.blue, size: 28),
              const SizedBox(width: 10),
              const Text('Mock Biometric Auth'),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                reason ?? 'Vui lòng xác thực để đăng nhập',
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 20),
              const Text(
                '(Emulator Mode - Simulating biometric authentication)',
                style: TextStyle(
                  fontSize: 12,
                  fontStyle: FontStyle.italic,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Hủy'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(true),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
              ),
              child: const Text('Xác thực thành công'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text(
                'Thất bại',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    ) ?? false;
  }

  /// Kiểm tra xem có thể xác thực không (có biometric và đã đăng ký hoặc đang trên emulator)
  Future<bool> isAvailable() async {
    try {
      // Nếu đang trên emulator, luôn return true để có thể test
      final isEmulator = await isRunningOnEmulator();
      if (isEmulator) {
        return true;
      }
      
      final bool canAuthenticate = await _localAuth.canCheckBiometrics ||
          await _localAuth.isDeviceSupported();
      return canAuthenticate;
    } catch (e) {
      log("isAvailable error: $e");
      return false;
    }
  }

  /// Lấy tên loại biometric (vân tay, Face ID, etc.)
  Future<String> getBiometricTypeName() async {
    try {
      final availableBiometrics = await getAvailableBiometrics();
      if (availableBiometrics.isEmpty) {
        return 'Biometric';
      }
      
      if (availableBiometrics.contains(BiometricType.face)) {
        return 'Face ID';
      } else if (availableBiometrics.contains(BiometricType.fingerprint)) {
        return 'Vân tay';
      } else if (availableBiometrics.contains(BiometricType.iris)) {
        return 'Iris';
      } else if (availableBiometrics.contains(BiometricType.strong)) {
        return 'Strong';
      } else if (availableBiometrics.contains(BiometricType.weak)) {
        return 'Weak';
      }
      return 'Biometric';
    } catch (e) {
      log("getBiometricTypeName error: $e");
      return 'Biometric';
    }
  }
}

