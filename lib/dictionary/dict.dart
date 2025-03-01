import 'dart:async';
import 'dart:io';

class Vocabulary {
  String englishWord;
  String vietnameseMeaning;

  Vocabulary(this.englishWord, this.vietnameseMeaning);

  void printInfo() {
    print('Từ vựng: $englishWord - Nghĩa: $vietnameseMeaning');
  }

  void updateMeaning(String newMeaning) {
    vietnameseMeaning = newMeaning;
  }
}

class VocabularyDataSource {
  final List<Vocabulary> _vocabList = [
    Vocabulary('apple', 'quả táo'),
    Vocabulary('banana', 'quả chuối'),
    Vocabulary('house', 'ngôi nhà'),
    Vocabulary('university', 'trường đại học'),
    Vocabulary('student', 'học sinh, sinh viên'),
    Vocabulary('teacher', 'giáo viên'),
    Vocabulary('laptop', 'máy tính xách tay'),
    Vocabulary('bicycle', 'xe đạp'),
    Vocabulary('rainbow', 'cầu vồng'),
    Vocabulary('butterfly', 'con bướm'),
  ];

  // Lấy toàn bộ danh sách (async)
  Future<List<Vocabulary>> getAllVocabularies() async {
    print('Loading all vocabularies...');
    // Giả lập độ trễ 2 giây
    await Future.delayed(const Duration(seconds: 2));
    return _vocabList;
  }

  // Thêm một từ vựng mới (async)
  Future<void> addNewVocabulary(Vocabulary newVocab) async {
    print('Adding new vocabulary "${newVocab.englishWord}"...');
    // Giả lập độ trễ 1 giây
    await Future.delayed(const Duration(seconds: 1));
    _vocabList.add(newVocab);
  }

  // Tìm từ vựng theo englishWord (async)
  Future<Vocabulary?> searchVocabulary(String englishWord) async {
    print('Searching for "$englishWord"...');
    // Giả lập độ trễ 1.5 giây
    await Future.delayed(const Duration(milliseconds: 1500));
    for (var vocab in _vocabList) {
      if (vocab.englishWord.toLowerCase() == englishWord.toLowerCase()) {
        return vocab;
      }
    }
    return null;
  }
}

void main() async {
  final dataSource = VocabularyDataSource();

  while (true) {
    // Hiển thị menu
    print('\n--- MENU ---');
    print('1. Hiển thị tất cả từ vựng');
    print('2. Thêm từ vựng mới');
    print('3. Tìm kiếm từ vựng');
    stdout.write('Chọn [1-3], hoặc nhập phím khác để thoát: ');
    final choice = stdin.readLineSync();

    switch (choice) {
      case '1':
        // Lấy danh sách và hiển thị
        final vocabList = await dataSource.getAllVocabularies();
        print('\n--- DANH SÁCH TỪ VỰNG ---');
        for (var vocab in vocabList) {
          vocab.printInfo();
        }
        break;

      case '2':
        // Thêm một từ mới
        stdout.write('\nNhập từ tiếng Anh: ');
        final newEnglish = stdin.readLineSync();
        stdout.write('Nhập nghĩa tiếng Việt: ');
        final newVietnamese = stdin.readLineSync();

        if (newEnglish != null && newVietnamese != null) {
          await dataSource.addNewVocabulary(
            Vocabulary(newEnglish, newVietnamese),
          );
          print('Đã thêm từ vựng.');
        } else {
          print('Dữ liệu không hợp lệ, không thể thêm.');
        }
        break;

      case '3':
        // Tìm kiếm
        stdout.write('\nNhập từ tiếng Anh cần tìm: ');
        final searchWord = stdin.readLineSync();
        if (searchWord != null && searchWord.isNotEmpty) {
          final found = await dataSource.searchVocabulary(searchWord);
          if (found != null) {
            print('Đã tìm thấy:');
            found.printInfo();
          } else {
            print('Không tìm thấy từ vựng này.');
          }
        } else {
          print('Bạn chưa nhập từ để tìm.');
        }
        break;

      default:
        // Người dùng nhập ngoài [1-3], thoát chương trình
        print('Kết thúc chương trình.');
        return;
    }
  }
}
