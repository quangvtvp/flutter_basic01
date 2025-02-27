import 'dart:io';

class SinhVien {
  String maSinhVien;
  String ten;
  int tuoi;
  double diemTrungBinh;

  SinhVien(this.maSinhVien, this.ten, this.tuoi, this.diemTrungBinh);

  // Xác định sinh viên có nhận học bổng không
  bool nhanHocBong() {
    return diemTrungBinh > 8.0;
  }

  // Hiển thị thông tin sinh viên theo hàng, cột
  void hienThiThongTin() {
    print(
        '| ${maSinhVien.padRight(8)} | ${ten.padRight(20)} | ${tuoi.toString().padRight(5)} | ${diemTrungBinh.toStringAsFixed(2).padRight(8)} | ${nhanHocBong() ? "co" : "khong".padRight(12)} |');
  }
}

class StudentDataSource {
  // Lấy danh sách tất cả sinh viên
  static List<SinhVien> getAllStudents() {
    return [
      SinhVien('SV001', "Trần Việt Hoàng", 18, 7.9),
      SinhVien('SV002', 'Đàm Đức Hải', 18, 8.9),
      SinhVien('SV003', 'Nguyễn Thành Phong', 18, 9.6),
      SinhVien('SV004', 'Phạm Thu Hằng', 19, 7.5),
      SinhVien('SV005', 'Lê Hữu Nghĩa', 20, 8.2),
    ];
  }

  // Sắp xếp danh sách theo tiêu chí
  static void sortStudents(List<SinhVien> students, int option) {
    switch (option) {
      case 1:
        students.sort((a, b) => a.ten.compareTo(b.ten));
        break;
      case 2:
        students.sort((a, b) => a.tuoi.compareTo(b.tuoi));
        break;
      case 3:
        students.sort((a, b) => b.diemTrungBinh.compareTo(a.diemTrungBinh));
        break;
      default:
        print("Lựa chọn không hợp lệ!");
        return;
    }
    print("\nDanh sách sau khi sắp xếp:");
    hienThiDanhSach(students);
  }

  // Hiển thị danh sách sinh viên có header row
  static void hienThiDanhSach(List<SinhVien> danhSach) {
    print(
        '+----------+----------------------+-------+---------+--------------+');
    print(
        '| Mã SV    | Họ Tên               | Tuổi  | Điểm TB | Học Bổng     |');
    print(
        '+----------+----------------------+-------+---------+--------------+');

    for (var sv in danhSach) {
      sv.hienThiThongTin();
    }

    print(
        '+----------+----------------------+-------+---------+--------------+\n');
  }

  static void inDanhSachHocBong(List<SinhVien> danhSach) {
    print(" Danh sách sinh viên nhận học bổng:");
    hienThiDanhSach(danhSach.where((sv) => sv.nhanHocBong()).toList());
  }

  static void inDanhSachTuoiLonHon18(List<SinhVien> danhSach) {
    print(" Danh sách sinh viên có tuổi lớn hơn 18:");
    hienThiDanhSach(danhSach.where((sv) => sv.tuoi > 18).toList());
  }

  static void inThongTinTheoMa(List<SinhVien> danhSach, String maSV) {
    SinhVien? sv = danhSach.firstWhere((sv) => sv.maSinhVien == maSV,
        orElse: () => SinhVien("", "", 0, 0.0));
    if (sv.maSinhVien.isNotEmpty) {
      print(" Thông tin sinh viên có mã SV = $maSV:");
      hienThiDanhSach([sv]);
    } else {
      print(" Không tìm thấy sinh viên có mã SV = $maSV!");
    }
  }
}

void main() {
  List<SinhVien> danhSach = StudentDataSource.getAllStudents();

  // Hiển thị danh sách sinh viên ban đầu
  print("Danh sách sinh viên:");
  StudentDataSource.hienThiDanhSach(danhSach);

  // Menu sắp xếp
  while (true) {
    print("Chọn tiêu chí sắp xếp:");
    print("1. Sắp xếp theo họ tên");
    print("2. Sắp xếp theo tuổi");
    print("3. Sắp xếp theo điểm trung bình");
    print("4. In danh sách sinh viên có học bổng");
    print("5. In danh sách sinh viên có tuổi lớn hơn 18");
    print("6. In thông tin sinh viên có mã SV = \"SV002\"");
    print("7. Tìm và in thông tin sinh viên theo mã nhập vào");
    print("8. Thoát");
    stdout.write("Nhập lựa chọn của bạn: ");
    int? choice = int.tryParse(stdin.readLineSync()!);

    if (choice == null || choice == 8) {
      print("Thoát chương trình!");
      break;
    }
    switch (choice) {
      case 4:
        StudentDataSource.inDanhSachHocBong(danhSach);
        break;
      case 5:
        StudentDataSource.inDanhSachTuoiLonHon18(danhSach);
        break;
      case 6:
        StudentDataSource.inThongTinTheoMa(danhSach, "SV002");
        break;
      case 7:
        stdout.write(" Nhập mã sinh viên cần tìm: ");
        String maSV = stdin.readLineSync()!;
        StudentDataSource.inThongTinTheoMa(danhSach, maSV);
        break;
      default:
        print("Lựa chọn không hợp lệ! Vui lòng nhập lại.");
    }
    StudentDataSource.sortStudents(danhSach, choice);
  }
}
