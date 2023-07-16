import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:kidzworld/utils/appbar.dart';
import 'package:flutter_tts/flutter_tts.dart';

class PictureCard extends StatelessWidget {
  final List objects;
  final String title;
  final Color scaffoldBg;

  const PictureCard({
    Key? key,
    required this.objects,
    required this.title,
    required this.scaffoldBg,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FlutterTts flutterTts = FlutterTts();

    Future<void> speakText(String text) async {
      await flutterTts.setLanguage('en-US');
      await flutterTts.speak(text.toUpperCase());
    }

    Future<void> showImageDialog(BuildContext context, String imagePath) async {
      return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            child: Image.asset(imagePath),
          );
        },
      );
    }

    return Scaffold(
      backgroundColor: scaffoldBg,
      appBar: CustomAppBar(title: title),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          itemCount: objects.length,
          physics: const BouncingScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 1,
          ),
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () => speakText(objects[index][1]),
              onLongPress: () => showImageDialog(context, objects[index][0]),
              child: Card(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: Image.asset(
                        objects[index][0],
                        width: 100,
                        height: 80,
                        fit: BoxFit.contain,
                      ),
                    ),
                    const Gap(2),
                    Text(
                      '${objects[index][1]}',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.green.shade800,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
