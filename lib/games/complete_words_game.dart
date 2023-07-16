import 'dart:math';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:kidzworld/helper/ads_helper.dart';
import 'package:kidzworld/helper/dialogue.dart';
import 'package:kidzworld/utils/appbar.dart';
import 'package:kidzworld/utils/custom_choice.dart';
import 'package:kidzworld/utils/data.dart';
import 'package:kidzworld/utils/functions.dart';
import 'package:kidzworld/utils/hive_db.dart';

class WordsGamePage extends StatefulWidget {
  static const routeName = '/words-game-page';

  const WordsGamePage({super.key});

  @override
  _WordsGamePageState createState() => _WordsGamePageState();
}

class _WordsGamePageState extends State<WordsGamePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final Random _random = Random();
  String _category = 'fruits';
  String _word = '';
  String _originalWord = '';
  String _originalEmo = '';
  int _missingIndex = 0;
  final List<String> _choices = [];
  int qnCounterForAds = 0;

  final _myScoreBox = Hive.box('home_work');
  ScoreDB db = ScoreDB();
  int score = 0;

  @override
  void initState() {
    if (_myScoreBox.get("WORDS") == null) {
      db.createInitialScore();
    } else {
      db.loadScore();
    }
    super.initState();
    generateQuestion();
  }

  void generateQuestion() {
    // Select a random category
    _category = [
      'fruits & vegetables',
      'animals',
      'vehicles',
      'birds'
    ][_random.nextInt(4)];

    // Select a random word from the category
    List<List<dynamic>> categoryWords;
    switch (_category) {
      case 'fruits & vegetables':
        categoryWords = Data.fruitsAndVegetablesData;
        break;
      case 'animals':
        categoryWords = Data.animalsData;
        break;
      case 'vehicles':
        categoryWords = Data.vehiclesData;
        break;
      case 'birds':
        categoryWords = Data.birdsData;
      default:
        categoryWords = [
          ['assets/birds/sparrow.jpg', 'Tree']
        ];
        break;
    }
    int indexValue = _random.nextInt(categoryWords.length);
    _originalWord = categoryWords[indexValue][1];
    _originalEmo = categoryWords[indexValue][0];
    _word = _originalWord;

    // Randomly select a letter to remove from the word
    _missingIndex = _random.nextInt(_word.length);
    _word = _word.replaceRange(_missingIndex, _missingIndex + 1, '_');

    // Generate three answer choices, one of which is correct
    _choices.clear();
    _choices.add(_originalWord.substring(_missingIndex, _missingIndex + 1));
    while (_choices.length < 3) {
      String choice = String.fromCharCode(_random.nextInt(26) + 97);
      if (choice != _originalWord[_missingIndex] &&
          !_choices.contains(choice)) {
        _choices.add(choice);
      }
      if (_choices.length == 3 && _choices.toSet().length != 3) {
        // If any of the choices are duplicates, start over
        _choices.clear();
        _choices.add(_originalWord.substring(_missingIndex, _missingIndex + 1));
      }
    }
    _choices.shuffle();
  }

  void checkAnswer(String choice) {
    bool isCorrect = choice == _originalWord[_missingIndex];
    AudioPlayer()
        .play(AssetSource(isCorrect ? 'music/win.mp3' : 'music/loose.mp3'));
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Mydialogues.resultDialogue(
            isCorrect ? '🏆' : '🥺',
            isCorrect ? 'Welldone' : 'Oops',
            isCorrect ? 'Correct answer.' : 'Wrong answer, try again.', () {
          qnCounterForAds == 8
              ? AdHelper.showInterstitialAd(onComplete: () {
                  Navigator.of(context).pop();
                  setState(() {
                    qnCounterForAds = 0;
                  });
                })
              : Navigator.of(context).pop();
          if (isCorrect) {
            setState(() {
              generateQuestion();
              db.wordsScore += 1;
              qnCounterForAds += 1;
            });
            db.updateScore();
          } else {
            setState(() {
              db.wordsScore = db.wordsScore > 0 ? db.wordsScore - 1 : 0;
            });
            db.updateScore();
          }
        }, isCorrect ? 'Next' : 'Retry',
            isCorrect ? Colors.green.shade50 : Colors.red.shade100);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      key: _scaffoldKey,
      appBar: CustomAppBar(
        title: 'Find Missing  Letter',
        trailing: '🏆${db.wordsScore}',
        alert: () => Functions.showAlertSnackbar(
            context, 'Long press to reset score', Colors.red.shade400),
        function: () {
          setState(() {
            db.wordsScore = 0;
          });
          Functions.showAlertSnackbar(
              context, 'Score reset successful.', Colors.green.shade400);
          db.updateScore();
        },
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            const Gap(100),
            ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Image.asset(
                _originalEmo,
                width: 150,
                fit: BoxFit.contain,
              ),
            ),
            const Gap(16),
            Text(
              _word.toUpperCase(),
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 50.0,
                  letterSpacing: 5,
                  fontWeight: FontWeight.bold,
                  color: Colors.pink.shade800),
            ),
            const Gap(25),
            Text(
              'category: $_category'.toUpperCase(),
              style: TextStyle(
                  color: Colors.green.shade400,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
            const Gap(25),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomChoice(
                  function: () => checkAnswer(_choices[0]),
                  text: _choices[0].toUpperCase(),
                  height: 80,
                  width: 80,
                ),
                const Gap(16),
                CustomChoice(
                  function: () => checkAnswer(_choices[1]),
                  text: _choices[1].toUpperCase(),
                  height: 80,
                  width: 80,
                ),
                const Gap(16),
                CustomChoice(
                  function: () => checkAnswer(_choices[2]),
                  text: _choices[2].toUpperCase(),
                  height: 80,
                  width: 80,
                ),
              ],
            ),
            const Gap(25),
            TextButton(
              onPressed: () {
                setState(() {
                  generateQuestion();
                });
              },
              child: Text(
                'Skip this question',
                style: TextStyle(color: Colors.red.shade400),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
