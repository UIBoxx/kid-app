import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:kidzworld/helper/ads_helper.dart';
import 'package:kidzworld/helper/native_ad_controller.dart';

class MyNativeAd extends StatelessWidget {
  MyNativeAd({super.key});
  final _adController = NativeAdController();

  @override
  Widget build(BuildContext context) {
    _adController.ad = AdHelper.loadNativeAd(adController: _adController);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: SizedBox(
        height:  _adController.ad != null && _adController.adLoaded.isTrue?100:10,
        width: MediaQuery.of(context).size.width * 0.9,
        child: _adController.ad != null && _adController.adLoaded.isTrue
            ? AdWidget(
                ad: _adController.ad!,
              )
            : null,
      ),
    );
  }
}
