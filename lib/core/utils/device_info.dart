import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';

class DeviceInfo{
  DeviceInfo._();

  static DeviceInfo? _singleton;

  factory DeviceInfo() {
    _singleton ??= DeviceInfo._();
    return _singleton!;
  }

  static DeviceInfo get instance => DeviceInfo();

  static late final IosDeviceInfo _iosDeviceInfo;
  static late final AndroidDeviceInfo _androidDeviceInfo;

  static Future<void> init() async{
    final deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) { // import 'dart:io'
      _iosDeviceInfo = await deviceInfo.iosInfo;// unique ID on iOS
    } else if(Platform.isAndroid) {
      _androidDeviceInfo = await deviceInfo.androidInfo; // unique ID on Android
    }
  }

  static String getId() {
    try{
      if (Platform.isIOS) { // import 'dart:io'
        return _iosDeviceInfo.identifierForVendor!; // unique ID on iOS
      } else if(Platform.isAndroid) {
        return _androidDeviceInfo.id!; // unique ID on Android
      }
      return 'Device is not mobile';
    }catch(e){
      return 'Cannot get Id';
    }
  }
}