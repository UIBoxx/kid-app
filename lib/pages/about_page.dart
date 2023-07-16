import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:kidzworld/helper/banner_ad.dart';
import 'package:kidzworld/helper/native_ad.dart';
import 'package:kidzworld/utils/appbar.dart';

class AboutPage extends StatelessWidget {
  static const routeName = '/about-page';

  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink.shade50,
      appBar: const CustomAppBar(title: 'About Us',),
       bottomNavigationBar: const BannerAds(),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Gap(25),
            MyNativeAd(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: const Image(
                    image: AssetImage('assets/icons/logo.png'),
                    width: 100,
                  )),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Text(
                'Learn with Fun',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.pink.shade800,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              child: Text(
                'Welcome to KidzWorld! \nOur app offers a fun and interactive way for kids to learn tracing, recognize letters, pronounce them, and explore math concepts like addition and subtraction. They can also discover various animals, birds, vehicles, flowers, and more. Additionally, our app features entertaining and logic-based games to enhance cognitive skills and critical thinking. \nJoin us now and embark on a captivating learning adventure!',
                textAlign: TextAlign.justify,
                style: TextStyle(fontSize: 14, color: Colors.grey.shade800),
              ),
            ),
            const Gap(20),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: SelectableText.rich(
                TextSpan(
                  text: 'Email us at ',
                  style: TextStyle(fontSize: 18, color: Colors.black),
                  children: <TextSpan>[
                    TextSpan(
                      text: 'kidzworld095@gmail.com',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                    TextSpan(
                      text: ' for support or feedback.',
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              ),
            ),
            const Gap(30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Copyright © 2023 ProWin',
                style: TextStyle(fontSize: 16, color: Colors.pink.shade400),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
