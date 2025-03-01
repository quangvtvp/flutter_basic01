import 'dart:io';

// Define constants for column widths
const int maSinhVienWidth = 10;
const int hoTenWidth = 20;
const int tuoiWidth = 5;
const int diemWidth = 8;
const int hocBongWidth = 10;

void printHeader() {
  final header = '${'Mã SV'.padRight(maSinhVienWidth)}'
      '${'Họ tên'.padRight(hoTenWidth)}'
      '${'Tuổi'.padRight(tuoiWidth)}'
      '${'Điểm TB'.padRight(diemWidth)}'
      '${'Học Bổng'.padRight(hocBongWidth)}';
  print(header);
  print('-' *
      (maSinhVienWidth + hoTenWidth + tuoiWidth + diemWidth + hocBongWidth));
}

class SinhVien {
  String maSinhVien;
  String hoTen;
  int tuoi;
  double diemTrungBinh;

  SinhVien(this.maSinhVien, this.hoTen, this.tuoi, this.diemTrungBinh);

  bool kiemTraHocBong() => diemTrungBinh >= 8.0;

  void printWithFormat() {
    final row = '${maSinhVien.padRight(maSinhVienWidth)}'
        '${hoTen.padRight(hoTenWidth)}'
        '${tuoi.toString().padRight(tuoiWidth)}'
        '${diemTrungBinh.toString().padRight(diemWidth)}'
        '${(kiemTraHocBong() ? "Có" : "Không").padRight(hocBongWidth)}';
    print(row);
  }
}

// Class to manage student data
class StudentDataSource {
  final List<SinhVien> _students = [
    SinhVien('SV001', 'Nguyễn Văn A', 20, 7.5),
    SinhVien('SV002', 'Trần Thị B', 21, 8.5),
    SinhVien('SV003', 'Lê Văn C', 22, 9.0),
    SinhVien('SV004', 'Phạm Thị D', 23, 6.5),
    SinhVien('SV005', 'Hoàng Văn E', 19, 7.8),
    SinhVien('SV006', 'Đặng Thị F', 20, 8.2),
    SinhVien('SV007', 'Ngô Văn G', 22, 5.9),
    SinhVien('SV008', 'Bùi Thị H', 21, 8.7),
    SinhVien('SV009', 'Trịnh Văn I', 24, 9.1),
    SinhVien('SV010', 'Vũ Thị K', 20, 7.0),
  ];

  // Async method with a simulated 5-second delay
  Future<List<SinhVien>> getAllStudents() async {
    print('Loading...');
    await Future.delayed(const Duration(seconds: 5));
    return _students;
  }
}

void main() async {
  // Create an instance of StudentDataSource
  final dataSource = StudentDataSource();

  // Retrieve the list of students asynchronously
  List<SinhVien> students = await dataSource.getAllStudents();

  // Print initial list of students
  print('--- Danh sách sinh viên ---');
  printHeader();
  for (var student in students) {
    student.printWithFormat();
  }

  while (true) {
    // Show menu
    print('\n--- MENU ---');
    print('1. In ra danh sách sinh viên có học bổng');
    print('2. In ra danh sách sinh viên có tuổi lớn hơn 15');
    print('3. In ra thông tin sinh viên có mã SV = "SV002"');
    print('4. Tìm và in ra thông tin sinh viên theo mã SV nhập từ bàn phím');
    print('5. Thoát');
    stdout.write('Vui lòng chọn [1-5]: ');

    String? choice = stdin.readLineSync();

    switch (choice) {
      case '1':
        // Danh sách SV có học bổng
        print('\n--- Danh sách sinh viên có học bổng ---');
        printHeader();
        for (var sv in students.where((sv) => sv.kiemTraHocBong())) {
          sv.printWithFormat();
        }
        break;

      case '2':
        // Danh sách SV có tuổi > 15
        print('\n--- Danh sách sinh viên có tuổi lớn hơn 15 ---');
        printHeader();
        for (var sv in students.where((sv) => sv.tuoi > 15)) {
          sv.printWithFormat();
        }
        break;

      case '3':
        // Thông tin SV có mã = 'SV002'
        print('\n--- Thông tin SV có mã SV = "SV002" ---');
        final sv002 = students.firstWhere(
          (sv) => sv.maSinhVien == 'SV002',
          orElse: () => SinhVien('N/A', 'Không tìm thấy', 0, 0),
        );
        printHeader();
        sv002.printWithFormat();
        break;

      case '4':
        // Tìm SV theo mã từ bàn phím
        stdout.write('Nhập mã SV cần tìm: ');
        String? inputMaSv = stdin.readLineSync();
        if (inputMaSv != null && inputMaSv.isNotEmpty) {
          final svTimThay = students.firstWhere(
            (sv) => sv.maSinhVien == inputMaSv,
            orElse: () => SinhVien('N/A', 'Không tìm thấy', 0, 0),
          );
          print('\n--- Kết quả tìm kiếm ---');
          printHeader();
          svTimThay.printWithFormat();
        } else {
          print('Mã SV không hợp lệ.');
        }
        break;

      case '5':
        print('Kết thúc chương trình.');
        return;

      default:
        print('Lựa chọn không hợp lệ. Vui lòng thử lại.');
        break;
    }
  }
}
