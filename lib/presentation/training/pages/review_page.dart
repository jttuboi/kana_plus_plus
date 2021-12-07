import 'dart:developer' as dev;

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:kwriting/domain/domain.dart';
import 'package:kwriting/infra/infra.dart';
import 'package:kwriting/presentation/shared/shared.dart';
import 'package:kwriting/presentation/training/training.dart';

class ReviewPage extends StatefulWidget {
  const ReviewPage({required this.reviewController, required this.wordsResult, Key? key}) : super(key: key);

  static const routeName = '/review';
  static const argWordsResult = 'argWordsResult';

  static Route route({List<WordViewModel>? wordsResult}) {
    return MaterialPageRoute(builder: (context) {
      return ReviewPage(
        reviewController: ReviewController(statisticsRepository: StatisticsRepository(HiveDatabase())),
        wordsResult: wordsResult ?? const [],
      );
    });
  }

  final ReviewController reviewController;
  final List<WordViewModel> wordsResult;

  @override
  State<ReviewPage> createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  late BannerAd _ad;
  bool _isAdLoaded = false;

  @override
  void initState() {
    super.initState();
    _loadAds();
    // print(widget.reviewController.showRateApp);
    // if (widget.reviewController.showRateApp) {
    //   // TODO add dialog for app rating and review
    //   // it's good to show a dialog after 2 or 3 seconds after 10 or more training made it
    //   // this dialog ask if have you enjoy this app? Please, give a feedback.
    //   // this dialog has buttons yes and no. No option closes the box, Yes option open in app review dialog.
    // }
  }

  @override
  void dispose() {
    _ad.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final strings = JStrings.of(context)!;
    //dev.log(MediaQuery.of(context).padding.top + kToolbarHeight);
    return WillPopScope(
      onWillPop: () async {
        Navigator.popUntil(context, (route) => route.isFirst);
        return false;
      },
      child: FlexibleScaffold(
        title: strings.reviewTitle,
        bannerUrl: BannerUrl.review,
        onBackButtonPressed: () => Navigator.popUntil(context, (route) => route.isFirst),
        actions: const [SupportButton(isAppBarIcon: true)],
        sliverContent: SliverPadding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          sliver: SliverList(
            delegate: SliverChildListDelegate(
              widget.wordsResult.fold<List<Widget>>(
                <Widget>[],
                (list, wordResult) {
                  if (_isLastOfList(wordResult)) {
                    if (_canShowAdTile(list)) {
                      list
                        ..add(_buildAdTile())
                        ..add(const Divider(indent: 72))
                        ..add(ReviewTile(wordResult: wordResult));
                    } else {
                      list.add(ReviewTile(wordResult: wordResult));
                    }
                  } else {
                    if (_canShowAdTile(list)) {
                      list
                        ..add(_buildAdTile())
                        ..add(const Divider(indent: 72))
                        ..add(ReviewTile(wordResult: wordResult))
                        ..add(const Divider(indent: 72));
                    } else {
                      list
                        ..add(ReviewTile(wordResult: wordResult))
                        ..add(const Divider(indent: 72));
                    }
                  }
                  return list;
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _loadAds() {
    _ad = BannerAd(
      adUnitId: Ads.bannerAdUnitId,
      size: AdSize.banner,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (ad) => setState(() => _isAdLoaded = true),
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
          dev.log('onAdFailedToLoad: $error', error: error);
        },
      ),
    );
    _ad.load();
  }

  bool _isLastOfList(WordViewModel wordResult) => wordResult == widget.wordsResult.last;

  bool _canShowAdTile(List<Widget> list) => _isAdLoaded && list.length == 10;

  Container _buildAdTile() {
    return Container(
      width: _ad.size.width.toDouble(),
      height: 72,
      alignment: Alignment.center,
      child: AdWidget(ad: _ad),
    );
  }
}
