# Hướng dẫn sử dụng Mock Mode cho SmartCA

## Tổng quan

Khi chưa có backend, bạn có thể sử dụng **Mock Mode** để test UI và flow ký số mà không cần kết nối với SmartCA thật.

## Cách bật/tắt Mock Mode

### Bước 1: Mở file `lib/utils/smartca_service.dart`

### Bước 2: Tìm dòng này:

```dart
static const bool useMockMode = true;
```

### Bước 3: Thay đổi giá trị:

- **`true`** = Sử dụng Mock Mode (test không cần backend)
- **`false`** = Sử dụng API thật (khi backend đã sẵn sàng)

## Mock Mode hoạt động như thế nào?

### Khi `useMockMode = true`:

1. **Không gọi API thật**: Tất cả các request đến backend sẽ được bypass
2. **Tạo mock signature**: Tự động tạo một chữ ký giả để test
3. **Simulate delay**: Giả lập thời gian chờ như gọi API thật (1-2 giây)
4. **Hiển thị thông báo**: Toast message sẽ có chữ "(Mock Mode)" để phân biệt

### Ví dụ response từ Mock Mode:

```dart
{
  'signature': Uint8List, // Mock signature bytes
  'signatureBase64': String, // Base64 encoded
  'success': true,
  'message': 'Ký số thành công (Mock Mode)',
  'certificateId': 'MOCK_CERT_donor_1234567890',
  'certificateInfo': {
    'owner': 'Người hiến máu (Mock)',
    'issuedBy': 'SmartCA Mock',
    'validFrom': '2024-01-01T00:00:00',
    'validTo': '2025-01-01T00:00:00',
  },
  'signedAt': '2024-01-01T12:00:00',
}
```

## Test với Mock Mode

### 1. Test màn Tiếp nhận (Reception):

1. Vào màn đăng ký hiến máu
2. Chọn "Vào màn ký tên" hoặc đi qua form
3. Chọn "Chữ ký số SmartCA"
4. Click "Ký số bằng SmartCA"
5. Đợi 1-2 giây (simulate delay)
6. Sẽ thấy toast: "Ký số thành công (Mock Mode - Chưa có backend)"
7. Tự động chuyển sang màn tiếp theo

### 2. Test màn Nhân viên/Bác sĩ/Điều dưỡng:

1. Đi đến màn tương ứng (Pre-test, Doctor, Nurse)
2. Click "Ký số bằng SmartCA"
3. Đợi và sẽ thấy kết quả mock
4. Flow tiếp tục bình thường

## Lưu ý quan trọng

### ⚠️ Khi chuyển sang Production:

1. **Đặt `useMockMode = false`** trước khi release
2. **Đảm bảo backend đã implement** các API endpoints:
   - `POST /api/smartca/sign`
   - `GET /api/smartca/certificates`
   - `POST /api/dang-ky-hien-mau/upload-signature/{registrationId}`
3. **Cấu hình SmartCA credentials** trên backend
4. **Test lại toàn bộ flow** với API thật

### 📝 Checklist trước khi release:

- [ ] `useMockMode = false`
- [ ] Backend đã implement SmartCA APIs
- [ ] SmartCA credentials đã được cấu hình
- [ ] Test với API thật thành công
- [ ] Test tất cả các loại chữ ký (donor, staff, doctor, nurse)
- [ ] Test error handling
- [ ] Test với network issues

## Customize Mock Response

Nếu muốn customize mock response, sửa function `_mockSignWithWebAPI()` trong `smartca_service.dart`:

```dart
static Future<Map<String, dynamic>?> _mockSignWithWebAPI(...) async {
  // Thay đổi delay time
  await Future.delayed(const Duration(seconds: 2)); // Thay vì 1 giây
  
  // Thay đổi mock signature
  final mockSignatureBytes = _createMockSignatureImage();
  
  // Thay đổi mock data
  final mockResponse = {
    // ... customize ở đây
  };
  
  return mockResponse;
}
```

## Troubleshooting

### Q: Mock mode không hoạt động?
A: Kiểm tra `useMockMode = true` trong `smartca_service.dart`

### Q: Vẫn thấy lỗi network?
A: Đảm bảo `useMockMode = true` và không có code nào gọi trực tiếp `backendProvider` mà không qua `SmartCAService`

### Q: Muốn test với signature image thật?
A: Thay đổi function `_createMockSignatureImage()` để load một image file thật

## Kết luận

Mock Mode cho phép bạn:
- ✅ Test UI và flow mà không cần backend
- ✅ Develop frontend độc lập
- ✅ Demo cho stakeholders
- ✅ Test error handling

**Nhớ tắt Mock Mode trước khi release!**

