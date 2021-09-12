import 'dart:io';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/j_strings.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kana_plus_plus/src/data/datasources/banner_url.storage.dart';
import 'package:kana_plus_plus/src/data/datasources/icon_url.storage.dart';
import 'package:kana_plus_plus/src/domain/core/consts.dart';
import 'package:kana_plus_plus/src/presentation/utils/consts.dart';
import 'package:kana_plus_plus/src/presentation/widgets/flexible_scaffold.dart';
import 'package:kana_plus_plus/src/presentation/widgets/share_button.dart';
import 'package:launch_review/launch_review.dart';
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
                  child: Image.asset(IconUrl.app),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(strings.aboutAppVersionTitle, style: aboutAppVersionTitleTextStyle),
                      const Text(AppDefault.version, style: aboutAppVersionTextStyle),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(strings.aboutDeveloperTitle, style: aboutDeveloperTitleTextStyle),
                      const Text(DeveloperDefault.name, style: aboutDeveloperTextStyle),
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
                          text: DeveloperDefault.contact,
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
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            onPressed: _onRatePressed,
                            iconSize: 56,
                            icon: SvgPicture.asset(IconUrl.rate, width: 56, height: 56, color: Theme.of(context).colorScheme.secondary),
                          ),
                          Text(strings.aboutRate, style: aboutIconTextStyle),
                        ],
                      ),
                      const ShareButton(iconSize: 56),
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
      path: DeveloperDefault.contact,
      query: _encodeQueryParameters({'subject': DeveloperDefault.contactSubject}),
    );
    launch(emailLaunchUri.toString());
  }

  Future<void> _onRatePressed() async {
    if (Platform.isIOS) {
      await LaunchReview.launch(iOSAppId: AppDefault.iosId);
    } else if (Platform.isAndroid) {
      await LaunchReview.launch(androidAppId: AppDefault.androidId);
    } else {
      // if web or desktop, it doesn't support yet.
    }
  }
}
