import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:kidzworld/helper/ads_helper.dart';
import 'package:kidzworld/helper/dialogue.dart';
import 'package:kidzworld/utils/appbar.dart';
import 'package:kidzworld/utils/custom_choice.dart';
import 'dart:math';
import 'package:audioplayers/audioplayers.dart';
import 'package:kidzworld/utils/functions.dart';
import 'package:kidzworld/utils/hive_db.dart';

class MathGame extends StatefulWidget {
  static const routeName = '/math-game-page';

  const MathGame({super.key});
  @override
  _MathGameState createState() => _MathGameState();
}

class _MathGameState extends State<MathGame> {
  final Random _random = Random();
  int _num1 = 1;
  int _num2 = 1;
  int _num3 = 1;
  int _num4 = 1;
  String _operation = '+';
  int _answer = 2;
  final List<int> _choices = [];
  int qnCounterForAds = 0;

  final _myMathBox = Hive.box('home_work');

  ScoreDB db = ScoreDB();

  int mathScore = 0;

  @override
  void initState() {
    if (_myMathBox.get("MATH") == null) {
      db.createInitialScore();
    } else {
      db.loadScore();
    }

    super.initState();
    generateQuestion();
  }

  void generateQuestion() {
    // Generate two random numbers between 1 and 10
    _num1 = _random.nextInt(20) + 1;
    _num2 = _random.nextInt(10) + 1;
    _num3 = _random.nextInt(10) + 1;
    _num4 = (_random.nextInt(10) + 1) * _num3;

    // Randomly choose an operation to perform on the numbers
    int operationIndex = _random.nextInt(4);
    switch (operationIndex) {
      case 0:
        _operation = '+';
        _answer = _num1 + _num2;
        break;
      case 1:
        _operation = '-';
        _answer = _num1 - _num2;
        break;
      case 2:
        _operation = '*';
        _answer = _num1 * _num2;
        break;
      case 3:
        _operation = '/';
        _answer = _num4 ~/ _num3;
        break;
    }

    // Generate three possible answer choices, one of which is correct
    _choices.clear();
    _choices.add(_answer);
    while (_choices.length < 3) {
      int choice = _random.nextInt(20) + 1;
      if (!_choices.contains(choice)) {
        _choices.add(choice);
      }
    }
    _choices.shuffle();
  }



  void checkAnswer(int choice) {
    bool isCorrect = (choice == _answer);
    AudioPlayer()
        .play(AssetSource(isCorrect ? 'music/win.mp3' : 'music/loose.mp3'));
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Mydialogues.resultDialogue(
          isCorrect ? '🏆' : '😞',
          isCorrect ? 'Congratulations' : 'oops',
          isCorrect ? 'Correct answer!' : 'Wrong answer, try again!',
          () {
            qnCounterForAds == 10
                ? AdHelper.showInterstitialAd(onComplete: () {
                    Navigator.of(context).pop();
                    setState(() {
                      qnCounterForAds = 0;
                    });
                  })
                : Navigator.of(context).pop();
            if (isCorrect) {
              setState(() {
                db.mathScore += 1;
                qnCounterForAds += 1;
                generateQuestion();
              });
              db.updateScore();
            } else {
              setState(() {
                db.mathScore = db.mathScore > 0 ? db.mathScore - 1 : 0;
              });
              db.updateScore();
            }
          },
          isCorrect ? 'Next' : 'Retry',
          isCorrect ? Colors.green.shade100 : Colors.red.shade100,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple.shade50,
      appBar: CustomAppBar(
        title: 'Math game',
        trailing: '🏆${db.mathScore}',
        alert: ()=>Functions.showAlertSnackbar(context,'Long press to reset score.',Colors.red.shade400),
        function: () {
          setState(() {
            db.mathScore=0;
          });
          Functions.showAlertSnackbar(context,'Score reset successful.',Colors.green.shade400);
          db.updateScore();
        },
      ),

      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              const Gap(50),
              Column(
                children: [
                  const Gap(50),
                  Text(
                    _operation == "/"
                        ? '$_num4 / $_num3 '
                        : '$_num1 $_operation $_num2',
                    style: TextStyle(
                        color: Colors.purple.shade600,
                        fontSize: MediaQuery.of(context).size.width * 0.25,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '=?',
                    style: TextStyle(
                        color: Colors.purple.shade600,
                        fontSize: MediaQuery.of(context).size.width * 0.25,
                        fontWeight: FontWeight.bold),
                  ),
                  const Gap(25),
                  const Gap(50),
                ],
              ),
              Text('Choose your answer:',
                  style: Theme.of(context).textTheme.headlineSmall),
              const Gap(16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CustomChoice(
                    function: () => checkAnswer(_choices[0]),
                    height: 80,
                    width: 80,
                    text: '${_choices[0]}',
                  ),
                  const Gap(16),
                  CustomChoice(
                    function: () => checkAnswer(_choices[1]),
                    height: 80,
                    width: 80,
                    text: '${_choices[1]}',
                  ),
                  const Gap(16),
                  CustomChoice(
                    function: () => checkAnswer(_choices[2]),
                    height: 80,
                    width: 80,
                    text: '${_choices[2]}',
                  ),
                ],
              ),
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
      ),
    );
  }
}

