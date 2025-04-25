class SinhVien {
  String? maSinhVien;
  String? ten;
  int? tuoi;
  double? diemTrungBinh;

  SinhVien(this.maSinhVien, this.ten, this.tuoi, this.diemTrungBinh);

  void inThongTin() {
    print('$maSinhVien - $ten - $tuoi - $diemTrungBinh');
  }

  bool duocHocBong() {
    return diemTrungBinh! > 8.0;
  }

  void nhanHocBong() {
    print('$maSinhVien - $ten - $diemTrungBinh');
  }
}

void main() {
  List<SinhVien> danhSach = [
    SinhVien('SV001', "Trần Việt Hoàng", 18, 7.9),
    SinhVien('SV002', 'Đàm Đức Hải', 18, 8.9),
    SinhVien('SV003', 'Nguyễn Thành Phong', 18, 9.6),
  ];

  print("Danh sách sinh viên:");
  for (var sv in danhSach) {
    sv.inThongTin();
  }

  print("\nSinh viên đủ điều kiện nhận học bổng:");
  for (var sv in danhSach) {
    if (sv.duocHocBong()) {
      sv.nhanHocBong();
    }
  }
}
