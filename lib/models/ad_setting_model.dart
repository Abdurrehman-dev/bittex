class AdIdSettingsModel {
  final String fbNativeBannerId;
  final String fbNativeId;
  final String fbInterstitialId;
  final String fbRewardedId;
  final String fbBannerId;
  final String adMobBannerId;
  final String adMobNativeID;
  final String adMobInterstitialId;
  final String adMobRewardedId;
  final String fbTestingId;
  const AdIdSettingsModel(
      {this.fbTestingId,
      this.adMobBannerId,
      this.adMobInterstitialId,
      this.fbNativeBannerId,
      this.fbInterstitialId,
      this.fbNativeId,
      this.adMobNativeID,
      this.fbRewardedId,
      this.adMobRewardedId,
      this.fbBannerId});
  factory AdIdSettingsModel.fromJson(Map<String, dynamic> map) {
    return AdIdSettingsModel(
      fbNativeBannerId: map["facebook"]["native_banner_id"],
      fbNativeId: map["facebook"]["native_id"],
      fbInterstitialId: map["facebook"]["interstitial_id"],
      fbRewardedId: map["facebook"]["rewarded_id"],
      fbBannerId: map["facebook"]["banner_id"],
      adMobBannerId: map["admob"]["banner_id"],
      adMobInterstitialId: map["admob"]["interstitial_id"],
      adMobNativeID: map["admob"]["native_id"],
      adMobRewardedId: map["admob"]["rewarded_id"],
      fbTestingId: map["fb_testing_id"],
    );
  }
}

class MoreSettingModel {
  final String contactId;
  final String moreAppsIos;
  final String moreAppsAndroid;
  final String appStoreId;

  const MoreSettingModel(
      {this.contactId,
      this.moreAppsAndroid,
      this.moreAppsIos,
      this.appStoreId});

  factory MoreSettingModel.fromMap(Map<String, dynamic> map) =>
      MoreSettingModel(
          contactId: map["contact_id"],
          moreAppsAndroid: map["more_apps_android"],
          moreAppsIos: map["more_apps_ios"],
          appStoreId: map["app_store_id"]);
}

class AdSettingsModel {
  final List<String> adPriorityList;
  final bool shouldShowAd;
  final int adTimer;
  final int interstitialCounter;

  const AdSettingsModel({
    this.adPriorityList,
    this.adTimer,
    this.shouldShowAd,
    this.interstitialCounter,
  });

  factory AdSettingsModel.fromMap(Map<String, dynamic> map) {
    return AdSettingsModel(
      adPriorityList: toList(map["ad_priority"]),
      shouldShowAd: map["show_ad_on_launch"],
      adTimer: map["ad_timer"],
      interstitialCounter: map["counted_interstitial_count"],
    );
  }

  static List<String> toList(final List<dynamic> list) =>
      list.map<String>((e) => "$e").toList();
}

class CrossPromotionSettingModel {
  final String bannerAdImage;
  final String bannerAdLink;
  final String interstitialAdImage;
  final String interstitialAdLink;
  const CrossPromotionSettingModel({
    this.bannerAdImage,
    this.bannerAdLink,
    this.interstitialAdImage,
    this.interstitialAdLink,
  });
  factory CrossPromotionSettingModel.fromMap(Map<String, dynamic> map) {
    return CrossPromotionSettingModel(
      bannerAdImage: map["banner_ad"]["image"],
      bannerAdLink: map["banner_ad"]["link"],
      interstitialAdImage: map["interstitial_ad"]["image"],
      interstitialAdLink: map["interstitial_ad"]["link"],
    );
  }
}
