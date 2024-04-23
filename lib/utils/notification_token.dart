import 'package:device_info_plus/device_info_plus.dart';

class DeviceInformation {
  static Future<AndroidDeviceInfo> androidInfo() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo andoridInfo = await deviceInfo.androidInfo;
    return andoridInfo;
  }
}
