import 'package:kwriting/domain/domain.dart';
import 'package:package_info_plus/package_info_plus.dart';

class InfoGetter implements IInfoGetter {
  @override
  Future<String> get version async {
    final info = await PackageInfo.fromPlatform();
    return info.version;
  }
}
