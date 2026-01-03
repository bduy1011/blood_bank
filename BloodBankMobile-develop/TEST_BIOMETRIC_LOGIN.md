# Hướng dẫn Test Đăng nhập bằng Vân tay/FaceID trên Emulator

## 🎯 Tổng quan

Tính năng đăng nhập bằng vân tay/FaceID đã được cấu hình để test được trên emulator mà không cần API thật.

## ✅ Các tính năng đã hỗ trợ test mode

1. **BiometricAuthService**: Tự động phát hiện emulator và hiển thị mock dialog
2. **SecureTokenService**: Hỗ trợ mock tokens (không cần JWT hợp lệ)
3. **LoginController**: Bypass mode đã lưu tokens vào secure storage

## 📱 Cách test trên Emulator

### Bước 1: Đăng nhập lần đầu (để lưu tokens)

1. Mở app trên emulator
2. Nhập username và password bất kỳ (hoặc để trống)
3. Nhấn nút **"Đăng nhập"**
4. App sẽ:
   - Tạo mock authentication
   - Lưu tokens vào secure storage
   - Vào màn hình chính

### Bước 2: Test đăng nhập bằng FaceID/Vân tay

1. **Đóng app hoàn toàn** (swipe away từ recent apps)
2. Mở lại app
3. Bạn sẽ thấy:
   - Nút **"Đăng nhập bằng vân tay, Face ID"** xuất hiện
   - Hoặc tự động hiển thị dialog FaceID (nếu có auto-login)

4. Nhấn nút hoặc chờ dialog xuất hiện
5. **Trên emulator**, bạn sẽ thấy dialog mock:
   ```
   ┌─────────────────────────────┐
   │ 🔐 Mock Biometric Auth      │
   │                             │
   │ Vui lòng xác thực để đăng   │
   │ nhập                         │
   │                             │
   │ (Emulator Mode - Simulating │
   │  biometric authentication)  │
   │                             │
   │ [Hủy] [Xác thực thành công] │
   │        [Thất bại]           │
   └─────────────────────────────┘
   ```

6. Nhấn **"Xác thực thành công"** để test flow thành công
7. Hoặc nhấn **"Thất bại"** để test flow thất bại

### Bước 3: Kiểm tra kết quả

**Khi thành công:**
- App hiển thị toast "Đăng nhập thành công"
- Tự động vào màn hình chính
- Tokens được giữ nguyên trong secure storage

**Khi thất bại:**
- App hiển thị toast "Xác thực sinh trắc học thất bại"
- Vẫn ở màn hình login
- Tokens vẫn được giữ (có thể thử lại)

## 🔍 Test các trường hợp

### 1. Test lần đầu (chưa có tokens)
- Đóng app
- Xóa app data (Settings > Apps > Clear Data)
- Mở lại app
- **Kỳ vọng**: Không có nút FaceID, phải đăng nhập bình thường

### 2. Test sau khi đăng nhập
- Đăng nhập bình thường
- Đóng app
- Mở lại app
- **Kỳ vọng**: Có nút FaceID hoặc tự động hiển thị dialog

### 3. Test hủy xác thực
- Nhấn nút FaceID
- Trong dialog mock, nhấn **"Hủy"**
- **Kỳ vọng**: Quay lại màn hình login, không vào app

### 4. Test thất bại
- Nhấn nút FaceID
- Trong dialog mock, nhấn **"Thất bại"**
- **Kỳ vọng**: Hiển thị toast lỗi, không vào app

### 5. Test thành công
- Nhấn nút FaceID
- Trong dialog mock, nhấn **"Xác thực thành công"**
- **Kỳ vọng**: Vào app thành công

## 🛠️ Debug

### Kiểm tra tokens đã lưu chưa

Thêm code tạm thời vào `LoginController`:

```dart
// Kiểm tra tokens
final hasTokens = await hasStoredTokens();
print("Has tokens: $hasTokens");

if (hasTokens) {
  final token = await _tokenService.getAccessToken();
  print("Access token: $token");
}
```

### Xóa tokens để test lại

Thêm nút debug tạm thời:

```dart
// Trong login_page.dart, thêm nút debug
ElevatedButton(
  onPressed: () async {
    await controller.clearStoredTokens();
    AppUtils.instance.showToast("Đã xóa tokens");
  },
  child: Text("Clear Tokens (Debug)"),
)
```

## 📝 Lưu ý

1. **Mock tokens**: Tokens bắt đầu bằng `mock_token_` sẽ không bao giờ "hết hạn" trong test mode
2. **Emulator detection**: App tự động phát hiện emulator và dùng mock dialog
3. **Secure storage**: Trên emulator, secure storage vẫn hoạt động bình thường (dùng Android Keystore)

## 🚀 Khi có API thật

Khi gắn API thật, chỉ cần:
1. Bỏ bypass mode trong `LoginController.login()`
2. Server trả về JWT token hợp lệ
3. Code sẽ tự động xử lý JWT và refresh token

Không cần thay đổi gì trong flow biometric login!


