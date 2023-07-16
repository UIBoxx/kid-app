import 'package:flutter/material.dart';
import 'package:kidzworld/trace_and_draw_pages/signature_painter.dart';
import 'package:kidzworld/utils/appbar.dart';

// ignore: must_be_immutable
class TraceCard extends StatefulWidget {
  List<List<Offset>> lines;
  String value;
  final Function(int) updateIsDone;
  final Function(List<List<Offset>>) updateOffset;

  TraceCard({
    super.key,
    required this.lines,
    required this.value,
    required this.updateIsDone,
    required this.updateOffset,
  });

  @override
  _TraceCardState createState() => _TraceCardState();
}

class _TraceCardState extends State<TraceCard> {
  // Add a key for the CustomPaint widget
  Key _customPaintKey = UniqueKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade100,
      appBar: CustomAppBar(
        title: widget.value,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context);
        },
        backgroundColor: Colors.amber.shade200,
        child: Icon(
          Icons.check,
          color:Colors.green.shade400,
        ),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            Card(
              margin: const EdgeInsets.all(8.0),
              elevation: 2,
              child: Center(
                child: Text(
                  widget.value,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: widget.value.length == 1
                          ? MediaQuery.of(context).size.width * 0.8
                          : (widget.value.length <= 2
                              ? MediaQuery.of(context).size.width * 0.5
                              : 60.0),
                      color: Colors.grey.shade300),
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
                      if (widget.lines.isEmpty || widget.lines.last.isEmpty) {
                        widget.lines.add([localPosition]);
                      } else {
                        widget.lines.last.add(localPosition);
                      }
                    }
                    _customPaintKey = UniqueKey();
                  });
                },
                onPanEnd: (DragEndDetails details) {
                  setState(() {
                    widget.lines.add([]);
                    widget.updateIsDone(1);
                    widget.updateOffset(widget.lines);

                    // Change the key of the CustomPaint widget to force a rebuild
                    _customPaintKey = UniqueKey();
                    // db.updateDb();
                  });
                },
                child: CustomPaint(
                  key: _customPaintKey, // Use the key here
                  painter: SignaturePainter(widget.lines),
                  size: Size.infinite,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
