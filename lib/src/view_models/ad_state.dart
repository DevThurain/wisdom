import 'dart:io';

import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdState {
  Future<InitializationStatus> initialization;
  AdState(this.initialization);

// testing
//ca-app-pub-3940256099942544/6300978111
  String bannerAdUnitId() {
    if (Platform.isAndroid) {
      return 'ca-app-pub-5465614411199588/3355237171';
      //return '';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-3940256099942544/2934735716';
    } else {
      throw UnsupportedError('Unsupported platform');
    }
  }

//testing
//ca-app-pub-3940256099942544/1033173712
  String interstitialAdUnitId() {
    if (Platform.isAndroid) {
      return "ca-app-pub-5465614411199588/5806657616";
      //return '';
    } else if (Platform.isIOS) {
      return "ca-app-pub-3940256099942544/4411468910";
    } else {
      throw UnsupportedError("Unsupported platform");
    }
  }

  BannerAdListener get bannerAdListner => _bannerAdListener;

  final BannerAdListener _bannerAdListener = BannerAdListener(
    onAdOpened: (ad) => print('Ad open: ${ad.adUnitId}.'),
    onAdLoaded: (ad) => print('Ad loaded: ${ad.adUnitId}.'),
    onAdClosed: (ad) => print('Ad closed: ${ad.adUnitId}.'),
    onAdFailedToLoad: (ad, error) => print('Ad fail to load: ${ad.adUnitId}. $error'),
  );
}
