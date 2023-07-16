import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:kidzworld/helper/banner_ad.dart';
import 'package:kidzworld/helper/head_lines.dart';
import 'package:kidzworld/utils/functions.dart';

class MyHome extends StatelessWidget {
  const MyHome({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Gap(50),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: CarouselSlider(
                options: CarouselOptions(
                    height: 100.0,
                    autoPlay: true,
                    autoPlayInterval: const Duration(seconds: 3)),
                items: ['Be Creative', 'Learn Anywhere'].map((i) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Card(
                        // color: Colors.green.shade200,
                        elevation: 1,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            textDirection: i == 'Be Creative'
                                ? TextDirection.rtl
                                : TextDirection.ltr,
                            children: [
                              Text(
                                i,
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.green.shade400,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              Image(
                                image: AssetImage(i == 'Be Creative'
                                    ? 'assets/icons/play.png'
                                    : 'assets/icons/learn.png'),
                                width: 100,
                              )
                            ]),
                      );
                    },
                  );
                }).toList(),
              ),
            ),
          ),
          SizedBox(
              height: 200,
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Card(
                  color: Colors.amber.shade600,
                  elevation: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Learn With Fun',
                                style: TextStyle(
                                  fontSize: 25,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              Text(
                                'KidzWorld',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey.shade100,
                                  fontWeight: FontWeight.w200,
                                ),
                              ),
                            ],
                          ),
                          const Image(
                            image: AssetImage('assets/icons/learning.png'),
                            width: 150,
                          )
                        ]),
                  ),
                ),
              )),
          const Gap(16),
          HeadLines.headLine(title: 'Trace & Draw'),
          SizedBox(
            // color: Colors.pink.shade100,
            height: 350,
            width: MediaQuery.of(context).size.width >= 450
                ? 400
                : MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: GridView.count(
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 3,
                children: [
                  Functions.buildOptionContainerWithIcon(
                      context,
                      'Digits',
                      '/digits',
                      FontAwesomeIcons.one,
                      Colors.white,
                      Colors.yellow.shade800),
                  Functions.buildOptionContainerWithIcon(
                      context,
                      'Letters',
                      '/letters',
                      FontAwesomeIcons.a,
                      Colors.white,
                      Colors.green.shade400),
                  Functions.buildOptionContainer(
                      context,
                      'Custom Letter',
                      '/custom-letters',
                      'assets/icons/costLet.png',
                      Colors.cyan.shade400),
                  Functions.buildOptionContainerWithIcon(
                      context,
                      'Drawing',
                      '/drawings',
                      Icons.draw,
                      Colors.blue.shade400,
                      Colors.amber.shade200),
                  Functions.buildOptionContainerWithIcon(
                      context,
                      'HomeWork',
                      '/homework',
                       FontAwesomeIcons.bookOpen,
                      Colors.grey.shade50,
                      Colors.pink.shade200),
                ],
              ),
            ),
          ),
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 16),
          //   child: MyNativeAd(),
          // ),
          // const Gap(50),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: const BannerAds()),
          const Gap(20),
        ],
      ),
    );
  }
}
