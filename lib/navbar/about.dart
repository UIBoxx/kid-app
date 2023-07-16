import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:kidzworld/helper/ads_helper.dart';
import 'package:kidzworld/helper/banner_ad.dart';
import 'package:kidzworld/helper/head_lines.dart';
import 'package:kidzworld/helper/native_ad.dart';
import 'package:kidzworld/utils/functions.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> _launchInBrowser(Uri url) async {
  if (!await launchUrl(
    url,
    mode: LaunchMode.externalApplication,
  )) {
    throw 'Could not launch $url';
  }
}

class MyAbout extends StatefulWidget {
  const MyAbout({super.key});

  @override
  State<MyAbout> createState() => _MyAboutState();
}

class _MyAboutState extends State<MyAbout> {
  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    Future<void>? launched;
    final Uri privacy = Uri(
        scheme: 'https',
        host: 'bprabin811.github.io',
        path: 'kidzworld-privacy-policy');

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
                        Icons.info_outline_rounded,
                        Colors.cyan.shade200,
                        Colors.pink.shade400),
                  ),
                  GestureDetector(
                    onTap: () => setState(() {
                      launched = _launchInBrowser(privacy);
                    }),
                    child: Functions.aboutOptionContainerWithIcon(
                      context,
                      "Privacy Policy",
                      Icons.privacy_tip_outlined,
                      Colors.amber.shade800,
                      Colors.green.shade200,
                    ),
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
