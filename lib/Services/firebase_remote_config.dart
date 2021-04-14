import 'dart:convert';

import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:hivecoin/models/ad_setting_model.dart';

class RemoteConfigService {
  static final RemoteConfigService _instance = RemoteConfigService._();
  static RemoteConfigService get instance => _instance;
  RemoteConfig _remoteConfig;
  RemoteConfigService._();
  AdIdSettingsModel _adIdSettingsModel;
  MoreSettingModel _moreSettingModel;
  AdSettingsModel _adSettingModel;
  static const _keyAdIds = "ad_ids";
  static const _keyMoreSetting = "more_settings";
  static const _keyAdSetting = "ad_settings";
  String get _adIdJson => _remoteConfig.getString(_keyAdIds);
  String get _moreSettingJson => _remoteConfig.getString(_keyMoreSetting);
  String get _adSettingsJson => _remoteConfig.getString(_keyAdSetting);
  AdIdSettingsModel get getAdIds => _adIdSettingsModel;
  MoreSettingModel get getMoreSetting => _moreSettingModel;
  AdSettingsModel get getAdSetting => _adSettingModel;

  Future init() async {
    _remoteConfig = await RemoteConfig.instance;
    // Allow a fetch every millisecond. Default is 12 hours.
    _remoteConfig.setDefaults(<String, dynamic>{
      _keyAdIds: {
        "android": {
          "admob": {
            "native_id": "",
            "banner_id": "ca-app-pub-4423898417866629/4740780504",
            "interstitial_id": "ca-app-pub-4423898417866629/8332541154",
            "rewarded_id": "ca-app-pub-4423898417866629/8839823529"
          },
          "facebook": {
            "native_id": "709665633034783_709675146367165",
            "native_banner_id": "709665633034783_709675529700460",
            "interstitial_id": "709665633034783_709675529700460",
            "rewarded_id": "709665633034783_709675756367104",
            "banner_id": ""
          }
        },
        "ios": {
          "admob": {
            "native_id": "",
            "banner_id": "ca-app-pub-4423898417866629/6827887790",
            "interstitial_id": "ca-app-pub-4423898417866629/5355874083",
            "rewarded_id": "ca-app-pub-4423898417866629/1416629074"
          },
          "facebook": {
            "native_id": "709665633034783_709671976367482",
            "native_banner_id": "709665633034783_709672533034093",
            "interstitial_id": "709665633034783_709673006367379",
            "rewarded_id": "709665633034783_709673319700681",
            "banner_id": ""
          }
        },
        "fb_testing_id": "IMG_16_9_APP_INSTALL#"
      },
      _keyMoreSetting: {
        "contact_id": "nalitt.apps@gmail.com",
        "more_apps_ios":
            "https://apps.apple.com/us/developer/hosni-macabando/id1170635940",
        "more_apps_android": "market://search?q=pub:Hamzah+Malik",
        "app_store_id": "1554852772"
      },
      _keyAdSetting: {
        "ios": {
          "ad_timer": 60,
          "show_ad_on_launch": true,
          "ad_priority": ["fb", "admob", "cross", "random"]
        },
        "android": {
          "ad_timer": 0,
          "show_ad_on_launch": true,
          "ad_priority": ["fb", "admob", "cross", "random"]
        }
      },
    });
    try {
      await _remoteConfig.fetch(expiration: Duration(milliseconds: 1));
      await _remoteConfig.activateFetched();
    } catch (e) {
      print(e);
    }
    final adIdJsonMap = jsonDecode(_adIdJson);
    final moreSetting = jsonDecode(_moreSettingJson);
    final adPriority = jsonDecode(_adSettingsJson);
    _adIdSettingsModel = AdIdSettingsModel.fromJson(adIdJsonMap);
    _moreSettingModel = MoreSettingModel.fromMap(moreSetting);
    _adSettingModel = AdSettingsModel.fromMap(adPriority);
  }
}
