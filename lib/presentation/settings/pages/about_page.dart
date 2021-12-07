import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_device_type/flutter_device_type.dart';
import 'package:kwriting/domain/domain.dart';
import 'package:kwriting/infra/infra.dart';
import 'package:kwriting/presentation/shared/shared.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({
    required this.infoGetter,
    required this.rateLauncher,
    required this.shareLauncher,
    required this.urlLauncher,
    required this.supportButton,
    Key? key,
  }) : super(key: key);

  static const routeName = '/about';

  static Route route() {
    return MaterialPageRoute(builder: (context) {
      return AboutPage(
        infoGetter: InfoGetter(),
        rateLauncher: RateLauncher(),
        shareLauncher: ShareLauncher(),
        urlLauncher: UrlLauncher(),
        // TODO discover how to remove Interstitial Ad from SupportButton and don't break the ads
        // and refactoring here
        supportButton: SupportButton(iconSize: Device.get().isTablet ? 84.0 : 56.0, titleSize: Device.get().isTablet ? 28.0 : 18.0),
      );
    });
  }

  final IInfoGetter infoGetter;
  final IRateLauncher rateLauncher;
  final IShareLauncher shareLauncher;
  final IUrlLauncher urlLauncher;
  final ISupportButton supportButton;

  double get _imageSize => Device.screenWidth * 1 / 3;
  double get _fontSize => Device.get().isTablet ? 28.0 : 20.0;
  double get _iconSize => Device.get().isTablet ? 84.0 : 56.0;
  double get _titleSize => Device.get().isTablet ? 28.0 : 18.0;

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
            future: infoGetter.version,
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
                              recognizer: TapGestureRecognizer()..onTap = urlLauncher.sendEmail,
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
                          RateButton(iconSize: _iconSize, titleSize: _titleSize, launcher: RateLauncher()),
                          ShareButton(iconSize: _iconSize, titleSize: _titleSize, launcher: ShareLauncher()),
                          supportButton,
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
}
