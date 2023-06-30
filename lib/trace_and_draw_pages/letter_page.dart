import 'package:flutter/material.dart';
import 'package:kidzworld/trace_and_draw_pages/signature_painter.dart';
import 'package:kidzworld/utils/appbar.dart';

class LettersPage extends StatefulWidget {
  const LettersPage({super.key});

  @override
  _LettersPageState createState() => _LettersPageState();
}

class _LettersPageState extends State<LettersPage> {
  String _selectedLetter = '';
  final List<List<Offset>> _lines = [];

  List symbol = <String>['🍎','🏀','🐈','🐕','🐘','🐟','🐐','🐓','🍦','🏺','🪁','🦁','🐒','👃','🍊','🦜','👑','🌹','🚢','🚂','☔','🚌','⌚','🎹','🦬','🦓'];
  List meaning = <String>['Apple','Ball','Cat','Dog','Elephant','Fish','Goat','Hen','Ice Cream','Jug','Kite','Lion','Monkey','Nose','Orange','Parrot','Queen','Rose','Ship','Train','Umbrella','Van','Watch','Xylophone','Yak','Zebra'];
  int i =0;


  // Add a key for the CustomPaint widget
  Key _customPaintKey = UniqueKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade100,
      appBar: const CustomAppBar(
        title: 'Draw Alphabets',
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
                          Text(symbol[i].toString(),style: const TextStyle(fontSize: 80),),
                          Text(meaning[i],style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.amber.shade800),)
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
                              fontSize: MediaQuery.of(context).size.width*0.5,
                              fontWeight: FontWeight.w300,
                              color: Colors.green.shade100),
                        ),
                        Text(
                          _selectedLetter == '' ? 'a' : _selectedLetter.toLowerCase(),
                           style: TextStyle(
                              fontSize: MediaQuery.of(context).size.width*0.5,
                              fontWeight: FontWeight.w200,
                              color: Colors.pink.shade100),
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
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedLetter =
                            String.fromCharCode('A'.codeUnitAt(0) + index);
                        i=index;
                        _lines.clear();
                        // print(i);
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: _selectedLetter ==
                                String.fromCharCode('A'.codeUnitAt(0) + index)
                            ? Colors.pink.shade400
                            : Colors.green[300],
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: Center(
                        child: Text(
                          String.fromCharCode('A'.codeUnitAt(0) + index),
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                            color: _selectedLetter ==
                                    String.fromCharCode(
                                        'A'.codeUnitAt(0) + index)
                                ? Colors.white
                                : Colors.grey.shade100,
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



