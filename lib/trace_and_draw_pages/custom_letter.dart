import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:kidzworld/trace_and_draw_pages/signature_painter.dart';
import 'package:kidzworld/utils/appbar.dart';
import 'package:kidzworld/utils/custom_choice.dart';

class CustomLetterPage extends StatefulWidget {
  const CustomLetterPage({super.key});

  @override
  _CustomLetterPageState createState() => _CustomLetterPageState();
}

class _CustomLetterPageState extends State<CustomLetterPage> {
  String _selectedLetter = '';
  final List<List<Offset>> _lines = [];
  

  // Add a key for the CustomPaint widget
  Key _customPaintKey = UniqueKey();

  final TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyan.shade100,
      appBar: const CustomAppBar(
        title: 'Draw Custom Letters',
      ),
      body: Column(
        children: [
          Expanded(
            flex: 4,
            child: Stack(
              children: [
                Card(
                  margin: const EdgeInsets.all(8.0),
                  elevation: 2,
                  child: Center(
                    child: Text(
                      _selectedLetter == '' ? 'क' : _selectedLetter,
                      style: TextStyle(
                          fontSize: _selectedLetter.length == 1
                              ? MediaQuery.of(context).size.width * 0.8
                              : (_selectedLetter.length <= 2
                                  ? MediaQuery.of(context).size.width * 0.5
                                  : 60.0),
                          fontWeight: FontWeight.w300,
                          color: Colors.grey.shade400),
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
            flex: 2,
            child: Center(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Enter a letter or digit to draw:',
                      style: TextStyle(fontSize: 18.0),
                    ),
                    const Gap(16),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.5,
                      decoration: BoxDecoration(
                          color: Colors.pink.shade50,
                          borderRadius: BorderRadius.circular(10)),
                      child: TextField(
                        controller: _textEditingController,
                        // maxLength: 36,
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 25.0),
                        decoration: const InputDecoration(
                            hintText: 'क',
                            contentPadding: EdgeInsets.all(10),
                            border: InputBorder.none),
                        onChanged: (text) {
                          setState(() {
                            _selectedLetter = text;
                            _lines.clear();
                          });
                        },
                      ),
                    ),
                    const Gap(16),
                    CustomChoice(
                        function: () {
                          setState(() {
                            _selectedLetter = _textEditingController.text;
                            _lines.clear();
                          });
                        },
                        text: '🖋️',
                        height: 50,
                        width: 60),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
