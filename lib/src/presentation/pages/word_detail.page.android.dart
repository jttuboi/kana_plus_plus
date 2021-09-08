import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kana_plus_plus/src/domain/entities/word.dart';
import 'package:kana_plus_plus/src/presentation/utils/consts.dart';
import 'package:kana_plus_plus/src/presentation/widgets/kana_details.dart';

class WordDetailPage extends StatelessWidget {
  const WordDetailPage({Key? key, required this.word}) : super(key: key);

  final Word word;

  @override
  Widget build(BuildContext context) {
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
              width: MediaQuery.of(context).size.width,
            ),
            SafeArea(
              child: InkWell(
                onTap: () => Navigator.pop(context),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    children: [
                      const Spacer(),
                      Flexible(
                        flex: 6,
                        child: Hero(
                          tag: word.imageUrl,
                          child: SvgPicture.asset(word.imageUrl),
                        ),
                      ),
                      const Spacer(),
                      Flexible(
                        flex: 8,
                        fit: FlexFit.tight,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 16.0, bottom: 32.0),
                              child: KanasDetails(kanas: word.kanas),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 16.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Romaji', style: wordDetailTitleStyle),
                                  Text(word.romaji, style: wordDetailContentStyle),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 16.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Translate', style: wordDetailTitleStyle),
                                  Text(word.translate, style: wordDetailContentStyle),
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
