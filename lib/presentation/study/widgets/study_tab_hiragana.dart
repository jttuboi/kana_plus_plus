import 'package:flutter/material.dart';
import 'package:kwriting/domain/domain.dart';
import 'package:kwriting/presentation/study/study.dart';

class StudyTabHiragana extends StatelessWidget {
  const StudyTabHiragana({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final strings = JStrings.of(context)!;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            StudyText(text: strings.studyHiraganaText1),
            StudyTable(
              title: strings.studyMonographsTitle,
              rows: const [
                StudyRow([StudyData('A', 'あ'), StudyData('I', 'い'), StudyData('U', 'う'), StudyData('E', 'え'), StudyData('O', 'お')]),
                StudyRow([StudyData('KA', 'か'), StudyData('KI', 'き'), StudyData('KU', 'く'), StudyData('KE', 'け'), StudyData('KO', 'こ')]),
                StudyRow([StudyData('SA', 'さ'), StudyData('SHI', 'し'), StudyData('SU', 'す'), StudyData('SE', 'せ'), StudyData('SO', 'そ')]),
                StudyRow([StudyData('TA', 'た'), StudyData('CHI', 'ち'), StudyData('TSU', 'つ'), StudyData('TE', 'て'), StudyData('TO', 'と')]),
                StudyRow([StudyData('NA', 'な'), StudyData('NI', 'に'), StudyData('NU', 'ぬ'), StudyData('NE', 'ね'), StudyData('NO', 'の')]),
                StudyRow([StudyData('HA', 'は'), StudyData('HI', 'ひ'), StudyData('FU', 'ふ'), StudyData('HE', 'へ'), StudyData('HO', 'ほ')]),
                StudyRow([StudyData('MA', 'ま'), StudyData('MI', 'み'), StudyData('MU', 'む'), StudyData('ME', 'め'), StudyData('MO', 'も')]),
                StudyRow([StudyData('YA', 'や'), StudyData.empty, StudyData('YU', 'ゆ'), StudyData.empty, StudyData('YO', 'よ')]),
                StudyRow([StudyData('RA', 'ら'), StudyData('RI', 'り'), StudyData('RU', 'る'), StudyData('RE', 'れ'), StudyData('RO', 'ろ')]),
                StudyRow([StudyData('WA', 'わ'), StudyData.empty, StudyData('N', '	ん'), StudyData.empty, StudyData('WO', 'を')]),
              ],
            ),
            StudyText(text: strings.studyHiraganaText2),
            StudyTable(
              title: strings.studyDiacriticsTitle,
              rows: const [
                StudyRow([StudyData('GA', 'が'), StudyData('GI', 'ぎ'), StudyData('GU', 'ぐ'), StudyData('GE', 'げ'), StudyData('GO', 'ご')]),
                StudyRow([StudyData('ZA', 'ざ'), StudyData('JI', 'じ'), StudyData('ZU', 'ず'), StudyData('ZE', 'ぜ'), StudyData('ZO', 'ぞ')]),
                StudyRow([StudyData('DA', 'だ'), StudyData('DJI', 'ぢ'), StudyData('DZU', 'づ'), StudyData('DE', 'で'), StudyData('DO', 'ど')]),
                StudyRow([StudyData('BA', 'ば'), StudyData('BI', 'び'), StudyData('BU', 'ぶ'), StudyData('BE', 'べ'), StudyData('BO', 'ぼ')]),
                StudyRow([StudyData('PA', 'ぱ'), StudyData('PI', 'ぴ'), StudyData('PU', 'ぷ'), StudyData('PE', 'ぺ'), StudyData('PO', 'ぽ')]),
              ],
            ),
            StudyText(text: strings.studyHiraganaText3),
            StudyTable(
              title: strings.studyDigraphsTitle,
              rows: const [
                StudyRow([StudyData('KYA', 'きゃ'), StudyData('KYU', 'きゅ'), StudyData('KYO', 'きょ')]),
                StudyRow([StudyData('SHA', 'しゃ'), StudyData('SHU', 'しゅ'), StudyData('SHO', 'しょ')]),
                StudyRow([StudyData('CHA', 'ちゃ'), StudyData('CHU', 'ちゅ'), StudyData('CHO', 'ちょ')]),
                StudyRow([StudyData('NYA', 'にゃ'), StudyData('NYU', 'にゅ'), StudyData('NYO', 'にょ')]),
                StudyRow([StudyData('HYA', 'ひゃ'), StudyData('HYU', 'ひゅ'), StudyData('HYO', 'ひょ')]),
                StudyRow([StudyData('MYA', 'みゃ'), StudyData('MYU', 'みゅ'), StudyData('MYO', 'みょ')]),
                StudyRow([StudyData('RYA', 'りゃ'), StudyData('RYU', 'りゅ'), StudyData('RYO', 'りょ')]),
                StudyRow([StudyData('GYA', 'ぎゃ'), StudyData('GYU', 'ぎゅ'), StudyData('GYO', 'ぎょ')]),
                StudyRow([StudyData('JA', 'じゃ'), StudyData('JU', 'じゅ'), StudyData('JO', 'じょ')]),
                StudyRow([StudyData('DYA', 'ぢゃ'), StudyData('DYU', 'ぢゅ'), StudyData('DYO', 'ぢょ')]),
                StudyRow([StudyData('BYA', 'びゃ'), StudyData('BYU', 'びゅ'), StudyData('BYO', 'びょ')]),
                StudyRow([StudyData('PYA', 'ぴゃ'), StudyData('PYU', 'ぴゅ'), StudyData('PYO', 'ぴょ')]),
              ],
            ),
            StudyText(text: strings.studyHiraganaText4),
            StudyTable(
              title: strings.studyGeminatedTitle,
              rows: const [
                StudyRow([StudyData('TSU', 'っ')]),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
