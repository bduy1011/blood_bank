# Hướng dẫn đăng ký và cấu hình tài khoản SmartCA

## 📋 Tổng quan

**Khi nào cần tài khoản SmartCA?**
- ❌ **KHÔNG CẦN** khi đang dùng Mock Mode (test UI)
- ✅ **CẦN** khi backend đã sẵn sàng và muốn tích hợp thật
- ✅ **CẦN** khi deploy lên production

## 🎯 Tình trạng hiện tại

### ✅ Với Mock Mode (Hiện tại):
- **KHÔNG CẦN** tài khoản SmartCA
- Có thể test ngay mà không cần đăng ký
- Mock Mode tự động tạo dữ liệu giả

### ⏳ Khi có Backend (Sau này):
- **CẦN** đăng ký tài khoản SmartCA
- **CẦN** lấy Client ID và Client Secret
- **CẦN** cấu hình trên backend

## 📝 Hướng dẫn đăng ký tài khoản SmartCA

### Bước 1: Truy cập trang đăng ký

**Link:** https://doitac-smartca.vnpt.vn/tich-hop-ky-so

### Bước 2: Đăng ký tài khoản Developer

1. Click vào nút **"Đăng ký"** hoặc **"Đăng nhập"**
2. Điền thông tin:
   - Tên công ty/tổ chức
   - Email
   - Số điện thoại
   - Mật khẩu
3. Xác nhận email (nếu có)

### Bước 3: Khai báo thông tin ứng dụng

Sau khi đăng nhập, bạn cần khai báo:

1. **Thông tin ứng dụng:**
   - Tên ứng dụng: "Blood Donation App" (hoặc tên bạn muốn)
   - Mô tả: Mô tả về ứng dụng hiến máu
   - Platform: Mobile (Android/iOS)

2. **Thông tin tích hợp:**
   - Phương thức tích hợp: **Web API** (khuyến nghị)
   - Mục đích sử dụng: Chữ ký số cho quy trình hiến máu

3. **Thông tin liên hệ:**
   - Người liên hệ
   - Email
   - Số điện thoại

### Bước 4: Nhận thông tin tích hợp

Sau khi khai báo, bạn sẽ nhận được:

1. **Client ID** - ID ứng dụng của bạn
2. **Client Secret** - Mật khẩu bảo mật
3. **API Endpoint** - URL để gọi API
   - UAT (Test): `https://uat-api.smartca.vnpt.vn`
   - Production: `https://api.smartca.vnpt.vn`

### Bước 5: Lưu thông tin an toàn

⚠️ **QUAN TRỌNG:** 
- **Client ID và Client Secret** → Đưa cho **BACKEND TEAM** để cấu hình
- **KHÔNG** đặt vào Flutter code!
- **KHÔNG** commit vào Git repository!

**Xem chi tiết:** `SMARTCa_ARCHITECTURE.md`

## 🔐 Cấu hình trên Backend

### Khi backend đã sẵn sàng:

1. **Thêm vào environment variables hoặc config file:**

```env
# .env hoặc config
SMARTCA_CLIENT_ID=your_client_id_here
SMARTCA_CLIENT_SECRET=your_client_secret_here
SMARTCA_API_URL=https://api.smartca.vnpt.vn
SMARTCA_ENVIRONMENT=production # hoặc 'uat' cho test
```

2. **Backend sẽ sử dụng thông tin này để:**
   - Authenticate với SmartCA API
   - Gọi API ký số
   - Quản lý chứng chỉ số

## 📚 Tài liệu tham khảo

### Links quan trọng:

1. **Trang đăng ký:** https://doitac-smartca.vnpt.vn/tich-hop-ky-so
2. **Tài liệu Web API:** https://doitac-smartca.vnpt.vn/help/docs/tai-lieu-tich-hop-ky-so/
3. **Tài liệu SDK:** https://doitac-smartca.vnpt.vn/help/docs/tich-hop-ky-so-sdk/
4. **Tải SDK:** https://smartca.vnpt.vn/help/docs/sdks/sdk/download/

### Support:

- **Email:** support@smartca.vnpt.vn
- **Hotline:** (nếu có)
- **Fanpage:** (nếu có)

## ⚠️ Lưu ý quan trọng

### 1. Bảo mật thông tin:

- ❌ **KHÔNG** commit Client Secret vào Git
- ❌ **KHÔNG** hardcode trong code
- ✅ **NÊN** dùng environment variables
- ✅ **NÊN** dùng secure storage trên backend

### 2. Môi trường:

- **UAT (Test):** Dùng để test trước khi release
- **Production:** Dùng khi đã sẵn sàng deploy

### 3. Quy trình:

1. Đăng ký tài khoản → Nhận credentials
2. Test trên UAT environment
3. Khi OK → Chuyển sang Production
4. Deploy lên production

## 🎯 Checklist

### Khi chưa có backend (Hiện tại):
- [x] **KHÔNG CẦN** làm gì - Mock Mode đã đủ
- [x] Có thể test UI ngay

### Khi có backend (Sau này):
- [ ] Đăng ký tài khoản SmartCA
- [ ] Nhận Client ID và Client Secret
- [ ] Cấu hình trên backend (environment variables)
- [ ] Test trên UAT environment
- [ ] Tắt Mock Mode (`useMockMode = false`)
- [ ] Test với API thật
- [ ] Deploy lên production

## 💡 Tips

### 1. Đăng ký sớm:
- Nên đăng ký tài khoản sớm để có thời gian test
- Quá trình đăng ký có thể mất vài ngày (phê duyệt)

### 2. Test trên UAT trước:
- Luôn test trên UAT trước khi dùng Production
- Đảm bảo mọi thứ hoạt động đúng

### 3. Liên hệ support nếu cần:
- Nếu gặp vấn đề, liên hệ SmartCA support
- Họ sẽ hỗ trợ trong quá trình tích hợp

## 🎉 Kết luận

### Hiện tại (Chưa có backend):
- ✅ **KHÔNG CẦN** tài khoản SmartCA
- ✅ Có thể test ngay với Mock Mode
- ✅ Tất cả đã sẵn sàng

### Sau này (Khi có backend):
- 📝 Đăng ký tài khoản SmartCA
- 🔐 Lấy Client ID và Client Secret
- ⚙️ Cấu hình trên backend
- 🧪 Test trên UAT
- 🚀 Deploy lên production

**Bạn không cần làm gì ngay bây giờ! Chỉ cần biết quy trình để chuẩn bị sau này.**

