class DetailedTransactions {
  final int giaoDichChiTietId;
  final int giaoDichId;
  final String loaiSanPham;
  final int soLuong;
  final bool daDuyet;
  final String dienGiai;
  final String giaoDich;

  DetailedTransactions({
    required this.giaoDichChiTietId,
    required this.giaoDichId,
    required this.loaiSanPham,
    required this.soLuong,
    required this.daDuyet,
    required this.dienGiai,
    required this.giaoDich,
  });

  factory DetailedTransactions.fromJson(Map<String, dynamic> json) {
    return DetailedTransactions(
      giaoDichChiTietId: json['giaoDichChiTietId'],
      giaoDichId: json['giaoDichId'],
      loaiSanPham: json['loaiSanPham'],
      soLuong: json['soLuong'],
      daDuyet: json['daDuyet'],
      dienGiai: json['dienGiai'],
      giaoDich: json['giaoDich'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'giaoDichChiTietId': giaoDichChiTietId,
      'giaoDichId': giaoDichId,
      'loaiSanPham': loaiSanPham,
      'soLuong': soLuong,
      'daDuyet': daDuyet,
      'dienGiai': dienGiai,
      'giaoDich': giaoDich,
    };
  }
}
