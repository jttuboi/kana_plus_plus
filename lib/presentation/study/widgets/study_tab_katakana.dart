import 'package:flutter/material.dart';
import 'package:kwriting/domain/domain.dart';
import 'package:kwriting/presentation/study/study.dart';

class StudyTabKatakana extends StatelessWidget {
  const StudyTabKatakana({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final strings = JStrings.of(context)!;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            StudyText(text: strings.studyKatakanaText1),
            StudyTable(
              title: strings.studyMonographsTitle,
              rows: const [
                StudyRow([StudyData('A', 'ア'), StudyData('I', 'イ'), StudyData('U', 'ウ'), StudyData('E', 'エ'), StudyData('O', 'オ')]),
                StudyRow([StudyData('KA', 'カ'), StudyData('KI', 'キ'), StudyData('KU', 'ク'), StudyData('KE', 'ケ'), StudyData('KO', 'コ')]),
                StudyRow([StudyData('SA', 'サ'), StudyData('SHI', 'シ'), StudyData('SU', 'ス'), StudyData('SE', 'セ'), StudyData('SO', 'ソ')]),
                StudyRow([StudyData('TA', 'タ'), StudyData('CHI', 'チ'), StudyData('TSU', 'ツ'), StudyData('TE', 'テ'), StudyData('TO', 'ト')]),
                StudyRow([StudyData('NA', 'ナ'), StudyData('NI', 'ニ'), StudyData('NU', 'ヌ'), StudyData('NE', 'ネ'), StudyData('NO', 'ノ')]),
                StudyRow([StudyData('HA', 'ハ'), StudyData('HI', 'ヒ'), StudyData('FU', 'フ'), StudyData('HE', 'ヘ'), StudyData('HO', 'ホ')]),
                StudyRow([StudyData('MA', 'マ'), StudyData('MI', 'ミ'), StudyData('MU', 'ム'), StudyData('ME', 'メ'), StudyData('MO', 'モ')]),
                StudyRow([StudyData('YA', 'ヤ'), StudyData.empty, StudyData('YU', 'ユ'), StudyData.empty, StudyData('YO', 'ヨ')]),
                StudyRow([StudyData('RA', 'ラ'), StudyData('RI', 'リ'), StudyData('RU', 'ル'), StudyData('RE', 'レ'), StudyData('RO', 'ロ')]),
                StudyRow([StudyData('WA', 'ワ'), StudyData.empty, StudyData('N', 'ン'), StudyData.empty, StudyData('WO', 'ヲ')]),
              ],
            ),
            StudyText(text: strings.studyKatakanaText2),
            StudyTable(
              title: strings.studyDiacriticsTitle,
              rows: const [
                StudyRow([StudyData('GA', 'ガ'), StudyData('GI', 'ギ'), StudyData('GU', 'グ'), StudyData('GE', 'ゲ'), StudyData('GO', 'ゴ')]),
                StudyRow([StudyData('ZA', 'ザ'), StudyData('JI', 'ジ'), StudyData('ZU', 'ズ'), StudyData('ZE', 'ゼ'), StudyData('ZO', 'ゾ')]),
                StudyRow([StudyData('DA', 'ダ'), StudyData('DJI', 'ヂ'), StudyData('DZU', 'ヅ'), StudyData('DE', 'デ'), StudyData('DO', 'ド')]),
                StudyRow([StudyData('BA', 'バ'), StudyData('BI', 'ビ'), StudyData('BU', 'ブ'), StudyData('BE', 'ベ'), StudyData('BO', 'ボ')]),
                StudyRow([StudyData('PA', 'パ'), StudyData('PI', 'ピ'), StudyData('PU', 'プ'), StudyData('PE', 'ペ'), StudyData('PO', 'ポ')]),
              ],
            ),
            StudyText(text: strings.studyKatakanaText3),
            StudyTable(
              title: strings.studyDigraphsTitle,
              rows: const [
                StudyRow([StudyData('KYA', 'キャ'), StudyData('KYU', 'キュ'), StudyData('KYO', 'キョ')]),
                StudyRow([StudyData('SHA', 'シャ'), StudyData('SHU', 'シュ'), StudyData('SHO', 'ショ')]),
                StudyRow([StudyData('CHA', 'チャ'), StudyData('CHU', 'チュ'), StudyData('CHO', 'チョ')]),
                StudyRow([StudyData('NYA', 'ニャ'), StudyData('NYU', 'ニュ'), StudyData('NYO', 'ニョ')]),
                StudyRow([StudyData('HYA', 'ヒャ'), StudyData('HYU', 'ヒュ'), StudyData('HYO', 'ヒョ')]),
                StudyRow([StudyData('MYA', 'ミャ'), StudyData('MYU', 'ミュ'), StudyData('MYO', 'ミョ')]),
                StudyRow([StudyData('RYA', 'リャ'), StudyData('RYU', 'リュ'), StudyData('RYO', 'リョ')]),
                StudyRow([StudyData('GYA', 'ギャ'), StudyData('GYU', 'ギュ'), StudyData('GYO', 'ギョ')]),
                StudyRow([StudyData('JA', 'ジャ'), StudyData('JU', 'ジュ'), StudyData('JO', 'ジョ')]),
                StudyRow([StudyData('DYA', 'ヂャ'), StudyData('DYU', 'ヂュ'), StudyData('DYO', 'ヂョ')]),
                StudyRow([StudyData('BYA', 'ビャ'), StudyData('BYU', 'ビュ'), StudyData('BYO', 'ビョ')]),
                StudyRow([StudyData('PYA', 'ピャ'), StudyData('PYU', 'ピュ'), StudyData('PYO', 'ピョ')]),
                StudyRow([StudyData('VYA', 'ヴャ'), StudyData('VYU', 'ヴュ'), StudyData('VYO', 'ヴョ')]),
                StudyRow([StudyData('SYA', 'スャ'), StudyData('SYU', 'スュ'), StudyData('SYO', 'スョ')]),
                StudyRow([StudyData('ZYA', 'ズャ'), StudyData('ZYU', 'ズュ'), StudyData('ZYO', 'ズョ')]),
                StudyRow([StudyData('TYA', 'テャ'), StudyData('TYU', 'テュ'), StudyData('TYO', 'テョ')]),
                StudyRow([StudyData('DYA', 'デャ'), StudyData('DYU', 'デュ'), StudyData('DYO', 'デョ')]),
                StudyRow([StudyData('FYA', 'フャ'), StudyData('FYU', 'フュ'), StudyData('FYO', 'フョ')]),
                StudyRow([StudyData('WYA', 'ウャ'), StudyData('WYU', 'ウュ'), StudyData('WYO', 'ウョ')]),
              ],
            ),
            StudyText(text: strings.studyKatakanaText4),
            StudyTable(
              title: strings.studyGeminatedTitle,
              rows: const [
                StudyRow([StudyData('TSU', 'ッ')]),
              ],
            ),
            StudyText(text: strings.studyKatakanaText5),
            StudyTable(
              title: strings.studyLongVowelsTitle,
              rows: const [
                StudyRow([StudyData('-', 'ー')]),
              ],
            ),
            StudyText(text: strings.studyKatakanaText6),
            StudyTable(
              title: strings.studyExtraSyllabesTitle,
              rows: const [
                StudyRow([StudyData.empty, StudyData('YI', 'イィ'), StudyData.empty, StudyData('YE', 'イェ'), StudyData(' ', ' ')]),
                StudyRow([StudyData('VA', 'ヴァ'), StudyData('VI', 'ヴィ'), StudyData('VU', 'ヴゥ'), StudyData('VE', 'ヴェ'), StudyData('VO', 'ヴォ')]),
                StudyRow([StudyData.empty, StudyData.empty, StudyData.empty, StudyData('SHE', 'シェ'), StudyData(' ', ' ')]),
                StudyRow([StudyData.empty, StudyData.empty, StudyData.empty, StudyData('JE', 'ジェ'), StudyData(' ', ' ')]),
                StudyRow([StudyData.empty, StudyData.empty, StudyData.empty, StudyData('CHE', 'チェ'), StudyData(' ', ' ')]),
                StudyRow([StudyData('SWA', 'スァ'), StudyData('SWI', 'スィ'), StudyData('SWU', 'スゥ'), StudyData('SWE', 'スェ'), StudyData('SWO', 'スォ')]),
                StudyRow([StudyData('ZWA', 'ズァ'), StudyData('ZWI', 'ズィ'), StudyData('ZWU', 'ズゥ'), StudyData('ZWE', 'ズェ'), StudyData('ZWO', 'ズォ')]),
                StudyRow([StudyData('TSA', 'ツァ'), StudyData('TSI', 'ツィ'), StudyData.empty, StudyData('TSE', 'ツェ'), StudyData('TSO', 'ツォ')]),
                StudyRow([StudyData('THA', 'テァ'), StudyData('TI', 'ティ'), StudyData('THU', 'テゥ'), StudyData('TYE', 'テェ'), StudyData('THO', 'テォ')]),
                StudyRow([StudyData('DHA', 'デァ'), StudyData('DI', 'ディ'), StudyData('DHU', 'デゥ'), StudyData('DYE', 'デェ'), StudyData('DHO', 'デォ')]),
                StudyRow([StudyData('TWA', 'トァ'), StudyData('TWI', 'トィ'), StudyData('TU', 'トゥ'), StudyData('TWE', 'トェ'), StudyData('TWO', 'トォ')]),
                StudyRow([StudyData('DWA', 'ドァ'), StudyData('DWI', 'ドィ'), StudyData('DU', 'ドゥ'), StudyData('DWE', 'ドェ'), StudyData('DWO', 'ドォ')]),
                StudyRow([StudyData('FA', 'ファ'), StudyData('FI', 'フィ'), StudyData('HU', 'ホゥ'), StudyData('FE', 'フェ'), StudyData('FO', 'フォ')]),
                StudyRow([StudyData.empty, StudyData('RYI', 'リィ'), StudyData.empty, StudyData('RYE', 'リェ'), StudyData(' ', ' ')]),
                StudyRow([StudyData('WA', 'ウァ'), StudyData('WI', 'ウィ'), StudyData('WU', 'ウゥ'), StudyData('WE', 'ウェ'), StudyData('WO', 'ウォ')]),
                StudyRow([StudyData('KWA', 'クァ'), StudyData('KWI', 'クィ'), StudyData('KWU', 'クゥ'), StudyData('KWE', 'クェ'), StudyData('KWO', 'クォ')]),
                StudyRow([StudyData('GWA', 'グァ'), StudyData('GWI', 'グィ'), StudyData('GWU', 'グゥ'), StudyData('GWE', 'グェ'), StudyData('GWO', 'グォ')]),
                StudyRow([StudyData('MWA', 'ムァ'), StudyData('MWI', 'ムィ'), StudyData('MWU', 'ムゥ'), StudyData('MWE', 'ムェ'), StudyData('MWO', 'ムォ')]),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
