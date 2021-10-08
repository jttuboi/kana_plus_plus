import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_device_type/flutter_device_type.dart';
import 'package:flutter_gen/gen_l10n/j_strings.dart';
import 'package:kwriting/src/data/datasources/banner_url.storage.dart';
import 'package:kwriting/src/data/datasources/icon_url.storage.dart';
import 'package:kwriting/src/domain/utils/consts.dart';
import 'package:kwriting/src/presentation/utils/consts.dart';
import 'package:kwriting/src/presentation/widgets/flexible_scaffold.dart';
import 'package:kwriting/src/presentation/widgets/rate_button.dart';
import 'package:kwriting/src/presentation/widgets/share_button.dart';
import 'package:kwriting/src/presentation/widgets/support_button.dart';
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
        padding: const EdgeInsets.all(16.0),
        sliver: SliverFillRemaining(
          child: Center(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: ClipRRect(
                    borderRadius: Device.get().isTablet ? BorderRadius.circular(60.0) : BorderRadius.circular(30.0),
                    child: Image.asset(IconUrl.app, width: aboutImageSize, height: aboutImageSize),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(strings.aboutAppVersionTitle, style: aboutAppVersionTitleTextStyle),
                      Text(App.version, style: aboutAppVersionTextStyle),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(strings.aboutDeveloperTitle, style: aboutDeveloperTitleTextStyle),
                      Text(Developer.name, style: aboutDeveloperTextStyle),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
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
                  padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 32.0),
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
    launch(emailLaunchUri.toString());
  }
}
