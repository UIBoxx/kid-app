import 'package:hive_flutter/hive_flutter.dart';

class HomeWorkDb {
  List myHomework = [];

  final _myBox = Hive.box('home_work');

  void createInitialData() {
    myHomework = [
      ['क'],
      ['ख'],
      ['ग'],
      ['१'],
      ['२'],
      ['३'],
      ['अ'],
      ['आ'],
      ['इ'],
    ];
  }

  void loadDb() {
    myHomework = _myBox.get("HOMEWORK");
  }

  void updateDb() {
    _myBox.put("HOMEWORK", myHomework);
  }
}

class ScoreDB {
  int wordsScore = 0;
  int mathScore = 0;
  final _myScoreBox = Hive.box('home_work');

  void createInitialScore() {
    wordsScore = 0;
    mathScore = 0;
  }

  void loadScore() {
    wordsScore = _myScoreBox.get("WORDS");
    mathScore = _myScoreBox.get("MATH");
  }

  void updateScore() {
    _myScoreBox.put("WORDS", wordsScore);
    _myScoreBox.put("MATH", mathScore);
  }
}

class OthersDB {
  List<dynamic> others = [];

  final _myOtherBox = Hive.box('home_work');

  void createInitialOtherData() {
    others = 
    [
      // {
      //   'name':"Birds",
      //   'imageFile':"assets/icons/birds.png"
      // },
      // {
      //   'name':"Animals",
      //   'imageFile':"assets/icons/animals.png"
      // }
    ];
  }

  void loadOtherDb() {
    others = _myOtherBox.get("OTHERS");
  }

  void updateOtherDb() {
    _myOtherBox.put("OTHERS", others);
  }
}
