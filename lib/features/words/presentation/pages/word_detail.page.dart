import 'package:flutter/material.dart';
import 'package:flutter_device_type/flutter_device_type.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kwriting/core/core.dart';
import 'package:kwriting/features/words/words.dart';

class WordDetailPage extends StatelessWidget {
  WordDetailPage._(this._word, {Key? key}) : super(key: key);

  static const routeName = '/word_detail';
  static const argWord = 'argWord';

  static Route route({required Word word}) {
    return MaterialPageRoute(builder: (context) => WordDetailPage._(word));
  }

  final _titleStyle = TextStyle(fontSize: Device.get().isTablet ? 48 : 30);
  final _contentStyle = TextStyle(fontSize: Device.get().isTablet ? 40 : 25, color: Colors.grey.shade600);

  final Word _word;

  @override
  Widget build(BuildContext context) {
    final strings = JStrings.of(context)!;
    final width = MediaQuery.of(context).size.width;

    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context);
        return false;
      },
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              color: Theme.of(context).primaryColor,
              height: appBarExpandedHeight(context) + MediaQuery.of(context).padding.top,
              width: width,
            ),
            SafeArea(
              child: InkWell(
                onTap: () => Navigator.pop(context),
                child: Padding(
                  padding: Device.get().isTablet ? const EdgeInsets.symmetric(horizontal: 36) : const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    children: [
                      const Spacer(),
                      Flexible(
                        flex: 6,
                        child: Hero(
                          tag: _word.imageUrl,
                          child: SvgPicture.asset(_word.imageUrl, width: width * 4 / 5, height: width * 4 / 5),
                        ),
                      ),
                      const Spacer(),
                      Flexible(
                        flex: 8,
                        fit: FlexFit.tight,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 16, bottom: 32),
                              child: KanasDetails(kanas: _word.kanas),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(strings.wordDetailRomaji, style: _titleStyle),
                                  Text(_word.romaji, style: _contentStyle),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(strings.wordDetailTranslate, style: _titleStyle),
                                  Text(_word.translate, style: _contentStyle),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
