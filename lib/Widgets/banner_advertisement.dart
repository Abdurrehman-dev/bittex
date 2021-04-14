import 'package:facebook_audience_network/ad/ad_native.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hivecoin/Services/ad_manager.dart';
import 'package:hivecoin/all_utilities.dart';

/// first we call AdMob Ad if it is not loaded then show facebook ad if facebook ad is not loaded then show cross promotion Ad.
/// if(MobileAdEvent == Loaded) show AdMob Ad
/// if(MobileAdEvent == NotLoaded) show Facebook Ad
/// if(FacebookAd == Error) show cross Promotion Ad
class BannerAdvertisement extends StatefulWidget {
  @override
  _BannerAdvertisementState createState() => _BannerAdvertisementState();
}

class _BannerAdvertisementState extends State<BannerAdvertisement> {
  BannerAd _bannerAd;
  bool _isBannerAdLoaded;

  static AdSize _adSize = isTablet() ? AdSize.leaderboard : AdSize.banner;

  @override
  Widget build(BuildContext context) {
    final height = _adSize.height.toDouble();
    if (_bannerAd == null || _isBannerAdLoaded == null) {
      return AnimatedContainer(
        height: 0,
        duration: const Duration(milliseconds: 300),
      );
    } else if (_isBannerAdLoaded == true) {
      return AnimatedContainer(
        height: height,
        child: AdWidget(ad: _bannerAd),
        duration: 600.milliseconds,
      );
      // } else if (_isBannerAdLoaded == false) {
      //   return Container(
      //     child: AdManager.getFacebookAd(NativeAdType.NATIVE_BANNER_AD,
      //         listener: (result, value) {
      //       print("FB Banner: $result :: $value");
      //     }, height: height + 15),
      //   );
    } else {
      return const SizedBox();
    }
  }

  final height = _adSize.height.toDouble();
  @override
  void initState() {
    _bannerAd = BannerAd(
      //TODO: remove test init id when remote config set
      adUnitId: 'ca-app-pub-2865079064373688/6768421236',
      // AdManager.remoteConfig.adMobBannerId,
      size: _adSize,
      request: AdManager.targetingInfo,
      listener: AdListener(onAdLoaded: (Ad ad) {
        setState(() => _isBannerAdLoaded = true);
      }, onAdFailedToLoad: (ad, error) {
        setState(() => _isBannerAdLoaded = false);
      }),
    );

    _bannerAd?.load();

    super.initState();
  }

  @override
  void dispose() {
    _bannerAd?.dispose();
    _bannerAd = null;

    super.dispose();
  }

  static bool isTablet() {
    final data = MediaQueryData.fromWindow(WidgetsBinding.instance.window);
    return data.size.shortestSide >= 600;
  }
}
