# Hướng dẫn tích hợp SmartCA cho chữ ký số

## Tổng quan

SmartCA là giải pháp chữ ký số của VNPT. Có 3 phương thức tích hợp:

1. **SDK** - Nhúng trực tiếp lõi SmartCA vào app (trải nghiệm tốt nhất)
2. **Deeplink** - Mở app SmartCA để ký số (dễ triển khai nhất)
3. **Web API** - Kết nối qua HTTP/HTTPS (linh hoạt nhất)

## Các bước tích hợp

### Bước 1: Đăng ký tài khoản SmartCA

1. Truy cập: https://doitac-smartca.vnpt.vn/tich-hop-ky-so
2. Đăng ký tài khoản developer
3. Khai báo thông tin ứng dụng của bạn
4. Nhận `Client ID` và `Client Secret`

### Bước 2: Chọn phương thức tích hợp

#### Phương thức 1: Deeplink (Khuyến nghị cho bắt đầu)

**Ưu điểm:**
- Dễ triển khai, không cần native code
- Không cần SDK
- Nhanh chóng

**Nhược điểm:**
- Người dùng phải cài app SmartCA
- Cần xử lý callback từ app SmartCA

**Cách triển khai:**
1. Cập nhật `SmartCAService.signWithDeepLink()` với thông tin từ SmartCA
2. Cấu hình Deep Link trong `AndroidManifest.xml` và `Info.plist`
3. Xử lý callback khi SmartCA trả về kết quả

#### Phương thức 2: Web API

**Ưu điểm:**
- Không cần app SmartCA
- Tích hợp linh hoạt
- Có thể xử lý trên backend

**Nhược điểm:**
- Cần backend server làm trung gian
- Phức tạp hơn về bảo mật

**Cách triển khai:**
1. Tạo API endpoint trên backend để gọi SmartCA API
2. Cập nhật `SmartCAService.signWithWebAPI()` để gọi backend API
3. Xử lý authentication và authorization

#### Phương thức 3: SDK (Native)

**Ưu điểm:**
- Trải nghiệm tốt nhất
- Không cần app khác
- Tích hợp sâu

**Nhược điểm:**
- Cần tích hợp native code (Android/iOS)
- Phức tạp hơn
- Cần tải SDK từ SmartCA

**Cách triển khai:**
1. Tải SmartCA SDK từ: https://smartca.vnpt.vn/help/docs/sdks/sdk/download/
2. Tích hợp SDK vào Android/iOS native code
3. Tạo MethodChannel để gọi từ Flutter
4. Cập nhật `SmartCAService.signWithSDK()`

### Bước 3: Cấu hình Deep Link (nếu dùng Deeplink)

#### Android (`android/app/src/main/AndroidManifest.xml`):

```xml
<activity
    android:name=".MainActivity"
    android:exported="true"
    android:launchMode="singleTop">
    <intent-filter>
        <action android:name="android.intent.action.MAIN"/>
        <category android:name="android.intent.category.LAUNCHER"/>
    </intent-filter>
    
    <!-- Deep Link cho SmartCA callback -->
    <intent-filter>
        <action android:name="android.intent.action.VIEW"/>
        <category android:name="android.intent.category.DEFAULT"/>
        <category android:name="android.intent.category.BROWSABLE"/>
        <data android:scheme="blood_donation" android:host="signature_callback"/>
    </intent-filter>
</activity>
```

#### iOS (`ios/Runner/Info.plist`):

```xml
<key>CFBundleURLTypes</key>
<array>
    <dict>
        <key>CFBundleTypeRole</key>
        <string>Editor</string>
        <key>CFBundleURLName</key>
        <string>blood_donation</string>
        <key>CFBundleURLSchemes</key>
        <array>
            <string>blood_donation</string>
        </array>
    </dict>
</array>
```

### Bước 4: Cập nhật code

1. **Cập nhật `SmartCAService`:**
   - Thay `YOUR_CLIENT_ID` và `YOUR_CLIENT_SECRET` bằng thông tin thực
   - Cập nhật `_apiBaseUrl` (UAT hoặc Production)
   - Implement callback handler cho Deeplink

2. **Cập nhật các màn ký tên:**
   - Thay thế `SignatureController` bằng `SmartCAService`
   - Xử lý kết quả từ SmartCA

3. **Xử lý callback (nếu dùng Deeplink):**
   - Sử dụng `uni_links` hoặc `app_links` package
   - Lắng nghe deep link callback từ SmartCA
   - Parse kết quả chữ ký

### Bước 5: Test và triển khai

1. Test trên môi trường UAT trước
2. Kiểm tra các trường hợp:
   - Ký thành công
   - Ký thất bại
   - App SmartCA chưa cài đặt
   - Network error
3. Triển khai lên Production

## Tài liệu tham khảo

- **Trang chủ SmartCA:** https://doitac-smartca.vnpt.vn
- **Tài liệu SDK:** https://doitac-smartca.vnpt.vn/help/docs/tich-hop-ky-so-sdk/
- **Tài liệu Deeplink:** https://smartca.vnpt.vn/help/docs/sdks/deeplink/intro
- **Tài liệu Web API:** https://doitac-smartca.vnpt.vn/help/docs/tai-lieu-tich-hop-ky-so/
- **Tải SDK:** https://smartca.vnpt.vn/help/docs/sdks/sdk/download/

## Lưu ý

1. **Bảo mật:**
   - Không hardcode `Client Secret` trong code
   - Sử dụng environment variables hoặc secure storage
   - Validate dữ liệu trước khi ký

2. **Error Handling:**
   - Xử lý các lỗi có thể xảy ra
   - Hiển thị thông báo rõ ràng cho người dùng
   - Log lỗi để debug

3. **User Experience:**
   - Hướng dẫn người dùng cài app SmartCA (nếu dùng Deeplink)
   - Hiển thị loading khi đang ký
   - Xác nhận kết quả ký số

## Các file cần cập nhật

1. `lib/utils/smartca_service.dart` - Service chính
2. `lib/features/register_donate_blood/widgets/register_donate_blood_reception_page.dart`
3. `lib/features/register_donate_blood/widgets/register_donate_blood_pre_test_page.dart`
4. `android/app/src/main/AndroidManifest.xml` - Deep link config
5. `ios/Runner/Info.plist` - Deep link config
6. `pubspec.yaml` - Thêm packages nếu cần (uni_links, app_links)

