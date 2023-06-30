import 'package:flutter/material.dart';

class SignaturePainter extends CustomPainter {
  final List<List<Offset>> lines;

  SignaturePainter(this.lines);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.pink.shade800
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 10.0;
    for (int i = 0; i < lines.length; i++) {
      for (int j = 0; j < lines[i].length - 1; j++) {
        canvas.drawLine(lines[i][j], lines[i][j + 1], paint);
      }
    }
  }

  @override
  bool shouldRepaint(SignaturePainter oldDelegate) => true;
}