import 'package:flutter/material.dart';
import 'package:kidzworld/utils/data.dart';
import 'package:kidzworld/utils/learn_letter_card.dart';

class NepaliVowelsLearn extends StatelessWidget {
  const NepaliVowelsLearn({super.key});

  @override
  Widget build(BuildContext context) {
    
    return LearnLetterCard(
      alphabet: Data.nepaliVowels,
      itemCount: Data.nepaliVowels.length,
      color: Colors.cyan.shade400,
      title: 'Nepali Vowels',
      scaffoldBg: Colors.cyan.shade100,
    );
  }
}
