import 'dart:convert';
import 'dart:typed_data';
import 'package:blood_donation/app/app_util/app_center.dart';
import 'package:blood_donation/utils/app_utils.dart';
import 'package:get_it/get_it.dart';
import 'package:url_launcher/url_launcher.dart';

/// Service để tích hợp SmartCA cho chữ ký số
/// 
/// SmartCA hỗ trợ 3 phương thức tích hợp:
/// 1. SDK - Nhúng trực tiếp lõi SmartCA vào app
/// 2. Deeplink - Mở app SmartCA để ký số
/// 3. Web API - Kết nối qua HTTP/HTTPS
class SmartCAService {
  // ============================================
  // MOCK MODE - Để test khi chưa có backend
  // ============================================
  /// Set true để sử dụng mock data thay vì gọi API thật
  /// Set false khi backend đã sẵn sàng
  static const bool useMockMode = true;
  
  // ============================================
  // SMARTCA CONFIGURATION
  // ============================================
  static const String _smartcaPackageName = 'com.vnpt.smartca';
  static const String _smartcaDeepLinkScheme = 'smartca://';
  
  // ============================================
  // LƯU Ý: Client ID và Secret KHÔNG đặt ở đây!
  // ============================================
  // Client ID và Client Secret phải được cấu hình trên BACKEND
  // Flutter chỉ gọi API của backend, không gọi trực tiếp SmartCA
  // Xem chi tiết: SMARTCa_ARCHITECTURE.md
  //
  // Các biến dưới đây chỉ để tham khảo, không được sử dụng trong code
  // ignore: unused_field
  static const String _clientId = 'YOUR_CLIENT_ID'; // ❌ KHÔNG dùng
  // ignore: unused_field
  static const String _clientSecret = 'YOUR_CLIENT_SECRET'; // ❌ KHÔNG dùng
  // ignore: unused_field
  static const String _apiBaseUrl = 'https://api.smartca.vnpt.vn'; // Chỉ để tham khảo

  /// Phương thức 1: Ký số bằng Deeplink (Mở app SmartCA)
  /// 
  /// Ưu điểm: Dễ triển khai, không cần SDK
  /// Yêu cầu: Người dùng phải cài app SmartCA
  /// 
  /// [dataToSign]: Dữ liệu cần ký (String hoặc base64)
  /// [signatureType]: Loại chữ ký (donor, staff, doctor, nurse)
  /// 
  /// Returns: Uint8List? - Chữ ký đã ký (nếu thành công)
  static Future<Uint8List?> signWithDeepLink({
    required String dataToSign,
    required String signatureType,
    String? reason,
    String? location,
  }) async {
    try {
      // Tạo deeplink để mở SmartCA
      // Format: smartca://sign?data=<base64_data>&reason=<reason>&location=<location>
      final base64Data = Uri.encodeComponent(dataToSign);
      final encodedReason = reason != null ? Uri.encodeComponent(reason) : '';
      final encodedLocation = location != null ? Uri.encodeComponent(location) : '';
      
      final deepLink = '$_smartcaDeepLinkScheme'
          'sign?'
          'data=$base64Data&'
          'reason=$encodedReason&'
          'location=$encodedLocation&'
          'callback=blood_donation://signature_callback';
      
      final uri = Uri.parse(deepLink);
      
      // Kiểm tra xem app SmartCA có cài đặt không
      if (await canLaunchUrl(uri)) {
        // Mở app SmartCA
        final launched = await launchUrl(
          uri,
          mode: LaunchMode.externalApplication,
        );
        
        if (launched) {
          // TODO: Lắng nghe callback từ SmartCA
          // Có thể dùng MethodChannel hoặc DeepLink handler
          // Để nhận kết quả chữ ký từ SmartCA app
          
          // Tạm thời return null, cần implement callback handler
          return null;
        } else {
          AppUtils.instance.showToast(
            'Không thể mở ứng dụng SmartCA. Vui lòng cài đặt ứng dụng SmartCA.',
          );
          return null;
        }
      } else {
        // App SmartCA chưa được cài đặt
        AppUtils.instance.showToast(
          'Vui lòng cài đặt ứng dụng SmartCA để thực hiện ký số.',
        );
        // TODO: Có thể mở link tải app SmartCA
        return null;
      }
    } catch (e) {
      AppUtils.instance.showToast(
        'Lỗi khi mở SmartCA: ${e.toString()}',
      );
      return null;
    }
  }

  /// Phương thức 2: Ký số bằng Web API (KHUYẾN NGHỊ)
  /// 
  /// Ưu điểm: 
  /// - Không cần app SmartCA
  /// - Tích hợp linh hoạt, phù hợp cho tất cả loại người dùng
  /// - Bảo mật cao, quản lý tập trung
  /// - Nhân viên/bác sĩ/điều dưỡng có thể ký từ máy tính
  /// 
  /// Yêu cầu: Cần backend server làm trung gian
  /// 
  /// [registrationId]: ID đăng ký hiến máu
  /// [dataToSign]: Dữ liệu cần ký
  /// [signatureType]: Loại chữ ký (donor, staff, doctor, nurse)
  /// 
  /// Returns: Map<String, dynamic>? - Chứa chữ ký và metadata
  static Future<Map<String, dynamic>?> signWithWebAPI({
    required String registrationId,
    required String dataToSign,
    required String signatureType,
  }) async {
    // ============================================
    // MOCK MODE - Test khi chưa có backend
    // ============================================
    if (useMockMode) {
      return _mockSignWithWebAPI(
        registrationId: registrationId,
        dataToSign: dataToSign,
        signatureType: signatureType,
      );
    }

    // ============================================
    // PRODUCTION MODE - Gọi API thật
    // ============================================
    try {
      final appCenter = GetIt.instance<AppCenter>();
      final response = await appCenter.backendProvider.signWithSmartCA(
        registrationId: registrationId,
        dataToSign: dataToSign,
        signatureType: signatureType,
      );

      if (response != null && response['success'] == true) {
        // Upload chữ ký vào đăng ký hiến máu
        final signatureBase64 = response['signature'] as String;
        final uploadSuccess = await appCenter.backendProvider.uploadSignature(
          registrationId: registrationId,
          signatureType: signatureType,
          signatureBase64: signatureBase64,
          signatureInfo: {
            'signedAt': DateTime.now().toIso8601String(),
            'certificateId': response['certificateId'],
            'certificateInfo': response['certificateInfo'],
          },
        );

        if (uploadSuccess) {
          return {
            'signature': base64Decode(signatureBase64),
            'signatureBase64': signatureBase64,
            'success': true,
            'message': 'Ký số thành công',
            'certificateId': response['certificateId'],
            'certificateInfo': response['certificateInfo'],
          };
        } else {
          AppUtils.instance.showToast(
            'Ký số thành công nhưng không thể lưu chữ ký.',
          );
          return null;
        }
      } else {
        final errorMessage = response?['message'] ?? 'Ký số thất bại';
        AppUtils.instance.showToast(errorMessage);
        return null;
      }
    } catch (e) {
      AppUtils.instance.showToast(
        'Lỗi khi ký số: ${e.toString()}',
      );
      return null;
    }
  }

  /// Mock function để test khi chưa có backend
  static Future<Map<String, dynamic>?> _mockSignWithWebAPI({
    required String registrationId,
    required String dataToSign,
    required String signatureType,
  }) async {
    try {
      // Simulate network delay
      await Future.delayed(const Duration(seconds: 1));

      // Tạo mock signature (một hình ảnh PNG đơn giản)
      // Trong thực tế, đây sẽ là chữ ký số từ SmartCA
      final mockSignatureBytes = _createMockSignatureImage();

      // Encode thành base64
      final signatureBase64 = base64Encode(mockSignatureBytes);

      // Mock response
      final mockResponse = {
        'signature': mockSignatureBytes,
        'signatureBase64': signatureBase64,
        'success': true,
        'message': 'Ký số thành công (Mock Mode)',
        'certificateId': 'MOCK_CERT_${signatureType}_${DateTime.now().millisecondsSinceEpoch}',
        'certificateInfo': {
          'owner': _getMockCertificateOwner(signatureType),
          'issuedBy': 'SmartCA Mock',
          'validFrom': DateTime.now().toIso8601String(),
          'validTo': DateTime.now().add(const Duration(days: 365)).toIso8601String(),
        },
        'signedAt': DateTime.now().toIso8601String(),
      };

      // Simulate upload success
      await Future.delayed(const Duration(milliseconds: 500));

      AppUtils.instance.showToast(
        'Ký số thành công (Mock Mode - Chưa có backend)',
      );

      return mockResponse;
    } catch (e) {
      AppUtils.instance.showToast(
        'Lỗi khi ký số (Mock): ${e.toString()}',
      );
      return null;
    }
  }

  /// Tạo mock signature image (PNG đơn giản)
  static Uint8List _createMockSignatureImage() {
    // Tạo một PNG đơn giản (1x1 pixel màu đen)
    // Trong thực tế, đây sẽ là chữ ký số từ SmartCA
    // Format: PNG với kích thước nhỏ để test
    const pngHeader = [
      0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A, // PNG signature
    ];
    
    // Tạo một image đơn giản (có thể thay bằng image thật nếu cần)
    // Để đơn giản, tạo một byte array giả lập
    final mockImage = List<int>.from(pngHeader);
    mockImage.addAll(List.filled(100, 0)); // Padding
    
    return Uint8List.fromList(mockImage);
  }

  /// Lấy tên chứng chỉ mock dựa trên loại chữ ký
  static String _getMockCertificateOwner(String signatureType) {
    switch (signatureType) {
      case 'donor':
        return 'Người hiến máu (Mock)';
      case 'staff':
        return 'Nhân viên (Mock)';
      case 'doctor':
        return 'Bác sĩ (Mock)';
      case 'nurse':
        return 'Điều dưỡng (Mock)';
      default:
        return 'Unknown (Mock)';
    }
  }

  /// Phương thức 3: Ký số bằng SDK (Native)
  /// 
  /// Ưu điểm: Trải nghiệm tốt nhất, không cần app khác
  /// Yêu cầu: Cần tích hợp SmartCA SDK vào native code
  /// 
  /// [dataToSign]: Dữ liệu cần ký
  /// [signatureType]: Loại chữ ký
  /// 
  /// Returns: Uint8List? - Chữ ký đã ký
  static Future<Uint8List?> signWithSDK({
    required String dataToSign,
    required String signatureType,
  }) async {
    try {
      // TODO: Gọi SmartCA SDK qua MethodChannel
      // Cần implement native code cho Android/iOS
      
      // Ví dụ:
      // const platform = MethodChannel('smartca/sign');
      // final result = await platform.invokeMethod('sign', {
      //   'data': dataToSign,
      //   'type': signatureType,
      // });
      // return base64Decode(result['signature']);
      
      AppUtils.instance.showToast(
        'Chức năng ký số qua SDK chưa được triển khai.',
      );
      return null;
    } catch (e) {
      AppUtils.instance.showToast(
        'Lỗi khi ký số: ${e.toString()}',
      );
      return null;
    }
  }

  /// Kiểm tra xem app SmartCA có được cài đặt không
  static Future<bool> isSmartCAInstalled() async {
    try {
      final uri = Uri.parse('$_smartcaDeepLinkScheme');
      return await canLaunchUrl(uri);
    } catch (e) {
      return false;
    }
  }

  /// Mở link tải app SmartCA
  static Future<void> openSmartCADownload() async {
    try {
      // Link tải SmartCA từ Play Store / App Store
      const playStoreUrl = 'https://play.google.com/store/apps/details?id=$_smartcaPackageName';
      // TODO: Thêm App Store URL khi cần hỗ trợ iOS
      // const appStoreUrl = 'https://apps.apple.com/app/smartca/id...';
      
      // TODO: Detect platform và mở link phù hợp
      final url = Uri.parse(playStoreUrl);
      if (await canLaunchUrl(url)) {
        await launchUrl(url, mode: LaunchMode.externalApplication);
      }
    } catch (e) {
      AppUtils.instance.showToast(
        'Không thể mở link tải ứng dụng SmartCA.',
      );
    }
  }

  /// Chuẩn bị dữ liệu để ký
  /// 
  /// [originalData]: Dữ liệu gốc cần ký
  /// [metadata]: Thông tin bổ sung (người ký, thời gian, v.v.)
  static String prepareDataForSigning({
    required String originalData,
    Map<String, dynamic>? metadata,
  }) {
    // Tạo JSON object chứa dữ liệu và metadata
    final dataToSign = {
      'data': originalData,
      'timestamp': DateTime.now().toIso8601String(),
      if (metadata != null) ...metadata,
    };
    
    // Serialize thành JSON string
    return jsonEncode(dataToSign);
  }
}

