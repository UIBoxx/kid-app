import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:kidzworld/helper/head_lines.dart';
import 'package:kidzworld/utils/functions.dart';

class MyLearn extends StatelessWidget {
  const MyLearn({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    final options = [
      Functions.buildOptionContainer(
        context,
        'Learn Digits',
        '/learn-digits',
        'assets/icons/num.png',
        Colors.yellow.shade800,
      ),
      Functions.buildOptionContainer(
        context,
        'Learn Letters',
        '/learn-letters',
        'assets/icons/alphabets.png',
        Colors.green.shade400,
      ),
      Functions.buildOptionContainer(
        context,
        'Nepali Vowels',
        '/learn-nepali-vowels',
        'assets/icons/aaa.png',
        Colors.cyan.shade400,
      ),
      Functions.buildOptionContainerWithIcon(
        context,
        'Additions',
        '/learn-additions',
        FontAwesomeIcons.plus,
        Colors.white,
        Colors.teal.shade400,
      ),
      Functions.buildOptionContainerWithIcon(
        context,
        'Subtractions',
        '/learn-subtractions',
        FontAwesomeIcons.minus,
        Colors.white,
        Colors.red.shade200,
      ),
      Functions.buildOptionContainer(
        context,
        'Table',
        '/learn-tables',
        'assets/icons/table.png',
        Colors.pink.shade800,
      ),
      Functions.buildOptionContainer(
        context,
        'Animals',
        '/learn-animals',
        'assets/icons/animals.png',
        Colors.yellow.shade600,
      ),
      Functions.buildOptionContainer(
        context,
        'Birds',
        '/learn-birds',
        'assets/icons/birds.png',
        Colors.brown.shade500,
      ),
      Functions.buildOptionContainer(
        context,
        'Fruits And Vegetables',
        '/fruits-veg',
        'assets/icons/fandv.png',
        Colors.green.shade600,
      ),
      Functions.buildOptionContainerWithIcon(
        context,
        'Vehicles',
        '/vehicles',
        Icons.directions_car,
        Colors.yellow.shade600,
        Colors.grey.shade500,
      ),
    ];

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Gap(100),
          HeadLines.headLine(title: 'Learn'),
          SizedBox(
            height: 600,
            width: MediaQuery.of(context).size.width >= 450
                ? 400
                : MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: GridView.count(
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 3,
                children: options,
              ),
            ),
          ),

        ],
      ),
    );
  }
}
