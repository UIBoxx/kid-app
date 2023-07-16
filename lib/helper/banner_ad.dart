import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';


class BannerAds extends StatefulWidget {
  const BannerAds({super.key});

  @override
  State<BannerAds> createState() => _BannerAdsState();
}

class _BannerAdsState extends State<BannerAds> {

  @override
  void initState() {
    super.initState();
    initBannerAd();
  }

  late BannerAd bannerAd;
  bool isAdLoaded = false;
  var adUnit= "ca-app-pub-4520713668416571/9198299489";
  // var adUnit= 'ca-app-pub-3940256099942544/6300978111'; //sample
  
  initBannerAd(){
    bannerAd = BannerAd(
      size: AdSize.banner, 
    adUnitId: adUnit, 
    listener: BannerAdListener(
      onAdLoaded: (ad) {
        setState(() {
          isAdLoaded=true;
        });
      },
      onAdFailedToLoad: (ad,error){
        ad.dispose();
        log(error.toString());
      }

    ), 
    request: const AdRequest()
    );
    bannerAd.load();
  }

  @override
  Widget build(BuildContext context) {
    return
     isAdLoaded?SizedBox(
          height: bannerAd.size.height.toDouble(),
          width: bannerAd.size.width.toDouble(),
          child: AdWidget(ad: bannerAd),
        ):const SizedBox();
  }
  
}

  