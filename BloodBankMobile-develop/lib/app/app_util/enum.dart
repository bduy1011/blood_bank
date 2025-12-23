class TinhTrangDangKyHienMau {
  final String description;
  final int value;

  const TinhTrangDangKyHienMau._(this.description, this.value);

  static const DaDangKy = TinhTrangDangKyHienMau._("Đã đăng ký", 1);
  static const Huy = TinhTrangDangKyHienMau._("Huỷ", 2);
  static const DaTiepNhan = TinhTrangDangKyHienMau._("Đã tiếp nhận", 3);

  static const values = [DaDangKy, Huy, DaTiepNhan];
}

class NhomMau {
  final String description;
  final int value;

  const NhomMau._(this.description, this.value);

  static const Atru = NhomMau._("A Rh-", 600);
  static const Acong = NhomMau._("A Rh+", 6200);
  static const Btru = NhomMau._("B Rh-", 1700);
  static const Bcong = NhomMau._("B Rh+", 7300);
  static const ABtru = NhomMau._("AB Rh-", 2800);
  static const ABcong = NhomMau._("AB Rh+", 8400);
  static const Otru = NhomMau._("O Rh-", 9500);
  static const Ocong = NhomMau._("O Rh+", 5100);
  static const KXD = NhomMau._("Chưa xác định", -1);

  static const values = [
    Atru,
    Acong,
    Btru,
    Bcong,
    ABtru,
    ABcong,
    Otru,
    Ocong,
    KXD
  ];
}

class LoaiSanPham {
  final String description;
  final int value;

  const LoaiSanPham._(this.description, this.value);

  static const Others = LoaiSanPham._("Khác", 0);
  static const BachCau = LoaiSanPham._("Bạch cầu", 1);
  static const Ffp = LoaiSanPham._("Huyết tương tươi đông lạnh", 2);
  static const HongCauLang = LoaiSanPham._("Hồng cầu lắng", 3);
  static const HongCauRua = LoaiSanPham._("Hồng cầu rửa", 4);
  static const MauToanPhan = LoaiSanPham._("Máu toàn phần", 5);
  static const PlasmaLt = LoaiSanPham._("Huyết tương đông lạnh", 6);
  static const TieuCau = LoaiSanPham._("Tiểu cầu", 7);
  static const TieuCauApheresis = LoaiSanPham._("Tiểu cầu apheresis", 8);
  static const YeuToViii = LoaiSanPham._("Yếu tố VIII", 9);
  static const Phenotype = LoaiSanPham._("Phenotype", 12);

  static const values = [
    Others,
    BachCau,
    Ffp,
    HongCauLang,
    HongCauRua,
    MauToanPhan,
    PlasmaLt,
    TieuCau,
    TieuCauApheresis,
    YeuToViii,
    Phenotype,
  ];
}

// {
// [Description("Chờ xác nhận")]
// ChoXacNhan = 1,
// [Description("Duyệt một phần")]
// DuyetMotPhan = 2,
// [Description("Đã duyệt")]
// DaDuyet = 3,
// [Description("Huỷ")]
// Huy = 4,
// [Description("Từ chối")]
// TuChoi = 5
// }
class TinhTrangGiaoDich {
  final String description;
  final int value;

  const TinhTrangGiaoDich._(this.description, this.value);

  static const ChoXacNhan = TinhTrangGiaoDich._("Chờ xác nhận", 1);
  static const DuyetMotPhan = TinhTrangGiaoDich._("Duyệt một phần", 2);
  static const DaDuyet = TinhTrangGiaoDich._("Đã duyệt", 3);
  static const Huy = TinhTrangGiaoDich._("Huỷ", 4);
  static const TuChoi = TinhTrangGiaoDich._("Từ chối", 5);

  static const values = [ChoXacNhan, DaDuyet, TuChoi];
}

class TinhTrangDotLayMau {
  final String description;
  final int value;

  const TinhTrangDotLayMau._(this.description, this.value);

  static const TaoDotMoi = TinhTrangDotLayMau._("Tạo mới", 10);
  static const DaChot = TinhTrangDotLayMau._("Đã chốt", 20);
  static const Huy = TinhTrangDotLayMau._("Huỷ", 100);

  static const values = [TaoDotMoi, DaChot, Huy];
}

class KetQuaXetNghiem {
  final String description;
  final int value;

  const KetQuaXetNghiem._(this.description, this.value);

  static const ChuaXetNghiem = KetQuaXetNghiem._("Chưa xét nghiệm", 10);
  static const AmTinh = KetQuaXetNghiem._("Không phản ứng", 20);
  static const DuongTinh = KetQuaXetNghiem._("Phản ứng", 30);
  static const ChuaXacDinh = KetQuaXetNghiem._("Chưa xác định", 40);
  static const ChoKetQua = KetQuaXetNghiem._("Chờ kết quả", 90);

  static const values = [
    ChuaXetNghiem,
    AmTinh,
    DuongTinh,
    ChuaXacDinh,
    ChoKetQua,
  ];
}

class LoaiDotLayMau {
  final String description;
  final int value;

  const LoaiDotLayMau._(this.description, this.value);

  static const LuuDong = LoaiDotLayMau._("Lưu động", 10);
  static const TaiCho = LoaiDotLayMau._("Tại chỗ", 20);

  static const values = [LuuDong, TaiCho];
}

class LoaiMau {
  final String description;
  final int value;

  const LoaiMau._(this.description, this.value);

  static const MauMau = LoaiMau._("Mẫu máu", 10);
  static const TieuCau = LoaiMau._("Tiểu cầu", 20);

  static const values = [MauMau, TieuCau];
}

class AppRole {
  final String description;
  final int value;

  const AppRole._(this.description, this.value);

  static const Admin = AppRole._("Admin", 10);
  static const Manager = AppRole._("Quản lý", 20);
  static const User = AppRole._("User thường / người hiến máu", 30);
  static const DangKyMuaMau = AppRole._("Đăng ký mua máu", 40);

  static const values = [Admin, Manager, User, DangKyMuaMau];
}

class LoaiPhieu {
  final String description;
  final int value;

  const LoaiPhieu._(this.description, this.value);

  static const PhieuNhuongMau = LoaiPhieu._("Phiếu nhượng máu", 1);

  static const values = [PhieuNhuongMau];
}

class SurveyQuestionAttribute {
  final String description;
  final int value;

  const SurveyQuestionAttribute._(this.description, this.value);

  static const InputDate = SurveyQuestionAttribute._("Nhập ngày", 1);
  static const InputText = SurveyQuestionAttribute._("Nhập text", 2);

  static const values = [InputDate, InputText];
}
