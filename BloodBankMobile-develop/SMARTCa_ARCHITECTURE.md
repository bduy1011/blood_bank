# Kiến trúc SmartCA Integration - Client ID và Secret ở đâu?

## ⚠️ QUAN TRỌNG: Client ID và Secret KHÔNG đặt trong Flutter!

### ❌ SAI - KHÔNG làm thế này:

```dart
// ❌ KHÔNG đặt Client ID và Secret trong Flutter
class SmartCAService {
  static const String _clientId = 'YOUR_CLIENT_ID'; // ❌ SAI
  static const String _clientSecret = 'YOUR_CLIENT_SECRET'; // ❌ SAI
}
```

**Tại sao SAI?**
- Client Secret là thông tin nhạy cảm, không được lưu trong mobile app
- Mobile app có thể bị reverse engineering
- Secret sẽ bị lộ và bị lạm dụng

### ✅ ĐÚNG - Kiến trúc bảo mật:

```
┌─────────────────┐
│  Flutter App    │
│  (Mobile)       │
│                 │
│  KHÔNG có       │
│  Client Secret  │
└────────┬────────┘
         │
         │ HTTP/HTTPS
         │ (Chỉ gọi API của backend)
         │
┌────────▼────────┐
│  Backend Server │
│  (API Gateway)  │
│                 │
│  ✅ CÓ Client ID│
│  ✅ CÓ Secret   │
│  ✅ Xử lý auth  │
│  ✅ Gọi SmartCA │
└────────┬────────┘
         │
         │ SmartCA Web API
         │ (Với Client ID + Secret)
         │
┌────────▼────────┐
│  SmartCA Server │
│  (VNPT)         │
└─────────────────┘
```

## 📋 Phân công rõ ràng

### Flutter App (Mobile):
- ✅ Gọi API của backend: `POST /api/smartca/sign`
- ✅ Gửi dữ liệu cần ký
- ✅ Nhận kết quả chữ ký
- ❌ KHÔNG có Client ID
- ❌ KHÔNG có Client Secret
- ❌ KHÔNG gọi trực tiếp SmartCA API

### Backend Server:
- ✅ Lưu Client ID (environment variable)
- ✅ Lưu Client Secret (environment variable)
- ✅ Authenticate với SmartCA (dùng Client ID + Secret)
- ✅ Gọi SmartCA API để ký số
- ✅ Trả kết quả về cho Flutter

## 🔐 Cấu hình đúng cách

### 1. Backend cấu hình (Environment Variables):

```env
# .env trên backend server
SMARTCA_CLIENT_ID=your_client_id_from_smartca
SMARTCA_CLIENT_SECRET=your_client_secret_from_smartca
SMARTCA_API_URL=https://api.smartca.vnpt.vn
```

### 2. Flutter KHÔNG cần cấu hình gì:

Flutter chỉ cần biết:
- Backend API URL (đã có sẵn trong `AppConfig`)
- Endpoint: `/api/smartca/sign` (đã implement sẵn)

**KHÔNG CẦN** thay Client ID/Secret vào Flutter!

## 📝 Quy trình khi có thông tin từ SmartCA

### Bước 1: Nhận thông tin từ SmartCA
Sau khi đăng ký, bạn nhận được:
- Client ID: `abc123xyz`
- Client Secret: `secret456`
- API Endpoint: `https://api.smartca.vnpt.vn`

### Bước 2: Cấu hình trên BACKEND (KHÔNG phải Flutter)

**Backend team làm:**
1. Thêm vào `.env` hoặc config:
```env
SMARTCA_CLIENT_ID=abc123xyz
SMARTCA_CLIENT_SECRET=secret456
SMARTCA_API_URL=https://api.smartca.vnpt.vn
```

2. Backend sử dụng để authenticate:
```javascript
// Backend code
const token = await authenticateWithSmartCA(
  process.env.SMARTCA_CLIENT_ID,
  process.env.SMARTCA_CLIENT_SECRET
);
```

### Bước 3: Flutter KHÔNG cần làm gì

Flutter đã có sẵn code để gọi backend API:
```dart
// Flutter code (đã có sẵn)
final response = await appCenter.backendProvider.signWithSmartCA(
  registrationId: registrationId,
  dataToSign: dataToSign,
  signatureType: signatureType,
);
```

**Flutter KHÔNG cần biết Client ID/Secret!**

## ✅ Checklist

### Backend Team cần làm:
- [ ] Nhận Client ID và Secret từ SmartCA
- [ ] Cấu hình vào environment variables
- [ ] Implement authentication với SmartCA
- [ ] Implement API endpoints
- [ ] Test với SmartCA API

### Flutter Team cần làm:
- [x] ✅ Đã xong - Code đã sẵn sàng
- [x] ✅ Đã xong - Chỉ cần gọi backend API
- [ ] Tắt Mock Mode khi backend sẵn sàng
- [ ] Test với backend API thật

## 🎯 Tóm tắt

### Câu hỏi: "Có phải chỉ cần thay vào Flutter thôi không?"

**Trả lời: KHÔNG!**

1. **Client ID và Secret** → Cấu hình trên **BACKEND**
2. **Flutter** → Chỉ gọi API của backend (đã có sẵn code)
3. **Backend** → Gọi SmartCA API với Client ID/Secret

### Flutter KHÔNG cần:
- ❌ Client ID
- ❌ Client Secret
- ❌ Cấu hình gì thêm

### Flutter CHỈ cần:
- ✅ Backend API đã implement (đã có sẵn)
- ✅ Tắt Mock Mode khi backend sẵn sàng

## 🔒 Lý do bảo mật

1. **Client Secret là nhạy cảm:**
   - Nếu lộ trong mobile app → Bị lạm dụng
   - Mobile app có thể bị reverse engineering
   - Secret sẽ bị đánh cắp

2. **Backend là nơi an toàn:**
   - Server-side code khó bị reverse
   - Environment variables được bảo vệ
   - Có thể rotate secret dễ dàng

3. **Best Practice:**
   - Secret keys luôn ở server-side
   - Mobile app chỉ là client
   - API Gateway pattern

## 💡 Kết luận

**Sau khi đăng ký SmartCA và nhận được:**
- Client ID
- Client Secret  
- API Endpoint

**Bạn cần:**
1. ✅ Đưa cho **Backend Team** để cấu hình
2. ✅ Backend implement API endpoints
3. ✅ Flutter chỉ cần tắt Mock Mode và test

**Flutter KHÔNG cần thay gì cả! Code đã sẵn sàng!** 🎉

