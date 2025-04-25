import 'dart:io';

class SinhVien {
  String maSinhVien;
  String ten;
  int tuoi;
  double diemTrungBinh;

  SinhVien(this.maSinhVien, this.ten, this.tuoi, this.diemTrungBinh);

  // Hiển thị thông tin sinh viên theo hàng, cột
  void hienThiThongTin() {
    print(
        '| ${maSinhVien.padRight(8)} | ${ten.padRight(20)} | ${tuoi.toString().padRight(5)} | ${diemTrungBinh.toStringAsFixed(2).padRight(8)} |');
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
    print('+----------+----------------------+-------+---------+');
    print('| Mã SV    | Họ Tên               | Tuổi  | Điểm TB |');
    print('+----------+----------------------+-------+---------+');

    for (var sv in danhSach) {
      sv.hienThiThongTin();
    }

    print('+----------+----------------------+-------+---------+\n');
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
    print("4. Thoát");
    stdout.write("Nhập lựa chọn của bạn: ");
    int? choice = int.tryParse(stdin.readLineSync()!);

    if (choice == null || choice == 4) {
      print("Thoát chương trình!");
      break;
    }

    StudentDataSource.sortStudents(danhSach, choice);
  }
}
