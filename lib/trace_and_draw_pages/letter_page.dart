import 'dart:async';
import 'package:flutter/material.dart';
import 'package:kidzworld/trace_and_draw_pages/signature_painter.dart';
import 'package:kidzworld/utils/appbar.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:kidzworld/utils/data.dart';

class LettersPage extends StatefulWidget {
  const LettersPage({Key? key}) : super(key: key);

  @override
  _LettersPageState createState() => _LettersPageState();
}

class _LettersPageState extends State<LettersPage> {
  FlutterTts flutterTts = FlutterTts();
  String _selectedLetter = 'A';
  final Map<String, List<List<Offset>>> _drawnLines =
      {}; // Map to store drawn lines for each letter
  List letters = Data.alphabet;
  int i = 0;
  Timer? _timer;
  int _remainingTime = 20;
  bool _timerRunning = false;

  int time=20;

  // Add a key for the CustomPaint widget
  Key _customPaintKey = UniqueKey();

  List<List<Offset>> _lines = [];

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _stopTimer();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_remainingTime > 0 && _timerRunning) {
          _remainingTime--;
        } else if (_remainingTime == 0) {
          _remainingTime = time;
          _saveDrawnLines(_selectedLetter,
              _lines); // Save the drawn lines for the current letter
          i = (i + 1) % letters.length;
          _selectedLetter = letters[i][0];
          _lines = _drawnLines[_selectedLetter] ??
              []; // Retrieve the saved drawn lines for the next letter
          flutterTts.speak(_selectedLetter);
        }
      });
    });
  }

  void _stopTimer() {
    _timer?.cancel();
  }

  void _toggleTimer() {
    setState(() {
      _timerRunning = !_timerRunning;
    });
  }

  void _saveDrawnLines(String letter, List<List<Offset>> lines) {
    setState(() {
      _drawnLines[letter] = lines;
    });
  }

  void timer() {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      int newTime = time;
      return AlertDialog(
        title: const Text('Update Time'),
        content: TextField(
          keyboardType: TextInputType.number,
          onChanged: (value) {
            newTime = int.tryParse(value) ?? 0;
          },
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: const Text('Update'),
            onPressed: () {
              setState(() {
                time = newTime;
                _remainingTime= newTime;
              });
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade100,
      appBar: CustomAppBarWithTimmer(
        title:'Alphabets' , 
        trailing: IconButton(
          icon: _timerRunning ? const Icon(Icons.pause) : const Icon(Icons.play_arrow),
          onPressed: () {
            _toggleTimer();
          },
        ),
        time: _remainingTime,
        timer: timer,
        isRunning: _timerRunning,
        undo: () {
          setState(() {
            _lines = [];
          });
        },
        refresh: () {
          setState(() {
            _lines.clear();
            _drawnLines.clear();
          });
        },
      ),
      body: Column(
        children: [
          Expanded(
            flex: 3,
            child: Stack(
              children: [
                Card(
                  elevation: 2,
                  margin: const EdgeInsets.all(8.0),
                  child: Container(
                    alignment: const Alignment(0.8, -0.8),
                    child: SizedBox(
                      height: 150,
                      width: 150,
                      child: Column(
                        children: [
                          Text(
                            letters[i][2],
                            style: const TextStyle(fontSize: 80),
                          ),
                          Text(
                            letters[i][1],
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.amber.shade800,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          _selectedLetter == '' ? 'A' : _selectedLetter,
                          style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width * 0.5,
                            fontWeight: FontWeight.w300,
                            color: Colors.green.shade100,
                          ),
                        ),
                        Text(
                          _selectedLetter == ''
                              ? 'a'
                              : _selectedLetter.toLowerCase(),
                          style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width * 0.5,
                            fontWeight: FontWeight.w200,
                            color: Colors.pink.shade100,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: GestureDetector(
                    onPanUpdate: (DragUpdateDetails details) {
                      setState(() {
                        RenderBox? referenceBox =
                            context.findRenderObject() as RenderBox?;
                        if (referenceBox != null) {
                          double widthRatio =
                              referenceBox.size.width / context.size!.width;
                          double heightRatio =
                              referenceBox.size.height / context.size!.height;
                          Offset localPosition = Offset(
                            details.localPosition.dx * widthRatio,
                            details.localPosition.dy * heightRatio,
                          );
                          if (_lines.isEmpty || _lines.last.isEmpty) {
                            _lines.add([localPosition]);
                          } else {
                            _lines.last.add(localPosition);
                          }
                        }

                        // Change the key of the CustomPaint widget to force a rebuild
                        _customPaintKey = UniqueKey();
                      });
                    },
                    onPanEnd: (DragEndDetails details) {
                      setState(() {
                        _lines.add([]);
                        _saveDrawnLines(_selectedLetter,
                            _lines); // Save the drawn lines for the selected letter
                        // Change the key of the CustomPaint widget to force a rebuild
                        _customPaintKey = UniqueKey();
                      });
                    },
                    child: CustomPaint(
                      key: _customPaintKey, // Use the key here
                      painter: SignaturePainter(_lines),
                      size: Size.infinite,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.count(
                physics: const BouncingScrollPhysics(),
                crossAxisCount: 8,
                mainAxisSpacing: 5.0,
                crossAxisSpacing: 5.0,
                children: List.generate(26, (index) {
                  final letter = String.fromCharCode('A'.codeUnitAt(0) + index);
                  final isLetterSelected = _selectedLetter == letter;
                  final hasDrawnLines = _drawnLines.containsKey(letter) &&
                      _drawnLines[letter]!
                          .isNotEmpty; // Check if lines are not empty

                  return GestureDetector(
                      onTap: () async {
                        setState(() {
                          _selectedLetter = letter;
                          i = index;
                          _remainingTime = time;
                          _lines = _drawnLines[letter] ?? [];
                        });
                        await flutterTts.setLanguage('en-US');
                        await flutterTts.speak(_selectedLetter);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: isLetterSelected
                              ? Colors.pink.shade400
                              : hasDrawnLines
                                  ? Colors.green.shade400
                                  : Colors.white,
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        child: Center(
                          child: Text(
                            letter,
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                              color: isLetterSelected
                                  ? Colors.white
                                  : hasDrawnLines
                                      ? Colors.green.shade800
                                      : Colors.grey.shade500,
                            ),
                          ),
                        ),
                      ));
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
