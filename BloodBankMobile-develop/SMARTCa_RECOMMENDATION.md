# Khuyến nghị phương thức tích hợp SmartCA cho quy trình đăng ký máu tự động

## Phân tích quy trình

Quy trình đăng ký máu tự động có 5 bước với các yêu cầu ký số khác nhau:

1. **Tiếp nhận** - Người hiến máu ký tên trực tiếp trên app
2. **Đo chỉ số sinh tồn** - Không cần ký
3. **Xét nghiệm trước hiến máu** - Nhân viên ký số
4. **Bác sĩ xác nhận** - Bác sĩ ký số
5. **Điều dưỡng rút máu** - Điều dưỡng ký số

## Khuyến nghị phương thức tích hợp

### **Phương thức được khuyến nghị: Web API (Kết hợp với Backend)**

**Lý do:**
1. **Linh hoạt cho nhiều loại người dùng:**
   - Người hiến máu: Có thể ký từ app mobile
   - Nhân viên/Bác sĩ/Điều dưỡng: Có thể ký từ máy tính, tablet, hoặc mobile
   - Không bị giới hạn bởi thiết bị

2. **Bảo mật và quản lý tập trung:**
   - Chứng chỉ số được quản lý tập trung trên backend
   - Không cần lưu trữ thông tin nhạy cảm trên mobile app
   - Dễ dàng audit và theo dõi

3. **Tích hợp với hệ thống hiện có:**
   - Backend đã có sẵn (`BackendProvider`)
   - Dễ dàng thêm API endpoint cho SmartCA
   - Có thể lưu chữ ký số vào database cùng với dữ liệu đăng ký

4. **Phù hợp với môi trường làm việc:**
   - Nhân viên/bác sĩ/điều dưỡng thường làm việc trên máy tính
   - Có thể ký từ nhiều thiết bị khác nhau
   - Không cần cài app SmartCA trên từng thiết bị

### **Kiến trúc đề xuất:**

```
┌─────────────────┐
│  Mobile App     │
│  (Flutter)      │
│                 │
│  - Người hiến   │
│    máu ký       │
└────────┬────────┘
         │
         │ HTTP/HTTPS
         │
┌────────▼────────┐
│  Backend Server │
│  (API Gateway)  │
│                 │
│  - Xử lý ký số  │
│  - Lưu chữ ký   │
│  - Quản lý      │
│    chứng chỉ    │
└────────┬────────┘
         │
         │ SmartCA Web API
         │
┌────────▼────────┐
│  SmartCA Server │
│  (VNPT)         │
│                 │
│  - Xác thực     │
│  - Ký số        │
│  - Trả kết quả  │
└─────────────────┘
```

## Chi tiết triển khai cho từng bước

### **Bước 1: Tiếp nhận - Người hiến máu ký**

**Phương thức:** **Web API** (ưu tiên) hoặc **Deeplink** (fallback)

**Lý do:**
- Người hiến máu đang dùng app mobile → Có thể dùng Web API qua backend
- Nếu người hiến máu có app SmartCA → Có thể dùng Deeplink như fallback
- Hoặc có thể cho phép chọn: Chữ ký tay (nhanh) hoặc Chữ ký số SmartCA (chính thức)

**Implementation:**
```dart
// Ưu tiên: Web API
final signature = await SmartCAService.signWithWebAPI(
  dataToSign: data,
  signatureType: 'donor',
  certificateId: donorCertificateId, // Lấy từ backend sau khi đăng nhập
);

// Fallback: Deeplink (nếu người dùng có app SmartCA)
if (signature == null && await SmartCAService.isSmartCAInstalled()) {
  signature = await SmartCAService.signWithDeepLink(...);
}
```

### **Bước 2: Đo chỉ số sinh tồn**

Không cần ký số.

### **Bước 3: Xét nghiệm trước hiến máu - Nhân viên ký số**

**Phương thức:** **Web API** (bắt buộc)

**Lý do:**
- Nhân viên thường làm việc trên máy tính/tablet
- Cần chứng chỉ số của nhân viên (được quản lý trên backend)
- Không phụ thuộc vào việc cài app SmartCA trên mobile

**Implementation:**
```dart
// Backend sẽ xác định nhân viên đang đăng nhập và lấy chứng chỉ tương ứng
final signature = await backendProvider.signWithSmartCA(
  registrationId: registerDonationBlood.id,
  signatureType: 'staff',
  dataToSign: vitalSignsData,
);
```

### **Bước 4: Bác sĩ xác nhận - Bác sĩ ký số**

**Phương thức:** **Web API** (bắt buộc)

**Lý do:**
- Tương tự nhân viên
- Bác sĩ có thể ký từ máy tính hoặc tablet
- Chứng chỉ số được quản lý tập trung

**Implementation:**
```dart
final signature = await backendProvider.signWithSmartCA(
  registrationId: registerDonationBlood.id,
  signatureType: 'doctor',
  dataToSign: preTestData,
);
```

### **Bước 5: Điều dưỡng rút máu - Điều dưỡng ký số**

**Phương thức:** **Web API** (bắt buộc)

**Lý do:**
- Tương tự nhân viên và bác sĩ
- Sau khi ký, cập nhật trạng thái và gửi thư cảm ơn

**Implementation:**
```dart
final signature = await backendProvider.signWithSmartCA(
  registrationId: registerDonationBlood.id,
  signatureType: 'nurse',
  dataToSign: bloodCollectionData,
);

if (signature != null) {
  // Cập nhật trạng thái thành "Đã hiến máu"
  await completeBloodDonation();
  // Gửi thư cảm ơn
  await sendThankYouLetter();
}
```

## So sánh các phương thức

| Tiêu chí | Web API | Deeplink | SDK |
|----------|---------|----------|-----|
| **Phù hợp cho người hiến máu** | ⭐⭐⭐⭐⭐ | ⭐⭐⭐⭐ | ⭐⭐⭐ |
| **Phù hợp cho nhân viên/bác sĩ/điều dưỡng** | ⭐⭐⭐⭐⭐ | ⭐⭐ | ⭐⭐⭐ |
| **Độ phức tạp triển khai** | ⭐⭐⭐ | ⭐⭐⭐⭐ | ⭐⭐ |
| **Bảo mật** | ⭐⭐⭐⭐⭐ | ⭐⭐⭐⭐ | ⭐⭐⭐⭐⭐ |
| **Linh hoạt thiết bị** | ⭐⭐⭐⭐⭐ | ⭐⭐⭐ | ⭐⭐⭐⭐ |
| **Quản lý tập trung** | ⭐⭐⭐⭐⭐ | ⭐⭐ | ⭐⭐⭐ |

## Kế hoạch triển khai

### **Phase 1: Backend API (Ưu tiên)**

1. Tạo API endpoint trên backend để gọi SmartCA Web API
2. Quản lý chứng chỉ số cho từng loại người dùng (donor, staff, doctor, nurse)
3. Lưu trữ chữ ký số vào database
4. Tích hợp với flow hiện có

### **Phase 2: Mobile App Integration**

1. Cập nhật `SmartCAService` để gọi backend API
2. Cập nhật các màn ký tên để sử dụng SmartCA
3. Xử lý loading và error states
4. Test với người hiến máu

### **Phase 3: Staff/Doctor/Nurse Interface**

1. Tạo giao diện cho nhân viên/bác sĩ/điều dưỡng (web hoặc mobile)
2. Tích hợp SmartCA ký số
3. Test toàn bộ flow

### **Phase 4: Optimization**

1. Thêm fallback cho người hiến máu (Deeplink nếu có app SmartCA)
2. Cache và optimize performance
3. Monitoring và logging

## Kết luận

**Phương thức được khuyến nghị: Web API**

- Phù hợp nhất cho quy trình đăng ký máu tự động
- Linh hoạt cho tất cả các loại người dùng
- Dễ quản lý và bảo mật
- Tích hợp tốt với hệ thống hiện có

**Lưu ý:**
- Người hiến máu có thể có thêm tùy chọn Deeplink nếu có app SmartCA
- Nhân viên/bác sĩ/điều dưỡng bắt buộc dùng Web API để đảm bảo tính nhất quán

