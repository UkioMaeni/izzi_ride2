import 'package:izzi_ride_2/core/interfaces/app_info_interface.dart';
import 'package:package_info_plus/package_info_plus.dart';

class AppInfoService implements AppInfoInterface{
  String version="";
  Future<void> getAppVersion() async {
    try {
      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      version= packageInfo.version;
    } catch (e) {
      
    }
  }
}