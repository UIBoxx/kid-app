import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:kidzworld/helper/native_ad_controller.dart';

class AdHelper{

  static Future<void> initAds() async{
  await MobileAds.instance.initialize();
  }

  static void showInterstitialAd({required VoidCallback onComplete}) {
    
    InterstitialAd.load(
      // adUnitId: 'ca-app-pub-3940256099942544/1033173712', //sample
      adUnitId: 'ca-app-pub-4520713668416571/4431326025',
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (ad) {
              onComplete();
            },
          );
            ad.show();
        },
        onAdFailedToLoad: (err) {
          log('Failed to load an interstitial ad: ${err.message}');
          onComplete();
        },
      ),
    );
  }


  static NativeAd loadNativeAd({required NativeAdController adController}) {
     return NativeAd(
        // adUnitId: 'ca-app-pub-3940256099942544/2247696110', //sample
        adUnitId: 'ca-app-pub-4520713668416571/3002748182',
        listener: NativeAdListener(
          onAdLoaded: (ad) {
            adController.adLoaded.value = true;
            log('$NativeAd loaded.');
          },
          onAdFailedToLoad: (ad, error) {
            // Dispose the ad here to free resources.
            log('$NativeAd failed to load: $error');
            ad.dispose();
          },
        ),
        request: const AdRequest(),
        // Styling
        nativeTemplateStyle: NativeTemplateStyle(
            // Required: Choose a template.
            templateType: TemplateType.small,
           ))
      ..load();
  } 
}