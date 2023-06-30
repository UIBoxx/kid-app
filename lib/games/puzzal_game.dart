import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:kidzworld/helper/ads_helper.dart';
import 'package:kidzworld/helper/banner_ad.dart';
import 'package:kidzworld/helper/dialogue.dart';
import 'package:kidzworld/utils/grid_puzzal.dart';

class PuzzalGame extends StatefulWidget {
  static const routeName = '/puzzal-game-page';

  const PuzzalGame({super.key});

  @override
  _PuzzalGameState createState() => _PuzzalGameState();
}

class _PuzzalGameState extends State<PuzzalGame> {
  final List<int> _puzzlePieces = [];
  int _emptyIndex = -1;

  @override
  void initState() {
    super.initState();
    _initializePuzzle();
  }

  void _initializePuzzle() {
    _puzzlePieces.clear();
    for (int i = 0; i < 16; i++) {
      _puzzlePieces.add(i);
    }
    _puzzlePieces.shuffle();
    _emptyIndex = _puzzlePieces.indexOf(0);
  }

  void _movePiece(int index) {
    setState(() {
      if (_canMove(index)) {
        int temp = _puzzlePieces[_emptyIndex];
        _puzzlePieces[_emptyIndex] = _puzzlePieces[index];
        _puzzlePieces[index] = temp;
        _emptyIndex = index;
        if (_isSolved()) {
          _showDialog();
        }
      }
    });
  }

  bool _canMove(int index) {
    int row1 = _emptyIndex ~/ 4;
    int col1 = _emptyIndex % 4;
    int row2 = index ~/ 4;
    int col2 = index % 4;
    return (row1 == row2 && (col1 - col2).abs() == 1) ||
        (col1 == col2 && (row1 - row2).abs() == 1);
  }

  bool _isSolved() {
    for (int i = 0; i < 15; i++) {
      if (_puzzlePieces[i] != i + 1) {
        return false;
      }
    }
    return _puzzlePieces[15] == 0;
  }

  void _showDialog() {
    showDialog(
        context: context,
        builder: (context) => Mydialogues.resultDialogue(
                '🏆', 'Congratulations!!!', 'You solved the puzzle.', () {
              _initializePuzzle();
              Navigator.pop(context);
            }, 'Solve Again', Colors.green.shade100));
  }

  void _showInstructions() {
    showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        title: const Center(child: Text('Instructions')),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        children: <Widget>[
          const Instructions(
            bullet: '1',
            text:
                'The objective of the game is to rearrange the puzzle pieces in the correct order.',
          ),
          const Instructions(
            bullet: '2',
            text:
                'Each piece can be moved to an adjacent empty space by tapping on it.',
          ),
          const Instructions(
            bullet: '3',
            text: 'The game is won when all pieces are in the correct order.',
          ),
          const Gap(16),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateColor.resolveWith(
                    (states) {
                      if (states.contains(MaterialState.pressed)) {
                        return Colors.pink.shade400;
                      }
                      return Colors.pink.shade100; // default color
                    },
                  ),
                ),
                // onPressed: () => Navigator.pop(context),
                onPressed: () {
                  AdHelper.showInterstitialAd(
                    onComplete: () => Navigator.pop(context),
                  );
                },
                child: const Text('Close'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink.shade50,
      appBar: AppBar(
        title: const Text('Solve the Puzzal'),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.pink.shade400,
        elevation: 0,
        actions: [
          GestureDetector(
            onTap: () => _showInstructions(),
            child: const Padding(
                padding: EdgeInsets.all(16), child: Icon(Icons.info)),
          ),
        ],
      ),
      bottomNavigationBar: const BannerAds(),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Gap(100),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: SizedBox(
                  height: 400,
                  width: MediaQuery.of(context).size.width,
                  child: CustomGrid(
                    crossAccessCount: 4,
                    istrue: false,
                    itemCount: 16,
                    onTap: (index) => _movePiece(index),
                    color: (index) => _puzzlePieces[index] == 0
                        ? Colors.pink.shade400
                        : Colors.green.shade100,
                    child: (index) => Center(
                      child: Text(
                        _puzzlePieces[index].toString(),
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.pink.shade400,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Instructions extends StatelessWidget {
  final String bullet;
  final String text;
  const Instructions({super.key, required this.bullet, required this.text});

  @override
  Widget build(BuildContext context) {
    return ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.pink.shade100,
          foregroundColor: Colors.pink.shade800,
          child: Text(bullet),
        ),
        title: Text(text));
  }
}
