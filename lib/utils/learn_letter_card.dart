import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:kidzworld/utils/appbar.dart';

// ignore: must_be_immutable
class LearnLetterCard extends StatelessWidget {
  final List<List<String>> alphabet;
  int itemCount;
  Color color;
  String title;
  Color scaffoldBg;
  final dynamic speak;
  bool isHindi;
  LearnLetterCard(
      {super.key,
      required this.alphabet,
      required this.itemCount,
      required this.color,
      required this.title,
      required this.scaffoldBg,
      this.speak,
      required this.isHindi});

  @override
  Widget build(BuildContext context) {
    FlutterTts flutterTts = FlutterTts();

    return Scaffold(
      backgroundColor: scaffoldBg,
      appBar: CustomAppBar(
        title: title,
      ),
      body: ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: itemCount,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: GestureDetector(
                onTap: () async {
                  if (speak != null && isHindi) {
                    await flutterTts.setLanguage('ne-NP');
                    await flutterTts.speak(alphabet[index][1] != 'अः'
                        ? '${alphabet[index][0]} बा ट, ${speak[index][1].toUpperCase()}'
                        : 'अह');
                  } else {
                    await flutterTts.setLanguage('en-US');
                    await flutterTts.setSpeechRate(0);
                    await flutterTts.speak(
                        '${alphabet[index][0]} for ${speak[index][1].toUpperCase()}');
                  }
                },
                child: Card(
                    child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Container(
                            height: 80,
                            width: 80,
                            decoration: BoxDecoration(
                              color: color,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Center(
                              child: Text(
                                alphabet[index][0],
                                style: const TextStyle(
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Center(
                            child: Text(
                              alphabet[index][1].toUpperCase(),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: Colors.amber.shade800,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: SizedBox(
                            width: 120,
                            child: Center(
                              child: Text(
                                alphabet[index][2],
                                style: const TextStyle(
                                  fontSize: 50,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )),
              ),
            );
          }),
    );
  }
}
