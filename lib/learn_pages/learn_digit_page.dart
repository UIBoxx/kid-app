import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:kidzworld/helper/ads_helper.dart';
import 'package:kidzworld/helper/native_ad_controller.dart';
import 'package:kidzworld/utils/appbar.dart';
import 'package:number_to_words/number_to_words.dart';

class LearnDigits extends StatelessWidget {
  LearnDigits({Key? key}) : super(key: key);

  final _adController = NativeAdController();

  @override
  Widget build(BuildContext context) {
    List digits = [
      '🚗',
      '👵',
      '🎀',
      '🎁',
      '🍔',
      '🛹',
      '🐒',
      '🎻',
      '🎄',
      '🌟',
      '🎈',
      '🌈',
      '🌸',
      '🍦',
      '⚽',
      '📚',
      '🍕',
      '🎮',
      '🎯',
      '🚀'
    ];
    _adController.ad = AdHelper.loadNativeAd(adController: _adController);

    return Scaffold(
      backgroundColor: Colors.amber.shade100,
      appBar: const CustomAppBar(
        title: 'Numbers',
      ),
      bottomNavigationBar:
          _adController.ad != null && _adController.adLoaded.isTrue
              ? SafeArea(
                  child: SizedBox(
                    height: 100,
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: AdWidget(
                      ad: _adController.ad!,
                    ),
                  ),
                )
              : null,
      body: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: 100,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 5),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        '${index + 1}',
                        style: TextStyle(
                          fontSize: 100,
                          fontWeight: FontWeight.bold,
                          color: Colors.amber.shade800,
                        ),
                      ),
                      Text(
                        NumberToWord()
                            .convert('en-in', index + 1)
                            .toUpperCase(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 50,
                          fontWeight: FontWeight.bold,
                          color: Colors.green.shade800,
                        ),
                      ),
                      Text(
                        index < 20 ? '${digits[index]}' * (index + 1) : '',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 30,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
