import 'dart:math';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:kidzworld/utils/appbar.dart';

class LearnSubtraction extends StatelessWidget {
  const LearnSubtraction({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> emo = ['🍔', '🎄', '🏀', '🤖', '🎁', '🎻', '🍎', '🚕'];
    TextStyle myStyle = TextStyle(
      fontSize: 30,
      fontWeight: FontWeight.bold,
      color: Colors.amber.shade800,
    );
    TextStyle myEmo = TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: Colors.amber.shade800,
      letterSpacing: 3,
    );

    Random random = Random();

    return Scaffold(
      backgroundColor: Colors.pink.shade100,
      appBar: const CustomAppBar(
        title: 'Subtraction',
      ),
      body: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: 8,
        itemBuilder: (context, i) {
          int number1 = random.nextInt(10) + 1;
          int number2 = random.nextInt(number1 + 1);

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                height: 250,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('$number1 - $number2', style: myStyle),
                          Text(
                            '= ${number1 - number2}',
                            style: myStyle,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            emo[i] * number1,
                            style: myEmo,
                            textAlign: TextAlign.end,
                          ),
                          const Gap(10),
                          Text(
                            '- ${emo[i] * number2}',
                            style: myEmo,
                            textAlign: TextAlign.justify,
                          ),
                          const Gap(10),
                          Text('||', style: myStyle),
                          const Gap(10),
                          Text(
                            emo[i] * (number1 - number2),
                            style: myEmo,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
