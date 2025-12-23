import 'dart:developer' as developer;

import 'package:dio/dio.dart';

/// Mock interceptor để bypass API calls và trả về demo data
class MockInterceptor extends InterceptorsWrapper {
  static const bool enableMock = true; // Set false để tắt mock mode

  @override
  Future onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    if (!enableMock) {
      return super.onRequest(options, handler);
    }

    developer
        .log("🔴 MOCK MODE: Intercepting ${options.method} ${options.path}");

    // Mock response cho các API endpoints
    Response? mockResponse = _getMockResponse(options);

    if (mockResponse != null) {
      developer.log("✅ Returning mock data for ${options.path}");
      return handler.resolve(mockResponse);
    }

    // Nếu không có mock data, tiếp tục request thực
    return super.onRequest(options, handler);
  }

  Response? _getMockResponse(RequestOptions options) {
    final path = options.path.toLowerCase();
    final method = options.method.toUpperCase();

    // Mock login
    if (path.contains('login') && method == 'POST') {
      return Response(
        requestOptions: options,
        statusCode: 200,
        data: {
          "status": 200,
          "message": "Đăng nhập thành công",
          "data": {
            "accessToken":
                "mock_token_${DateTime.now().millisecondsSinceEpoch}",
            "refreshToken": "mock_refresh_token",
            "userCode": options.data?['userCode'] ?? "demo_user",
            "name": "Người dùng Demo",
            "email": "demo@example.com",
            "phoneNumber": "0123456789",
            "idCard": "123456789012",
            "role": "USER"
          }
        },
      );
    }

    // Mock register
    if (path.contains('register') && method == 'POST') {
      return Response(
        requestOptions: options,
        statusCode: 200,
        data: {
          "status": 200,
          "message": "Đăng ký thành công",
          "data": {
            "userCode": options.data?['userCode'] ?? "new_user",
            "name": options.data?['name'] ?? "Người dùng mới"
          }
        },
      );
    }

    // Mock check OTP
    if (path.contains('check-otp') && method == 'POST') {
      return Response(
        requestOptions: options,
        statusCode: 200,
        data: {
          "status": 200,
          "message": "Xác thực OTP thành công",
          "data": {
            "accessToken":
                "mock_token_${DateTime.now().millisecondsSinceEpoch}",
            "refreshToken": "mock_refresh_token",
            "userCode": "demo_user",
            "name": options.data?['fullName'] ?? "Người dùng Demo",
            "phoneNumber": options.data?['phoneNumber'] ?? "0123456789"
          }
        },
      );
    }

    // Mock refresh token
    if (path.contains('refresh-token') && method == 'GET') {
      return Response(
        requestOptions: options,
        statusCode: 200,
        data: "new_mock_token_${DateTime.now().millisecondsSinceEpoch}",
      );
    }

    // Mock re-load information
    if (path.contains('re-load-information') && method == 'GET') {
      return Response(
        requestOptions: options,
        statusCode: 200,
        data: {
          "status": 200,
          "message": "Thành công",
          "data": {
            "accessToken": "mock_token",
            "userCode": "demo_user",
            "name": "Người dùng Demo",
            "email": "demo@example.com",
            "phoneNumber": "0123456789",
            "idCard": "123456789012"
          }
        },
      );
    }

    // Mock get system config
    if (path.contains('system-config') && method == 'GET') {
      return Response(
        requestOptions: options,
        statusCode: 200,
        data: {
          "status": 200,
          "message": "Thành công",
          "data": [
            {
              "id": 1,
              "key": "app_name",
              "value": "Blood Bank Mobile",
              "description": "Tên ứng dụng"
            }
          ]
        },
      );
    }

    // Mock get slides
    if (path.contains('slides') && method == 'GET') {
      return Response(
        requestOptions: options,
        statusCode: 200,
        data: {
          "status": 200,
          "message": "Thành công",
          "data": [
            {
              "id": 1,
              "title": "Hiến máu cứu người",
              "imageUrl": "https://via.placeholder.com/800x400",
              "link": ""
            }
          ]
        },
      );
    }

    // Mock get news
    if (path.contains('news') && method == 'GET') {
      return Response(
        requestOptions: options,
        statusCode: 200,
        data: {
          "status": 200,
          "message": "Thành công",
          "data": [
            {
              "id": 1,
              "title": "Tin tức hiến máu",
              "content": "Nội dung tin tức demo",
              "imageUrl": "https://via.placeholder.com/400x300",
              "createdDate": DateTime.now().toIso8601String()
            }
          ]
        },
      );
    }

    // Mock get blood types
    if (path.contains('blood-types') && method == 'GET') {
      return Response(
        requestOptions: options,
        statusCode: 200,
        data: {
          "status": 200,
          "message": "Thành công",
          "data": [
            {"id": 1, "code": "A", "name": "Nhóm máu A"},
            {"id": 2, "code": "B", "name": "Nhóm máu B"},
            {"id": 3, "code": "AB", "name": "Nhóm máu AB"},
            {"id": 4, "code": "O", "name": "Nhóm máu O"}
          ]
        },
      );
    }

    // Mock get provinces
    if (path.contains('provinces') && method == 'GET') {
      return Response(
        requestOptions: options,
        statusCode: 200,
        data: {
          "status": 200,
          "message": "Thành công",
          "data": [
            {"id": 1, "code": "01", "name": "Hà Nội"},
            {"id": 2, "code": "79", "name": "Hồ Chí Minh"}
          ]
        },
      );
    }

    // Mock get districts
    if (path.contains('districts') && method == 'GET') {
      return Response(
        requestOptions: options,
        statusCode: 200,
        data: {
          "status": 200,
          "message": "Thành công",
          "data": [
            {"id": 1, "code": "001", "name": "Quận 1", "provinceCode": "79"},
            {"id": 2, "code": "002", "name": "Quận 2", "provinceCode": "79"}
          ]
        },
      );
    }

    // Mock get wards
    if (path.contains('wards') && method == 'GET') {
      return Response(
        requestOptions: options,
        statusCode: 200,
        data: {
          "status": 200,
          "message": "Thành công",
          "data": [
            {
              "id": 1,
              "code": "00001",
              "name": "Phường Bến Nghé",
              "districtCode": "001"
            },
            {
              "id": 2,
              "code": "00002",
              "name": "Phường Đa Kao",
              "districtCode": "001"
            }
          ]
        },
      );
    }

    // Mock get questions
    if (path.contains('bang-cau-hoi') && method == 'GET') {
      return Response(
        requestOptions: options,
        statusCode: 200,
        data: [
          {"id": 1, "question": "Bạn có đang khỏe mạnh không?", "answer": "Có"},
          {
            "id": 2,
            "question": "Bạn có đang dùng thuốc không?",
            "answer": "Không"
          }
        ],
      );
    }

    // Mock register donate blood
    if (path.contains('dang-ky-hien-mau/create') && method == 'POST') {
      return Response(
        requestOptions: options,
        statusCode: 200,
        data: {
          "status": 200,
          "message": "Đăng ký hiến máu thành công",
          "data": {
            "id": 1,
            "dotLayMauId": 1,
            "ngayGio": DateTime.now().toIso8601String()
          }
        },
      );
    }

    // Mock get donate blood history
    if (path.contains('dang-ky-hien-mau/load') && method == 'POST') {
      return Response(
        requestOptions: options,
        statusCode: 200,
        data: {"status": 200, "message": "Thành công", "data": []},
      );
    }

    // Mock get blood donation events
    if (path.contains('dot-lay-mau/load') && method == 'POST') {
      return Response(
        requestOptions: options,
        statusCode: 200,
        data: {"status": 200, "message": "Thành công", "data": []},
      );
    }

    // Mock get donation history
    if (path.contains('lich-su-hien-mau/load') && method == 'POST') {
      return Response(
        requestOptions: options,
        statusCode: 200,
        data: {"status": 200, "message": "Thành công", "data": []},
      );
    }

    // Mock get dm don vi cap mau
    if (path.contains('dm-don-vi-cap-mau/load') && method == 'POST') {
      return Response(
        requestOptions: options,
        statusCode: 200,
        data: {
          "status": 200,
          "message": "Thành công",
          "data": [
            {
              "id": 1,
              "code": "BV01",
              "name": "Bệnh viện Chợ Rẫy",
              "address": "201B Nguyễn Chí Thanh, Quận 5"
            }
          ]
        },
      );
    }

    // Mock resend OTP
    if (path.contains('resend-otp') && method == 'POST') {
      return Response(
        requestOptions: options,
        statusCode: 200,
        data: {"status": 200, "message": "Đã gửi lại mã OTP"},
      );
    }

    // Mock register by phone
    if (path.contains('register-phone') && method == 'POST') {
      return Response(
        requestOptions: options,
        statusCode: 200,
        data: {"status": 200, "message": "Đã gửi mã OTP"},
      );
    }

    // Mock logout
    if (path.contains('logout') && method == 'GET') {
      return Response(
        requestOptions: options,
        statusCode: 200,
        data: {"status": 200, "message": "Đăng xuất thành công"},
      );
    }

    // Mock các API khác trả về empty data
    return Response(
      requestOptions: options,
      statusCode: 200,
      data: {"status": 200, "message": "Thành công (Mock)", "data": []},
    );
  }
}
