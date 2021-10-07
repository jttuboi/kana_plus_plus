import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/j_strings.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:kwriting/src/data/datasources/icon_url.storage.dart';
import 'package:kwriting/src/domain/utils/consts.dart';
import 'package:kwriting/src/presentation/utils/consts.dart';
import 'package:logger/logger.dart';

class SupportButton extends StatefulWidget {
  const SupportButton({
    Key? key,
    this.iconSize = 24.0,
    this.isAppBarIcon = false,
  }) : super(key: key);

  final double iconSize;
  final bool isAppBarIcon;

  @override
  State<SupportButton> createState() => _SupportButtonState();
}

class _SupportButtonState extends State<SupportButton> {
  late InterstitialAd _ad;
  bool _isAdLoaded = false;

  @override
  void initState() {
    super.initState();
    _loadAd();
  }

  @override
  void dispose() {
    _ad.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final strings = JStrings.of(context)!;
    return widget.isAppBarIcon
        ? Padding(
            padding: const EdgeInsets.all(4.0),
            child: IconButton(
              onPressed: _onSupportPressed,
              icon: SvgPicture.asset(
                IconUrl.support,
                width: widget.iconSize,
                height: widget.iconSize,
                color: Theme.of(context).primaryIconTheme.color,
              ),
            ),
          )
        : Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                onPressed: _onSupportPressed,
                iconSize: widget.iconSize,
                icon: SvgPicture.asset(
                  IconUrl.support,
                  width: widget.iconSize,
                  height: widget.iconSize,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
              Text(strings.aboutSupport, style: aboutIconTextStyle),
            ],
          );
  }

  void _onSupportPressed() {
    if (_isAdLoaded) {
      _ad.show();
    }
  }

  void _loadAd() {
    InterstitialAd.load(
      adUnitId: interstitialAdUnitId,
      request: const AdRequest(),
      adLoadCallback: _adLoadCallback,
    );
  }

  InterstitialAdLoadCallback get _adLoadCallback {
    return InterstitialAdLoadCallback(
      onAdLoaded: (InterstitialAd ad) {
        _ad = ad;
        _ad.fullScreenContentCallback = _fullScreenContentCallback;
        setState(() => _isAdLoaded = true);
      },
      onAdFailedToLoad: (LoadAdError error) {
        Logger().e('onAdFailedToLoad: $error');
        setState(() => _isAdLoaded = false);
      },
    );
  }

  FullScreenContentCallback<InterstitialAd> get _fullScreenContentCallback {
    return FullScreenContentCallback(
      onAdDismissedFullScreenContent: (InterstitialAd ad) {
        setState(() => _isAdLoaded = false);
        ad.dispose();
        _loadAd();
        _showGratefulMessage();
      },
      onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
        Logger().e('$ad onAdFailedToShowFullScreenContent: $error');
        setState(() => _isAdLoaded = false);
        ad.dispose();
        _loadAd();
      },
    );
  }

  void _showGratefulMessage() {
    final strings = JStrings.of(context)!;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(strings.aboutSupportMessage),
      duration: const Duration(seconds: 2),
      behavior: SnackBarBehavior.floating,
    ));
  }
}
