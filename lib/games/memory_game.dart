import 'dart:async';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:kidzworld/helper/ads_helper.dart';
import 'package:kidzworld/helper/dialogue.dart';
import 'package:kidzworld/utils/appbar.dart';
import 'package:kidzworld/utils/custom_choice.dart';
import 'package:kidzworld/utils/grid_puzzal.dart';

class MemoryMatchGame extends StatefulWidget {
  static const routeName = '/memory-match-game';

  const MemoryMatchGame({super.key});
  @override
  _MemoryMatchGameState createState() => _MemoryMatchGameState();
}

class _MemoryMatchGameState extends State<MemoryMatchGame> {
  List<int> _items = [];
  List<int> _pickedItems = [];
  int _selectedCount = 0;
  int _firstSelectedIndex = -1;
  int _secondSelectedIndex = -1;
  bool _gameOver = false;
  Timer? _timer;
  int _elapsedSeconds = 0;
  int crossAccessCount = 3;

  int elementsCount = 12;

  void _generateElements(int elementCount) {
    setState(() {
      _items = List.generate(
          elementCount, (index) => index % (elementCount ~/ 2) + 1)
        ..shuffle();
      _pickedItems = List.filled(elementCount, 0);
      _selectedCount = 0;
      _firstSelectedIndex = -1;
      _secondSelectedIndex = -1;
      _gameOver = false;
      _elapsedSeconds = 0;
      _timer?.cancel();
      _startTimer();
    });
  }

  @override
  void initState() {
    super.initState();
    _generateElements(elementsCount);
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() {
        _elapsedSeconds++;
      });
    });
  }

  void _restart() {
    _generateElements(_items.length);
  }

  void _handleItemTap(int index) {
    if (_pickedItems[index] == 0 && !_gameOver) {
      setState(() {
        _pickedItems[index] = _items[index];
        _selectedCount++;
        if (_selectedCount == 1) {
          _firstSelectedIndex = index;
        } else if (_selectedCount == 2) {
          _secondSelectedIndex = index;
          if (_firstSelectedIndex != -1 && _secondSelectedIndex != -1) {
            if (_pickedItems[_firstSelectedIndex] ==
                _pickedItems[_secondSelectedIndex]) {
              _pickedItems[_firstSelectedIndex] = -1;
              _pickedItems[_secondSelectedIndex] = -1;
              if (_pickedItems.every((item) => item == -1)) {
                _gameOver = true;
                _timer?.cancel();

                // Show congratulatory dialog box
                showDialog(
                  context: context,
                  builder: (context) {
                    return Mydialogues.resultDialogue(
                      '🏅',
                      'Congratulations!',
                      'You completed this level in $_elapsedSeconds seconds.',
                      () {
                        AdHelper.showInterstitialAd(onComplete: () {
                          Navigator.pop(context);

                          if (elementsCount < 42) {
                            crossAccessCount = crossAccessCount + 1;
                            elementsCount =
                                crossAccessCount * (crossAccessCount + 1);
                            _generateElements(elementsCount);
                          } else {
                            _restart();
                          }
                        });
                      },
                      'Next',
                      Colors.green.shade100,
                    );
                  },
                );
              }
            } else {
              Timer(const Duration(milliseconds: 300), () {
                setState(() {
                  for (int i = 0; i < _pickedItems.length; i++) {
                    if (_pickedItems[i] > 0 && _pickedItems[i] != -1) {
                      _pickedItems[i] = 0;
                    }
                  }
                  _firstSelectedIndex = -1;
                  _secondSelectedIndex = -1;
                });
              });
            }
          } else {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content:
                  const Text('Please select only two grid items at a time.'),
              backgroundColor: Colors.red.shade400,
            ));
          }
          _selectedCount = 0;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    List<String> emojis = [
      '🚁',
      '🌺',
      '🏵️',
      '🍄',
      '🌲',
      '🌳',
      '🌴',
      '🌍',
      '🦖',
      '🛩️',
      '🦅',
      '🍎',
      '🍖',
      '🏡',
      '🎁',
      '🏀',
      '🎸',
      '🎧',
      '⏱️',
      '🐒',
      '🛸',
      '🏅'
    ];
    return Scaffold(
      backgroundColor: Colors.teal.shade50,
      appBar: const CustomAppBar(title: 'Match the Cards'),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            const Gap(20),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                '⌛ $_elapsedSeconds seconds',
                style: TextStyle(fontSize: 20, color: Colors.pink.shade800),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: CustomGrid(
                  crossAccessCount: crossAccessCount,
                  istrue: true,
                  itemCount: _items.length,
                  onTap: (index) {
                    _handleItemTap(index);
                  },
                  color: (index) => _pickedItems[index] == -1
                      ? Colors.green.shade400
                      : _pickedItems[index] == 0
                          ? Colors.amber.shade200
                          : Colors.white,
                  child: (index) => Center(
                    child: _pickedItems[index] == 0
                        ? null
                        : _pickedItems[index] == -1
                            ? Text(
                                '✔️',
                                style: TextStyle(
                                    fontSize: elementsCount < 27 ? 60 : 40,
                                    color: Colors.amber),
                              ) // Show close icon for unmatched items
                            : Text(
                                _pickedItems[index] == 1
                                    ? emojis[0]
                                    : emojis[_pickedItems[index] - 1],
                                style: TextStyle(
                                  fontSize: elementsCount < 27 ? 60 : 40,
                                  color: Colors.teal,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                  ),
                ),
              ),
            ),
            CustomChoice(
              function: () => _restart(),
              text: '↻',
              height: 80,
              width: 80,
            ),
          ],
        ),
      ),
    );
  }
}
