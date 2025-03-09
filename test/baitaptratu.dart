import 'dart:async';
import 'dart:convert';
import 'dart:io';

class Vocabulary {
  String englishWord;
  String vietnameseMeaning;

  Vocabulary(this.englishWord, this.vietnameseMeaning);

  void info() {
    print('${englishWord.padRight(10)} : $vietnameseMeaning');
  }
}

class VocabularyDataSource {
  List<Vocabulary> vocabularies = [
    Vocabulary('apple', 'quả táo'),
    Vocabulary('banana', 'quả chuối'),
    Vocabulary('cat', 'con mèo'),
    Vocabulary('dog', 'con chó'),
    Vocabulary('elephant', 'con voi'),
    Vocabulary('fish', 'con cá'),
    Vocabulary('grape', 'quả nho'),
    Vocabulary('house', 'ngôi nhà'),
    Vocabulary('island', 'hòn đảo'),
    Vocabulary('jacket', 'áo khoác'),
  ];
  Future<void> printAllVocabulary() async {
    print("Đang tải danh sách từ vựng...");
    await Future.delayed(Duration(seconds: 2));
    print(' Danh sách từ vựng:');
    for (var word in vocabularies) {
      word.info();
    }
  }

  Future<void> addVocabulary() async {
    print('Nhập từ tiếng Anh:');
    String? englishWord = stdin.readLineSync(encoding: utf8)?.trim();

    print('Nhập nghĩa tiếng Việt:');
    String? vietnameseMeaning = stdin.readLineSync(encoding: utf8)?.trim();

    if (englishWord != null &&
        vietnameseMeaning != null &&
        englishWord.isNotEmpty &&
        vietnameseMeaning.isNotEmpty) {
      print("Đang thêm từ vựng vui lòng chờ");
      await Future.delayed(Duration(seconds: 1));
      vocabularies.add(Vocabulary(englishWord, vietnameseMeaning));
      print('Đã thêm: $englishWord : $vietnameseMeaning');
    } else {
      print('Vui lòng nhập đúng định dạng!');
    }
  }

  Future<void> searchMeaning() async {
    print('Nhập từ cần tra nghĩa:');
    String? wordToSearch = stdin.readLineSync()?.trim().toLowerCase();

    if (wordToSearch != null && wordToSearch.isNotEmpty) {
      var found = vocabularies
          .where((word) => word.englishWord.toLowerCase() == wordToSearch);
      if (found.isNotEmpty) {
        print("Đang tìm kiếm....");
        await Future.delayed(Duration(seconds: 3));
        for (var word in found) {
          print(
              ' Nghĩa của "${word.englishWord}" là: ${word.vietnameseMeaning}');
        }
      } else {
        print('Không tìm thấy từ "$wordToSearch" trong danh sách!');
      }
    } else {
      print('Vui lòng nhập từ cần tra !');
    }
  }
}

void main() async {
  VocabularyDataSource dataSource = VocabularyDataSource();

  while (true) {
    print(' Chọn thao tác:');
    print('1:In toàn bộ từ vựng');
    print('2:Thêm từ mới');
    print('3:Tra nghĩa của từ');
    print('0:Thoát');
    print('Nhập lựa chọn:');

    String? choice = stdin.readLineSync()?.trim();

    if (choice == '1') {
     await  dataSource.printAllVocabulary();
    } else if (choice == '2') {
      await dataSource.addVocabulary();
      } else if (choice == '3') {
      await dataSource.searchMeaning();
    } else if (choice == '0') {
      print('Thoát chương trình. Hẹn gặp lại!');
      break;
    } else {
      print('Lựa chọn không hợp lệ, vui lòng nhập lại!');
    }
  }
}
