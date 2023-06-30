import 'package:flutter/material.dart';
import 'package:kidzworld/games/complete_words_game.dart';
import 'package:kidzworld/games/math_game.dart';
import 'package:kidzworld/games/memory_game.dart';
import 'package:kidzworld/games/puzzal_game.dart';
import 'package:kidzworld/helper/ads_helper.dart';
import 'package:kidzworld/learn_pages/addition_learn.dart';
import 'package:kidzworld/learn_pages/fruits_and_veg.dart';
import 'package:kidzworld/learn_pages/learn_alphabet_page.dart';
import 'package:kidzworld/learn_pages/learn_animals.dart';
import 'package:kidzworld/learn_pages/learn_birds.dart';
import 'package:kidzworld/learn_pages/learn_digit_page.dart';
import 'package:kidzworld/learn_pages/learn_tables.dart';
import 'package:kidzworld/learn_pages/nepali_vowels.dart';
import 'package:kidzworld/learn_pages/subtraction_learn.dart';
import 'package:kidzworld/learn_pages/vehicles_learn.dart';
import 'package:kidzworld/trace_and_draw_pages/custom_letter.dart';
import 'package:kidzworld/trace_and_draw_pages/drawing_page.dart';
import 'package:kidzworld/trace_and_draw_pages/letter_page.dart';
import 'package:kidzworld/trace_and_draw_pages/number_page.dart';
import 'package:kidzworld/pages/about_page.dart';
import 'package:kidzworld/pages/homepage.dart';
import 'package:flutter/services.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await AdHelper.initAds();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const MyApp());
}

 class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "KidzWorld - Learn with Fun",
      home: const HomePage(),
      routes: {
          AboutPage.routeName: (ctx) => const AboutPage(),
          '/math-game-page': (context) => const MathGame(),
          '/learn-animals': (context) => const MyAnimals(),
          '/learn-birds': (context) => const MyBirds(),
          '/fruits-veg': (context) => const FruitsAndVegetables(),
          '/vehicles': (context) => const MyVehicles(),
          '/digits': (context) => const DigitsPage(),
          '/learn-digits': (context) => LearnDigits(),
          '/learn-additions':(context) => const LearnAddition(),
          '/learn-subtractions':(context)=> const LearnSubtraction(),
          '/learn-nepali-vowels': (context) => const NepaliVowelsLearn(),
          '/learn-tables': (context) => const TableLearn(),
          '/custom-letters': (context) => const CustomLetterPage(),
          '/letters': (context) => const LettersPage(),
          '/learn-letters': (context) => const LearnLetters(),
          '/drawings': (context) => const DrawingPage(),
          '/puzzal-game-page': (context) => const PuzzalGame(),
          '/words-game-page': (context) =>  const WordsGamePage(),
          '/memory-match-game': (context) => const MemoryMatchGame(),
        },
    );
  }
}