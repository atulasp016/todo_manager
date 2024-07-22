import 'package:flutter/cupertino.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdsHelper {
  late InterstitialAd interstitialAd;

  static String get bannerUnitId => 'ca-app-pub-3940256099942544/6300978111';
  static String get interstitialUnitId =>
      'ca-app-pub-3940256099942544/1033173712';

  static initialization() {
    if (MobileAds.instance == null) {
      MobileAds.instance.initialize();
    }
  }

  static BannerAd getBannerAd() {
    BannerAd bannerAd = BannerAd(
      adUnitId: bannerUnitId,
      request: const AdRequest(),
      size: AdSize.fullBanner,
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          print('Ad Loaded');
        },
        onAdFailedToLoad: (ad, err) {
          print('BannerAd failed to load: $err');
          ad.dispose();
        },
      ),
    );
    return bannerAd;
  }

  /* getInterstitialAd() {
    InterstitialAd.load(
      adUnitId: interstitialUnitId,
      request: AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (InterstitialAd ad) {
          print('$ad loaded..');
          interstitialAd = ad;
          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdShowedFullScreenContent: (InterstitialAd ad) {
              print('Ad ShowedFullScreen');
            },
            onAdDismissedFullScreenContent: (InterstitialAd ad) {
              print('Ad Disposed');
              ad.dispose();
            },
            onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError adError) {
              print('$ad onAdFailed $adError');
              ad.dispose();
            },
              onAdClicked: (ad) {
              },
          );
        },
        onAdFailedToLoad: (LoadAdError error) {
          print('InterstitialAd failed to load: $error');
        },
      ),
    );
  }

  void createInterstitialAd()  {
    InterstitialAd.load(
      adUnitId: interstitialUnitId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (InterstitialAd ad) {
          print('$ad loaded..');
          interstitialAd = ad;
          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdShowedFullScreenContent: (InterstitialAd ad) {
              print('Ad ShowedFullScreen');
            },
            onAdDismissedFullScreenContent: (InterstitialAd ad) {
              print('Ad Disposed');
              ad.dispose();
            },
            onAdFailedToShowFullScreenContent:
                (InterstitialAd ad, AdError adError) {
              print('$ad onAdFailed $adError');
              ad.dispose();
            },
            onAdClicked: (ad) {},
          );
        },
        onAdFailedToLoad: (LoadAdError error) {
          print('InterstitialAd failed to load: $error');
        },
      ),
    );
  }

  void showInterstitialAd() {
    interstitialAd.show();
  }*/

}
