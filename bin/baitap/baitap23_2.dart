import 'dart:io';
import 'dart:convert';

class Vocabulary {
  String englishWord;
  String vietnameseMeaning;

  Vocabulary(this.englishWord, this.vietnameseMeaning);

  void printInfo() {
    print(
        "| ${englishWord.padRight(15)} | ${vietnameseMeaning.padRight(20)} |");
  }
}

class VocabularyDataSource {
  List<Vocabulary> vocabList = [];

  VocabularyDataSource() {
    vocabList = [
      Vocabulary("apple", "quả táo"),
      Vocabulary("banana", "quả chuối"),
      Vocabulary("cat", "con mèo"),
      Vocabulary("dog", "con chó"),
      Vocabulary("elephant", "con voi"),
      Vocabulary("flower", "bông hoa"),
      Vocabulary("guitar", "đàn guitar"),
      Vocabulary("house", "ngôi nhà"),
      Vocabulary("internet", "mạng internet"),
      Vocabulary("jungle", "rừng rậm"),
    ];
  }

  Future<List<Vocabulary>> getAllVocabularies() async {
    await Future.delayed(Duration(seconds: 2));
    return vocabList;
  }

  Future<void> addNewVocabulary(Vocabulary newVocab) async {
    await Future.delayed(Duration(seconds: 1));
    vocabList.add(newVocab);
    print(" Đã thêm: ${newVocab.englishWord} - ${newVocab.vietnameseMeaning}");
  }

  Future<Vocabulary?> searchVocabulary(String englishWord) async {
    await Future.delayed(Duration(seconds: 1));
    return vocabList.firstWhere(
        (vocab) => vocab.englishWord.toLowerCase() == englishWord.toLowerCase(),
        orElse: () => Vocabulary("", ""));
  }

  void printVocabularyList() {
    print("+-----------------+----------------------+");
    print("| English Word    | Vietnamese Meaning   |");
    print("+-----------------+----------------------+");

    for (var vocab in vocabList) {
      vocab.printInfo();
    }

    print("+-----------------+----------------------+\n");
  }

  Future<void> updateVocabulary(String englishWord, String newMeaning) async {
    await Future.delayed(Duration(seconds: 1));
    for (var vocab in vocabList) {
      if (vocab.englishWord.toLowerCase() == englishWord.toLowerCase()) {
        vocab.vietnameseMeaning = newMeaning;
        print("Đã cập nhật từ '$englishWord' thành: $newMeaning");
        return;
      }
    }
  }
}

Future<void> main() async {
  VocabularyDataSource vocabDataSource = VocabularyDataSource();

  print(" Đang tải danh sách từ vựng...");
  await vocabDataSource.getAllVocabularies();
  vocabDataSource.printVocabularyList();

  while (true) {
    print(" Chọn thao tác:");
    print("1 Thêm từ mới");
    print("2 Tìm kiếm từ vựng");
    print("3 Hiển thị danh sách từ vựng");
    print("4 cập nhận nghĩa mới");
    print("5 Thoát chương trình");
    stdout.write(" Nhập lựa chọn: ");

    String? choice = stdin.readLineSync(encoding: utf8);

    switch (choice) {
      case "1":
        stdout.write(" Nhập từ tiếng Anh mới: ");
        String? newEnglishWord = stdin.readLineSync(encoding: utf8);
        stdout.write(" Nhập nghĩa tiếng Việt: ");
        String? newVietnameseMeaning = stdin.readLineSync(encoding: utf8);

        if (newEnglishWord != null && newVietnameseMeaning != null) {
          await vocabDataSource.addNewVocabulary(
              Vocabulary(newEnglishWord, newVietnameseMeaning));
        }
        break;

      case "2":
        stdout.write(" Nhập từ cần tìm kiếm: ");
        String? searchTerm = stdin.readLineSync(encoding: utf8);

        if (searchTerm != null) {
          print(" Đang tìm kiếm '$searchTerm'...");
          Vocabulary? foundVocab =
              await vocabDataSource.searchVocabulary(searchTerm);

          if (foundVocab != null && foundVocab.englishWord.isNotEmpty) {
            print(" Tìm thấy từ vựng:");
            print("+-----------------+----------------------+");
            print("| English Word    | Vietnamese Meaning   |");
            print("+-----------------+----------------------+");
            foundVocab.printInfo();
            print("+-----------------+----------------------+\n");
          } else {
            print(" Không tìm thấy từ '$searchTerm'.");
          }
        }
        break;

      case "3":
        vocabDataSource.printVocabularyList();
        break;
      case "4":
        stdout.write(" Nhập từ tiếng Anh cần cập nhật: ");
        String? updateWord = stdin.readLineSync(encoding: utf8);
        stdout.write(" Nhập nghĩa tiếng Việt mới: ");
        String? newMeaning = stdin.readLineSync(encoding: utf8);

        if (updateWord != null && newMeaning != null) {
          await vocabDataSource.updateVocabulary(updateWord, newMeaning);
        }
        break;

      case "5":
        print("Thoát chương trình!");
        return;

      default:
        print("Lựa chọn không hợp lệ. Vui lòng nhập lại!");
    }
  }
}
