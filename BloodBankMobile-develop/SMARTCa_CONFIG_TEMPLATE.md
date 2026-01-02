# Template cấu hình SmartCA cho Backend

## 📋 Thông tin cần cấu hình

Khi backend đã sẵn sàng, cần cấu hình các thông tin sau:

## 🔐 Environment Variables

Tạo file `.env` hoặc config file trên backend:

```env
# SmartCA Configuration
SMARTCA_CLIENT_ID=your_client_id_here
SMARTCA_CLIENT_SECRET=your_client_secret_here
SMARTCA_API_URL=https://api.smartca.vnpt.vn
SMARTCA_ENVIRONMENT=production

# Hoặc cho UAT (Test)
# SMARTCA_API_URL=https://uat-api.smartca.vnpt.vn
# SMARTCA_ENVIRONMENT=uat
```

## 📝 Backend Implementation Template

### 1. API Endpoint: `POST /api/smartca/sign`

**Request:**
```json
{
  "registrationId": "123",
  "dataToSign": "{\"data\":\"...\",\"timestamp\":\"...\"}",
  "signatureType": "donor"
}
```

**Response (Success):**
```json
{
  "status": 200,
  "data": {
    "success": true,
    "signature": "base64_encoded_signature_here",
    "certificateId": "CERT_123456",
    "certificateInfo": {
      "owner": "Người hiến máu",
      "issuedBy": "SmartCA",
      "validFrom": "2024-01-01T00:00:00",
      "validTo": "2025-01-01T00:00:00"
    }
  },
  "message": "Ký số thành công"
}
```

**Response (Error):**
```json
{
  "status": 400,
  "data": null,
  "message": "Lỗi khi ký số: [chi tiết lỗi]"
}
```

### 2. API Endpoint: `GET /api/smartca/certificates`

**Response:**
```json
{
  "status": 200,
  "data": {
    "certificates": [
      {
        "certificateId": "CERT_123456",
        "owner": "Người hiến máu",
        "issuedBy": "SmartCA",
        "validFrom": "2024-01-01T00:00:00",
        "validTo": "2025-01-01T00:00:00",
        "status": "active"
      }
    ]
  }
}
```

### 3. API Endpoint: `POST /api/dang-ky-hien-mau/upload-signature/{registrationId}`

**Request:**
```json
{
  "signatureType": "donor",
  "signature": "base64_encoded_signature_here",
  "signatureInfo": {
    "signedAt": "2024-01-01T12:00:00",
    "certificateId": "CERT_123456",
    "certificateInfo": {...}
  }
}
```

**Response:**
```json
{
  "status": 200,
  "data": {
    "success": true,
    "message": "Chữ ký đã được lưu thành công"
  }
}
```

## 🔧 Backend Code Example (Node.js)

```javascript
// smartca-service.js
const axios = require('axios');

class SmartCAService {
  constructor() {
    this.clientId = process.env.SMARTCA_CLIENT_ID;
    this.clientSecret = process.env.SMARTCA_CLIENT_SECRET;
    this.apiUrl = process.env.SMARTCA_API_URL;
  }

  async sign(dataToSign, signatureType, certificateId) {
    try {
      // 1. Authenticate với SmartCA
      const token = await this.authenticate();
      
      // 2. Gọi API ký số
      const response = await axios.post(
        `${this.apiUrl}/api/sign`,
        {
          data: dataToSign,
          certificateId: certificateId,
          signatureType: signatureType,
        },
        {
          headers: {
            'Authorization': `Bearer ${token}`,
            'Content-Type': 'application/json',
          },
        }
      );

      return {
        success: true,
        signature: response.data.signature,
        certificateId: response.data.certificateId,
        certificateInfo: response.data.certificateInfo,
      };
    } catch (error) {
      return {
        success: false,
        message: error.message,
      };
    }
  }

  async authenticate() {
    // Implement authentication với SmartCA
    // Sử dụng Client ID và Client Secret
    // Return access token
  }
}
```

## 🔧 Backend Code Example (C# .NET)

```csharp
// SmartCAService.cs
public class SmartCAService
{
    private readonly string _clientId;
    private readonly string _clientSecret;
    private readonly string _apiUrl;

    public SmartCAService(IConfiguration configuration)
    {
        _clientId = configuration["SmartCA:ClientId"];
        _clientSecret = configuration["SmartCA:ClientSecret"];
        _apiUrl = configuration["SmartCA:ApiUrl"];
    }

    public async Task<SignResponse> SignAsync(string dataToSign, string signatureType, string certificateId)
    {
        try
        {
            // 1. Authenticate với SmartCA
            var token = await AuthenticateAsync();
            
            // 2. Gọi API ký số
            var client = new HttpClient();
            client.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue("Bearer", token);
            
            var request = new
            {
                data = dataToSign,
                certificateId = certificateId,
                signatureType = signatureType
            };
            
            var response = await client.PostAsJsonAsync($"{_apiUrl}/api/sign", request);
            var result = await response.Content.ReadFromJsonAsync<SignResponse>();
            
            return result;
        }
        catch (Exception ex)
        {
            return new SignResponse
            {
                Success = false,
                Message = ex.Message
            };
        }
    }

    private async Task<string> AuthenticateAsync()
    {
        // Implement authentication với SmartCA
        // Return access token
    }
}
```

## 📋 Checklist cho Backend Team

- [ ] Đăng ký tài khoản SmartCA
- [ ] Nhận Client ID và Client Secret
- [ ] Cấu hình environment variables
- [ ] Implement authentication với SmartCA
- [ ] Implement API endpoint `/api/smartca/sign`
- [ ] Implement API endpoint `/api/smartca/certificates`
- [ ] Implement API endpoint `/api/dang-ky-hien-mau/upload-signature/{registrationId}`
- [ ] Test trên UAT environment
- [ ] Test với mobile app (tắt Mock Mode)
- [ ] Deploy lên production

## 🔗 Links tham khảo

- **Tài liệu Web API:** https://doitac-smartca.vnpt.vn/help/docs/tai-lieu-tich-hop-ky-so/
- **Support:** support@smartca.vnpt.vn

## ⚠️ Lưu ý

1. **Bảo mật:** KHÔNG commit Client Secret vào Git
2. **Test:** Luôn test trên UAT trước
3. **Error Handling:** Xử lý tất cả các trường hợp lỗi
4. **Logging:** Log lại các request/response để debug

