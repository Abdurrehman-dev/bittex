import 'dart:async';

import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:supercharged/supercharged.dart';

import 'firebase_remote_config.dart';

class AdManager {
  // Singleton instance code
  static final AdManager _instance = AdManager._();

  static AdManager get instance => _instance;

  AdManager._();

  static Future<void> initAdManager() async {
    await MobileAds.instance.initialize();
  }

  static const AdRequest targetingInfo = AdRequest(
      testDevices: <String>[
        // '0CAE94DF62B6C62D8EA6D89448803B48' // Abd Phone
      ],
      nonPersonalizedAds: true,
      // childDirected: true,
      keywords: <String>[
        'love',
        'home',
        'bitcoin',
        'bittex',
        'hives',
        'etherium',
      ]);

  // Interstitial Ad Logic
  InterstitialAd _admobInterstitialAd;
  bool _isAdmobInterstitialAdReady = false;
  bool _isFacebookInterstitialAdReady = false;
  bool _isAdAlreadyDisplayed = false;
  Function _onInterstitialClosed;
  int _count = 0;

  _initAdmobInterstitialAd() {
    _isAdmobInterstitialAdReady = false;

    _admobInterstitialAd = InterstitialAd(
      adUnitId: "ca-app-pub-2865079064373688/7666328689",
      request: targetingInfo,
      listener: AdListener(
          onAdOpened: (Ad ad) => _isAdAlreadyDisplayed = true,
          onAdLoaded: (Ad ad) {
            print("Ad Loaded: $ad");
            _isAdmobInterstitialAdReady = true;
          },
          onAdFailedToLoad: (Ad ad, LoadAdError error) =>
              _isAdmobInterstitialAdReady = false,
          onAdClosed: (Ad ad) {
            _onInterstitialClosed?.call();
            _isAdAlreadyDisplayed = false;
            _admobInterstitialAd = null;
            Timer(Duration(seconds: 1), loadInterstitial);
          }),
    );
  }

  loadInterstitial() {
    if (_admobInterstitialAd == null) _initAdmobInterstitialAd();

    if (!_isAdmobInterstitialAdReady) {
      _admobInterstitialAd.load();
    }
  }

  bool _showOrLoadAdmobAd(Function onInterstitialClosed) {
    if (_isAdmobInterstitialAdReady) {
      _admobInterstitialAd.show();
      this._onInterstitialClosed = onInterstitialClosed;
      return true;
    }
    loadInterstitial();
    return false;
  }

  showAdOnLaunch(Function onInterstitialClosed) {
    if (RemoteConfigService.instance.getAdSetting.shouldShowAd) {
      Timer(2.seconds,
          () => showInterstitial(onInterstitialClosed: _onInterstitialClosed));
    }
  }

  showAdByTimer() {
    final time = 3;
    if (time < 1) return;

    Timer.periodic(time.seconds, (_) {
      if (_isAdAlreadyDisplayed) return;

      showInterstitial();
    });
  }

  bool showInterstitial({Function onInterstitialClosed}) {
    return _showOrLoadAdmobAd(onInterstitialClosed);
  }

  showCountedInterstitial() {
    _count++;
    if (_count ==
        RemoteConfigService.instance.getAdSetting.interstitialCounter) {
      showInterstitial();
      _count = 0;
    } else {
      loadInterstitial();
    }
  }

// END - Interstitial Ad Logic

// END - Interstitial Ad Logic
  Completer<bool> _rewardedVideoLoadingCompleter;

  bool _isRewardedAdReady = false;
  Function _onRewardedVideoCompleted;
  RewardedAd myRewarded;

  Future<bool> loadRewardedAd() async {
    // if (EnvironmentVariables.isAndroidApproving) return false;

    if (_isRewardedAdReady) return true;
    myRewarded = RewardedAd(
      adUnitId: "ca-app-pub-2865079064373688/4165055617",
      request: AdManager.targetingInfo,
      listener: AdListener(
        onAdLoaded: (Ad ad) {
          _isRewardedAdReady = true;
          print('RewardedVideoAdEvent.loaded');
        },
        onAdClosed: (Ad ad) {
          _isRewardedAdReady = false;
          loadRewardedAd();
        },
        onAdFailedToLoad: (Ad ad, error) {
          _isRewardedAdReady = false;
          if (_rewardedVideoLoadingCompleter != null)
            _rewardedVideoLoadingCompleter.complete(false);
          print('Failed to load a rewarded ad');
        },
        onRewardedAdUserEarnedReward: (RewardedAd ad, RewardItem reward) {
          if (_onRewardedVideoCompleted != null) _onRewardedVideoCompleted();
        },
      ),
    );
    myRewarded.load();
    _rewardedVideoLoadingCompleter = Completer<bool>();

    return _rewardedVideoLoadingCompleter.future;
  }

  bool showRewardedVideoAd({Function onRewardedVideoCompleted}) {
    if (_isRewardedAdReady) {
      myRewarded.show();
      _onRewardedVideoCompleted = onRewardedVideoCompleted;
    } else {
      loadRewardedAd();
    }

    return _isRewardedAdReady;
  }
}
