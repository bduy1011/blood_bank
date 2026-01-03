# Chuẩn bị khi chưa có Backend - SmartCA Integration

## 📋 Tổng quan

Khi chưa có backend, bạn vẫn có thể:
- ✅ Test toàn bộ UI và flow ký số
- ✅ Develop frontend độc lập
- ✅ Demo cho stakeholders
- ✅ Test các trường hợp lỗi

## 🎯 Những gì đã được chuẩn bị sẵn

### 1. **Mock Mode** - Test không cần backend

File: `lib/utils/smartca_service.dart`

**Cách sử dụng:**
```dart
// Dòng 18 trong smartca_service.dart
static const bool useMockMode = true; // ← Đã set sẵn = true
```

**Khi `useMockMode = true`:**
- ✅ Không gọi API thật
- ✅ Tự động tạo mock signature
- ✅ Simulate delay như API thật (1-2 giây)
- ✅ Hiển thị thông báo "(Mock Mode)" để phân biệt
- ✅ Flow hoạt động bình thường

### 2. **UI đã hoàn chỉnh**

- ✅ Màn Tiếp nhận: Có 2 tùy chọn (Chữ ký tay / SmartCA)
- ✅ Màn Nhân viên/Bác sĩ/Điều dưỡng: Chỉ SmartCA
- ✅ Loading states
- ✅ Error handling
- ✅ Toast notifications

### 3. **Backend Integration sẵn sàng**

- ✅ API endpoints đã được define trong `BackendClient`
- ✅ Methods đã được implement trong `BackendProvider`
- ✅ Code generation đã chạy xong
- ✅ Chỉ cần backend implement là dùng được ngay

## 🚀 Cách test ngay bây giờ

### Bước 1: Đảm bảo Mock Mode đang bật

Mở `lib/utils/smartca_service.dart` và kiểm tra:
```dart
static const bool useMockMode = true; // ← Phải là true
```

### Bước 2: Chạy app và test flow

1. **Test màn Tiếp nhận:**
   - Vào đăng ký hiến máu
   - Chọn "Vào màn ký tên"
   - Chọn "Chữ ký số SmartCA"
   - Click "Ký số bằng SmartCA"
   - Đợi 1-2 giây → Sẽ thấy "Ký số thành công (Mock Mode)"
   - Tự động chuyển sang màn tiếp theo

2. **Test màn Nhân viên/Bác sĩ/Điều dưỡng:**
   - Đi đến các màn tương ứng
   - Click "Ký số bằng SmartCA"
   - Sẽ thấy kết quả mock

### Bước 3: Test các trường hợp

- ✅ Ký thành công
- ✅ Flow từ đầu đến cuối
- ✅ Navigation giữa các màn
- ✅ Lưu chữ ký vào controller

## 📝 Checklist chuẩn bị

### ✅ Đã sẵn sàng (Không cần làm gì thêm):

- [x] Mock Mode đã được implement
- [x] UI đã hoàn chỉnh
- [x] Backend client đã được setup
- [x] Code generation đã chạy
- [x] Error handling đã có

### ⏳ Cần làm khi có Backend:

- [ ] **Đăng ký tài khoản SmartCA:**
  - [ ] Truy cập: https://doitac-smartca.vnpt.vn/tich-hop-ky-so
  - [ ] Đăng ký tài khoản developer
  - [ ] Khai báo thông tin ứng dụng
  - [ ] Nhận Client ID và Client Secret
  - [ ] Xem chi tiết: `SMARTCa_ACCOUNT_SETUP.md`
- [ ] **Backend cấu hình SmartCA:**
  - [ ] Cấu hình environment variables (Client ID, Secret, API URL)
  - [ ] Implement authentication với SmartCA
  - [ ] Xem template: `SMARTCa_CONFIG_TEMPLATE.md`
- [ ] **Backend implement API endpoints:**
  - [ ] `POST /api/smartca/sign`
  - [ ] `GET /api/smartca/certificates`
  - [ ] `POST /api/dang-ky-hien-mau/upload-signature/{registrationId}`
- [ ] **Tắt Mock Mode:**
  - [ ] Đặt `useMockMode = false` trong `smartca_service.dart`
- [ ] **Test với API thật:**
  - [ ] Test trên UAT environment trước
  - [ ] Test tất cả các loại chữ ký
  - [ ] Test error cases
  - [ ] Test với network issues
  - [ ] Deploy lên production

## 🔧 Customize Mock Mode (Tùy chọn)

Nếu muốn customize mock response, sửa trong `smartca_service.dart`:

### Thay đổi delay time:
```dart
// Trong _mockSignWithWebAPI()
await Future.delayed(const Duration(seconds: 2)); // Thay vì 1 giây
```

### Thay đổi mock signature:
```dart
// Trong _createMockSignatureImage()
// Có thể load một image file thật thay vì tạo mock
```

### Thay đổi mock data:
```dart
// Trong _mockSignWithWebAPI()
final mockResponse = {
  'signature': ...,
  'message': 'Custom message', // ← Thay đổi ở đây
  // ...
};
```

## 📚 Tài liệu tham khảo

1. **SMARTCa_MOCK_MODE.md** - Chi tiết về Mock Mode
2. **SMARTCa_INTEGRATION.md** - Hướng dẫn tích hợp SmartCA
3. **SMARTCa_RECOMMENDATION.md** - Phân tích và khuyến nghị

## ⚠️ Lưu ý quan trọng

### Trước khi release:

1. **BẮT BUỘC** đặt `useMockMode = false`
2. **BẮT BUỘC** backend đã implement APIs
3. **BẮT BUỘC** test với API thật
4. **KHUYẾN NGHỊ** test tất cả các trường hợp

### Mock Mode chỉ dùng để:

- ✅ Development
- ✅ Testing UI/UX
- ✅ Demo
- ❌ KHÔNG dùng trong Production

## 🎉 Kết luận

**Bạn đã sẵn sàng test ngay bây giờ!**

Không cần làm gì thêm, chỉ cần:
1. Đảm bảo `useMockMode = true` (đã set sẵn)
2. Chạy app và test flow
3. Khi có backend, chỉ cần tắt Mock Mode và test lại

**Tất cả đã được chuẩn bị sẵn! 🚀**

