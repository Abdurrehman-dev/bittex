import 'dart:async';
import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:package_info/package_info.dart';

class AppInfo {
  // Singleton instance code
  static final AppInfo _instance = AppInfo._();
  static AppInfo get instance => _instance;
  AppInfo._();

  PackageInfo _info;
  String _iosDeviceID;
  String _androidDeviceID;

  Future<void> init() async {
    _info = await PackageInfo.fromPlatform();

    final deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) {
      final iosDeviceInfo = await deviceInfo.iosInfo;
      _iosDeviceID = iosDeviceInfo.identifierForVendor; // unique ID on iOS
    } else {
      final androidDeviceInfo = await deviceInfo.androidInfo;
      _androidDeviceID = androidDeviceInfo.androidId; // unique ID on Android
    }
  }

  String get appName => _info.appName ?? 'Bittex Coin';
  String get packageName => _info.packageName ?? "com.arcreator.hivecoin";
  String get versionAndBuild => _info.version + '+' + _info.buildNumber;
  String get deviceID => Platform.isIOS ? _iosDeviceID : _androidDeviceID;
}
