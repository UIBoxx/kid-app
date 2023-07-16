import 'package:flutter/material.dart';
import 'package:kidzworld/trace_and_draw_pages/signature_painter.dart';
import 'package:kidzworld/utils/appbar.dart';
import 'dart:async';
import 'package:number_to_words/number_to_words.dart';
import 'package:flutter_tts/flutter_tts.dart';

class DigitsPage extends StatefulWidget {
  const DigitsPage({super.key});

  @override
  _DigitsPageState createState() => _DigitsPageState();
}

class _DigitsPageState extends State<DigitsPage> {
  FlutterTts flutterTts = FlutterTts();
  int _selectedDigit = 0;

  final Map<int, List<List<Offset>>> _drawnLines = {};

  
  List<List<Offset>> _lines = [];

  int i = 0;
  Timer? _timer;
  int _remainingTime = 20;
  bool _timerRunning = false;
  int time=20;

  // Add a key for the CustomPaint widget
  Key _customPaintKey = UniqueKey();

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
           _saveDrawnLines(_selectedDigit,
              _lines);
          i = (i + 1) % 100;
          _selectedDigit = i;
          // _lines.clear();
          _lines = _drawnLines[_selectedDigit] ??
              [];
          flutterTts.speak('$_selectedDigit');
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

  void _saveDrawnLines(int letter, List<List<Offset>> lines) {
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
      backgroundColor: Colors.amber.shade100,
      appBar: CustomAppBarWithTimmer(
        title: 'Numbers',
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
                  child: Center(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            _selectedDigit == -1
                                ? 'one'
                                : NumberToWord()
                                    .convert('en-in', _selectedDigit)
                                    .toUpperCase(),
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.displayMedium,
                          ),
                          Text(
                            _selectedDigit == -1
                                ? '1'
                                : _selectedDigit.toString(),
                            style: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.8,
                                fontWeight: FontWeight.w300,
                                color: Colors.green.shade100),
                          ),
                        ],
                      ),
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

                         _saveDrawnLines(_selectedDigit ,
                            _lines);

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
                children: List.generate(100, (index) {

                  final isDigitSelected = _selectedDigit == index;
                  final hasDrawnLines = _drawnLines.containsKey(index) &&
                      _drawnLines[index]!
                          .isNotEmpty; 

                  return GestureDetector(
                    onTap: () async {
                      setState(() {
                        _selectedDigit = index;
                        i = index;
                        _remainingTime = time;
                         _lines = _drawnLines[index] ?? [];
                      });
                      await flutterTts.setLanguage('en-US');
                      await flutterTts.speak('$_selectedDigit');
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: isDigitSelected
                              ? Colors.pink.shade400
                              : hasDrawnLines
                                  ? Colors.green.shade400
                                  : Colors.white,
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      child: Center(
                        child: Text(
                          index.toString(),
                          style: TextStyle(
                            fontSize: 16.0,
                             color: isDigitSelected
                                  ? Colors.white
                                  : hasDrawnLines
                                      ? Colors.green.shade800
                                      : Colors.grey.shade500,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
