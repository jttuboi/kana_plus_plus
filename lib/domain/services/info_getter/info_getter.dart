import 'package:package_info_plus/package_info_plus.dart';

class InfoGetter {
  Future<String> get version async {
    final info = await PackageInfo.fromPlatform();
    return info.version;
  }
}
