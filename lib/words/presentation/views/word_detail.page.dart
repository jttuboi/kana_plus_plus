import 'package:flutter/material.dart';
import 'package:flutter_device_type/flutter_device_type.dart';
import 'package:flutter_gen/gen_l10n/j_strings.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kwriting/core/consts.dart';
import 'package:kwriting/training/domain/entities/word.dart';
import 'package:kwriting/words/presentation/widgets/kana_details.dart';

class WordDetailPage extends StatelessWidget {
  WordDetailPage({required this.word, Key? key}) : super(key: key);

  final wordDetailTitleStyle = TextStyle(fontSize: Device.get().isTablet ? 48 : 30);
  final wordDetailContentStyle = TextStyle(fontSize: Device.get().isTablet ? 40 : 25, color: Colors.grey.shade600);

  final Word word;

  @override
  Widget build(BuildContext context) {
    final strings = JStrings.of(context)!;
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
                  padding: Device.get().isTablet ? const EdgeInsets.symmetric(horizontal: 36) : const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    children: [
                      const Spacer(),
                      Flexible(
                        flex: 6,
                        child: Hero(
                          tag: word.imageUrl,
                          child: SvgPicture.asset(
                            word.imageUrl,
                            width: MediaQuery.of(context).size.width * 4 / 5,
                            height: MediaQuery.of(context).size.width * 4 / 5,
                          ),
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
                              child: KanasDetails(kanas: word.kanas),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(strings.wordDetailRomaji, style: wordDetailTitleStyle),
                                  Text(word.romaji, style: wordDetailContentStyle),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(strings.wordDetailTranslate, style: wordDetailTitleStyle),
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
