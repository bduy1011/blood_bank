// Model để lưu thông tin công dân từ QR code CCCD
class Citizen {
  final String idCard; // Số CCCD/Căn cước
  final String? idNumber; // Số định danh (field thứ 2, có thể null)
  final String fullName; // Họ và tên
  final String? dateOfBirth; // Ngày sinh (ddmmyyyy)
  final String? gender; // Giới tính (Nam/Nữ)
  final String? address; // Địa chỉ
  final String? issueDate; // Ngày cấp (ddmmyyyy)

  Citizen({
    required this.idCard,
    this.idNumber,
    required this.fullName,
    this.dateOfBirth,
    this.gender,
    this.address,
    this.issueDate,
  });

  // Parse từ chuỗi QR code
  // Format: ID|?|Full Name|Date of Birth|Gender|Address|Issue Date
  // Ví dụ: 074202000733|281290246|Lê Nguyễn Anh Vũ|16112002|Nam|Tổ 6, Khu Phố 1,, Uyên Hưng, Tân Uyên, Bình Dương|13042021
  factory Citizen.fromQRCode(String qrCode) {
    final parts = qrCode.split("|");
    
    return Citizen(
      idCard: parts.length > 0 ? parts[0].trim() : "",
      idNumber: parts.length > 1 ? parts[1].trim() : null,
      fullName: parts.length > 2 ? parts[2].trim() : "",
      dateOfBirth: parts.length > 3 ? parts[3].trim() : null,
      gender: parts.length > 4 ? parts[4].trim() : null,
      address: parts.length > 5 ? parts[5].trim() : null,
      issueDate: parts.length > 6 ? parts[6].trim() : null,
    );
  }

  // Validate CCCD (9 hoặc 12 ký tự số)
  bool isValidIdCard() {
    if (idCard.isEmpty) return false;
    final isNumeric = RegExp(r'^\d+$').hasMatch(idCard);
    return isNumeric && (idCard.length == 9 || idCard.length == 12);
  }

  // Validate ngày sinh (ddmmyyyy)
  bool isValidDateOfBirth() {
    if (dateOfBirth == null || dateOfBirth!.isEmpty) return false;
    if (dateOfBirth!.length != 8) return false;
    
    try {
      final day = int.parse(dateOfBirth!.substring(0, 2));
      final month = int.parse(dateOfBirth!.substring(2, 4));
      final year = int.parse(dateOfBirth!.substring(4, 8));
      
      if (day < 1 || day > 31) return false;
      if (month < 1 || month > 12) return false;
      if (year < 1900 || year > DateTime.now().year) return false;
      
      return true;
    } catch (e) {
      return false;
    }
  }

  // Validate họ tên (ít nhất 6 ký tự)
  bool isValidFullName() {
    return fullName.trim().length >= 6;
  }

  // Parse ngày sinh thành DateTime
  DateTime? getDateOfBirthAsDateTime() {
    if (!isValidDateOfBirth()) return null;
    
    try {
      final day = int.parse(dateOfBirth!.substring(0, 2));
      final month = int.parse(dateOfBirth!.substring(2, 4));
      final year = int.parse(dateOfBirth!.substring(4, 8));
      return DateTime(year, month, day);
    } catch (e) {
      return null;
    }
  }

  // Format ngày sinh thành dd/mm/yyyy
  String? getFormattedDateOfBirth() {
    if (!isValidDateOfBirth()) return null;
    
    try {
      final day = dateOfBirth!.substring(0, 2);
      final month = dateOfBirth!.substring(2, 4);
      final year = dateOfBirth!.substring(4, 8);
      return "$day/$month/$year";
    } catch (e) {
      return null;
    }
  }

  // Format ngày cấp thành dd/mm/yyyy
  String? getFormattedIssueDate() {
    if (issueDate == null || issueDate!.isEmpty) return null;
    if (issueDate!.length != 8) return issueDate;
    
    try {
      final day = issueDate!.substring(0, 2);
      final month = issueDate!.substring(2, 4);
      final year = issueDate!.substring(4, 8);
      return "$day/$month/$year";
    } catch (e) {
      return issueDate;
    }
  }

  // Validate tất cả thông tin
  bool isValid() {
    return isValidIdCard() && isValidFullName();
  }

  // Lấy danh sách lỗi validation
  List<String> getValidationErrors() {
    final errors = <String>[];
    
    if (!isValidIdCard()) {
      errors.add("Số CCCD/Căn cước không hợp lệ (phải là 9 hoặc 12 ký tự số)");
    }
    
    if (!isValidFullName()) {
      errors.add("Họ tên không hợp lệ (phải có ít nhất 6 ký tự)");
    }
    
    if (dateOfBirth != null && dateOfBirth!.isNotEmpty && !isValidDateOfBirth()) {
      errors.add("Ngày sinh không hợp lệ");
    }
    
    return errors;
  }
}


