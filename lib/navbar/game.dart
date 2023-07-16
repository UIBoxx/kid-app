import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:kidzworld/helper/banner_ad.dart';
import 'package:kidzworld/helper/head_lines.dart';
import 'package:kidzworld/utils/functions.dart';

class MyGame extends StatelessWidget {
  const MyGame({super.key});

  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Gap(50),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: const BannerAds()),
          const Gap(20),
         HeadLines.headLine(title: 'Play'),
          SizedBox(
            height: 350,
            width: MediaQuery.of(context).size.width >= 450
                ? 400
                : MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: GridView.count(
                crossAxisCount: 3,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  Functions.buildOptionContainerWithIcon(
                      context,
                      'Math Game',
                      '/math-game-page',
                      Icons.calculate,
                      Colors.purple.shade800,
                      Colors.blue.shade400),
                  Functions.buildOptionContainerWithIcon(
                      context,
                      'Words Game',
                      '/words-game-page',
                      FontAwesomeIcons.puzzlePiece,
                      Colors.green.shade200,
                      Colors.red.shade400),
                  Functions.buildOptionContainerWithIcon(
                      context,
                      'Puzzal Game',
                      '/puzzal-game-page',
                      Icons.move_up,
                      Colors.red.shade800,
                      Colors.purple.shade200),
                  Functions.buildOptionContainerWithIcon(
                      context,
                      'Memory Game',
                      '/memory-match-game',
                      Icons.memory,
                      Colors.cyan.shade400,
                      Colors.teal.shade400),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
