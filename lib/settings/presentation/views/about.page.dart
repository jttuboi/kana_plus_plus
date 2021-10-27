import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_device_type/flutter_device_type.dart';
import 'package:flutter_gen/gen_l10n/j_strings.dart';
import 'package:kwriting/menu/presentation/widgets/flexible_scaffold.dart';
import 'package:kwriting/settings/presentation/widgets/rate_button.dart';
import 'package:kwriting/settings/presentation/widgets/share_button.dart';
import 'package:kwriting/settings/presentation/widgets/support_button.dart';
import 'package:kwriting/src/domain/utils/consts.dart';
import 'package:kwriting/src/infrastructure/datasources/banner_url.storage.dart';
import 'package:kwriting/src/infrastructure/datasources/icon_url.storage.dart';
import 'package:kwriting/src/presentation/utils/consts.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({Key? key}) : super(key: key);

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
                        child: Image.asset(IconUrl.app, width: aboutImageSize, height: aboutImageSize),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(strings.aboutAppVersionTitle, style: aboutAppVersionTitleTextStyle),
                          Text(snapshot.data!, style: aboutAppVersionTextStyle),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(strings.aboutDeveloperTitle, style: aboutDeveloperTitleTextStyle),
                          Text(Developer.name, style: aboutDeveloperTextStyle),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(strings.aboutContactTitle, style: aboutDeveloperTitleTextStyle),
                          RichText(
                            text: TextSpan(
                              style: aboutContactTextStyle,
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
                          RateButton(iconSize: aboutIconSize, titleSize: aboutTitleSize),
                          ShareButton(iconSize: aboutIconSize, titleSize: aboutTitleSize),
                          SupportButton(iconSize: aboutIconSize, titleSize: aboutTitleSize),
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
