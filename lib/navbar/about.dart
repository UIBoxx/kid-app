import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:kidzworld/helper/ads_helper.dart';
import 'package:kidzworld/helper/head_lines.dart';
import 'package:kidzworld/helper/native_ad.dart';
import 'package:kidzworld/utils/functions.dart';

class MyAbout extends StatelessWidget {
  const MyAbout({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Gap(100),
          HeadLines.headLine(title: 'About Us'),
          SizedBox(
            height: 200,
            // color: Colors.pink.shade100,
            width: MediaQuery.of(context).size.width >= 450
                ? 400
                : MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: GridView.count(
                crossAxisCount: 3,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  GestureDetector(
                    onTap: () {
                      AdHelper.showInterstitialAd(onComplete: () async {
                        await Navigator.pushNamed(context, '/about-page');
                      });
                    },
                    child: Functions.aboutOptionContainerWithIcon(
                        context,
                        'About',
                        Icons.info,
                        Colors.cyan.shade200,
                        Colors.pink.shade400),
                  ),
                ],
              ),
            ),
          ),
          MyNativeAd(),
        ],
      ),
    );
  }
}
