import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_device_type/flutter_device_type.dart';
import 'package:kwriting/core/core.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutPage extends StatelessWidget {
  AboutPage._({Key? key}) : super(key: key);

  static const routeName = '/about';

  static Route route() {
    return MaterialPageRoute(builder: (context) => AboutPage._());
  }

  final _imageSize = Device.screenWidth * 1 / 3;
  final _fontSize = Device.get().isTablet ? 28.0 : 20.0;
  final _iconSize = Device.get().isTablet ? 84.0 : 56.0;
  final _titleSize = Device.get().isTablet ? 28.0 : 18.0;

  @override
  Widget build(BuildContext context) {
    final strings = JStrings.of(context)!;
    return FlexibleScaffold(
      title: strings.settingsAbout,
      bannerUrl: BannerUrl.settings,
      isFlexible: false,
      onBackButtonPressed: () => Navigator.pop(context),
      sliverContent: SliverPadding(
        padding: const EdgeInsets.all(16),
        sliver: SliverFillRemaining(
          child: FutureBuilder<String>(
            future: getVersionInfo,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const CircularProgressIndicator();
              }
              return Center(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: ClipRRect(
                        borderRadius: Device.get().isTablet ? BorderRadius.circular(60) : BorderRadius.circular(30),
                        child: Image.asset(IconUrl.app, width: _imageSize, height: _imageSize),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(strings.aboutAppVersionTitle, style: TextStyle(fontSize: _fontSize, fontWeight: FontWeight.bold)),
                          Text(snapshot.data!, style: TextStyle(fontSize: _fontSize)),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(strings.aboutDeveloperTitle, style: TextStyle(fontSize: _fontSize, fontWeight: FontWeight.bold)),
                          Text(Developer.name, style: TextStyle(fontSize: _fontSize)),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(strings.aboutContactTitle, style: TextStyle(fontSize: _fontSize, fontWeight: FontWeight.bold)),
                          RichText(
                            text: TextSpan(
                              style: TextStyle(fontSize: _fontSize, color: Colors.blue, decoration: TextDecoration.underline),
                              text: Developer.contact,
                              recognizer: TapGestureRecognizer()..onTap = _onContactTap,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16, right: 16, top: 32),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          RateButton(iconSize: _iconSize, titleSize: _titleSize),
                          ShareButton(iconSize: _iconSize, titleSize: _titleSize),
                          SupportButton(iconSize: _iconSize, titleSize: _titleSize),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  String? _encodeQueryParameters(Map<String, String> params) {
    return params.entries.map((entry) => '${Uri.encodeComponent(entry.key)}=${Uri.encodeComponent(entry.value)}').join('&');
  }

  Future<void> _onContactTap() async {
    final emailLaunchUri = Uri(
      scheme: 'mailto',
      path: Developer.contact,
      query: _encodeQueryParameters({'subject': Default.contactSubject}),
    );
    await launch(emailLaunchUri.toString());
  }

  Future<String> get getVersionInfo async {
    final info = await PackageInfo.fromPlatform();
    return info.version;
  }
}
