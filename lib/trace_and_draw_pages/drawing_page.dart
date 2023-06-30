// ignore_for_file: unused_field

import 'package:flutter/material.dart';
import 'package:kidzworld/utils/appbar.dart';
import 'package:kidzworld/utils/custom_choice.dart';
import 'dart:ui';

class DrawingPage extends StatefulWidget {
  const DrawingPage({super.key});

  @override
  _DrawingPageState createState() => _DrawingPageState();
}

class _DrawingPageState extends State<DrawingPage> {
  final Map<Color, List<Map<String, dynamic>>> _lines = {};
  Color _selectedColor = Colors.black;
  List<Map<String, dynamic>> _currentColorLines = [];
  final double _strokeWidth = 4.0;

  final List<List<Map<String, dynamic>>> _undoneLines = [];
  

  // Add a key for the CustomPaint widget
  Key _customPaintKey = UniqueKey();

  void _selectColor(Color color) {
    setState(() {
      _selectedColor = color;
      if (!_lines.containsKey(_selectedColor)) {
        _lines[_selectedColor] = [];
      }
      _currentColorLines = _lines[_selectedColor]!;
    });
  }

  void _clear() {
    setState(() {
      _lines.clear();
      _currentColorLines.clear();
      _customPaintKey = UniqueKey();
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow.shade100,
      appBar: const CustomAppBar(
        title: 'Draw',
      ),
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: Stack(
              children: [
                Container(),
                Card(
                  margin: const EdgeInsets.all(8.0),
                  elevation: 2,
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
                          if (_currentColorLines.isEmpty) {
                            _currentColorLines.add({
                              'points': [localPosition],
                            });
                          } else {
                            _currentColorLines.last['points']
                                .add(localPosition);
                          }
                        }
                        // Change the key of the CustomPaint widget to force a rebuild
                        _customPaintKey = UniqueKey();
                      });
                    },
                    onPanEnd: (DragEndDetails details) {
                      setState(() {
                        _currentColorLines.add({'points': []});

                        // Change the key of the CustomPaint widget to force a rebuild
                        _customPaintKey = UniqueKey();
                      });
                    },
                    child: CustomPaint(
                      key: _customPaintKey, // Use the key here
                      painter: SignaturePainter(_lines, _selectedColor,_strokeWidth),
                      size: Size.infinite,
                    ),
                  ),
                ),
                Container(),
              ],
            ),
          ),
          SizedBox(
            // flex: 1,
            height: 100,
            width: 300,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _colorButton(Colors.red),
                          _colorButton(Colors.orange),
                          _colorButton(Colors.yellow),
                          _colorButton(Colors.green),
                          _colorButton(Colors.blue),
                          _colorButton(Colors.purple),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _colorButton(Colors.brown),
                          _colorButton(Colors.grey),
                          _colorButton(Colors.black),
                          _colorButton(Colors.white),
                          _colorButton(Colors.pink),
                          _colorButton(Colors.cyan),
                        ],
                      )
                    ],
                  ),
                  CustomChoice(
                    function: ()=>_clear(),
                    height: 60,
                    width: 50,
                    text: '↻',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _colorButton(Color color) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: GestureDetector(
        onTap: () => _selectColor(color),
        child: Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(15.0),
              border: Border.all(color: Colors.pink.shade800, width: 0.1)),
        ),
      ),
    );
  }
}

class SignaturePainter extends CustomPainter {
  final Map<Color, List<Map<String, dynamic>>> lines;
  final Color selectedColor;
  final double _strokeWidth;

  SignaturePainter(this.lines, this.selectedColor, this._strokeWidth);

  @override
  void paint(Canvas canvas, Size size) {
    for (Color color in lines.keys) {
      final paint = Paint()
        ..color = color
        ..strokeWidth = 4
        ..strokeCap = StrokeCap.round;
      for (final line in lines[color]!) {
        if (line['points'].isNotEmpty) {
          List<Offset> points = List<Offset>.from(
              line['points'].map((point) => Offset(point.dx, point.dy)));
          canvas.drawPoints(PointMode.polygon, points, paint);
        }
      }
    }
  }


  @override
  bool shouldRepaint(SignaturePainter oldDelegate) =>
      oldDelegate.lines != lines || oldDelegate.selectedColor != selectedColor;
}
