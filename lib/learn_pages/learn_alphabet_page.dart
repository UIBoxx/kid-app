import 'package:flutter/material.dart';
import 'package:kidzworld/utils/data.dart';
import 'package:kidzworld/utils/learn_letter_card.dart';

class LearnLetters extends StatelessWidget {
  const LearnLetters({super.key});

  @override
  Widget build(BuildContext context) {
    
    return LearnLetterCard(
      alphabet: Data.alphabet,
      itemCount: Data.alphabet.length,
      color: Colors.green.shade400,
      title: 'English Alphabets',
      scaffoldBg: Colors.green.shade100,
    );
  }
}
