import 'package:flutter/material.dart';
import 'package:flutter_device_type/flutter_device_type.dart';
import 'package:kwriting/core/core.dart';
import 'package:kwriting/study/study.dart';

class StudyPage extends StatelessWidget {
  const StudyPage._({Key? key}) : super(key: key);

  static const routeName = '/study';

  static Route route() {
    return MaterialPageRoute(builder: (context) => const StudyPage._());
  }

  @override
  Widget build(BuildContext context) {
    final strings = JStrings.of(context)!;
    return FlexibleScaffold(
      title: strings.studyTitle,
      bannerUrl: BannerUrl.study,
      onBackButtonPressed: () => Navigator.popUntil(context, (route) => route.isFirst),
      sliverContent: SliverPadding(
        padding: const EdgeInsets.all(16),
        sliver: SliverFillRemaining(
          hasScrollBody: false,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _StudyTitle(title: strings.studyIntroductionTitle),
              _StudyText(text: strings.studyIntroductionText),
              _StudyTitle(title: strings.studyAlphabetTitle),
              _StudyText(text: strings.studyAlphabetText),
              _StudyTitle(title: strings.studyHiraganaTitle),
              _StudyText(text: strings.studyHiraganaText1),
              StudyTable(
                title: strings.studyMonographsTitle,
                rows: const [
                  StudyTableRow(a: ['A', 'あ'], i: ['I', 'い'], u: ['U', 'う'], e: ['E', 'え'], o: ['O', 'お']),
                  StudyTableRow(a: ['KA', 'か'], i: ['KI', 'き'], u: ['KU', 'く'], e: ['KE', 'け'], o: ['KO', 'こ']),
                  StudyTableRow(a: ['SA', 'さ'], i: ['SHI', 'し'], u: ['SU', 'す'], e: ['SE', 'せ'], o: ['SO', 'そ']),
                  StudyTableRow(a: ['TA', 'た'], i: ['CHI', 'ち'], u: ['TSU', 'つ'], e: ['TE', 'て'], o: ['TO', 'と']),
                  StudyTableRow(a: ['NA', 'な'], i: ['NI', 'に'], u: ['NU', 'ぬ'], e: ['NE', 'ね'], o: ['NO', 'の']),
                  StudyTableRow(a: ['HA', 'は'], i: ['HI', 'ひ'], u: ['FU', 'ふ'], e: ['HE', 'へ'], o: ['HO', 'ほ']),
                  StudyTableRow(a: ['MA', 'ま'], i: ['MI', 'み'], u: ['MU', 'む'], e: ['ME', 'め'], o: ['MO', 'も']),
                  StudyTableRow(a: ['YA', 'や'], i: [' ', ' '], u: ['YU', 'ゆ'], e: [' ', ' '], o: ['YO', 'よ']),
                  StudyTableRow(a: ['RA', 'ら'], i: ['RI', 'り'], u: ['RU', 'る'], e: ['RE', 'れ'], o: ['RO', 'ろ']),
                  StudyTableRow(a: ['WA', 'わ'], i: [' ', ' '], u: ['N', '	ん'], e: [' ', ' '], o: ['WO', 'を']),
                ],
              ),
              _StudyText(text: strings.studyHiraganaText2),
              StudyTable(
                title: strings.studyDiacriticsTitle,
                rows: const [
                  StudyTableRow(a: ['GA', 'が'], i: ['GI', 'ぎ'], u: ['GU', 'ぐ'], e: ['GE', 'げ'], o: ['GO', 'ご']),
                  StudyTableRow(a: ['ZA', 'ざ'], i: ['JI', 'じ'], u: ['ZU', 'ず'], e: ['ZE', 'ぜ'], o: ['ZO', 'ぞ']),
                  StudyTableRow(a: ['DA', 'だ'], i: ['DJI', 'ぢ'], u: ['DZU', 'づ'], e: ['DE', 'で'], o: ['DO', 'ど']),
                  StudyTableRow(a: ['BA', 'ば'], i: ['BI', 'び'], u: ['BU', 'ぶ'], e: ['BE', 'べ'], o: ['BO', 'ぼ']),
                  StudyTableRow(a: ['PA', 'ぱ'], i: ['PI', 'ぴ'], u: ['PU', 'ぷ'], e: ['PE', 'ぺ'], o: ['PO', 'ぽ']),
                ],
              ),
              _StudyText(text: strings.studyHiraganaText3),
              StudyTable(
                title: strings.studyDigraphsTitle,
                rows: const [
                  StudyTableRow(a: ['KYA', 'きゃ'], u: ['KYU', 'きゅ'], o: ['KYO', 'きょ']),
                  StudyTableRow(a: ['SHA', 'しゃ'], u: ['SHU', 'しゅ'], o: ['SHO', 'しょ']),
                  StudyTableRow(a: ['CHA', 'ちゃ'], u: ['CHU', 'ちゅ'], o: ['CHO', 'ちょ']),
                  StudyTableRow(a: ['NYA', 'にゃ'], u: ['NYU', 'にゅ'], o: ['NYO', 'にょ']),
                  StudyTableRow(a: ['HYA', 'ひゃ'], u: ['HYU', 'ひゅ'], o: ['HYO', 'ひょ']),
                  StudyTableRow(a: ['MYA', 'みゃ'], u: ['MYU', 'みゅ'], o: ['MYO', 'みょ']),
                  StudyTableRow(a: ['RYA', 'りゃ'], u: ['RYU', 'りゅ'], o: ['RYO', 'りょ']),
                  StudyTableRow(a: ['GYA', 'ぎゃ'], u: ['GYU', 'ぎゅ'], o: ['GYO', 'ぎょ']),
                  StudyTableRow(a: ['JA', 'じゃ'], u: ['JU', 'じゅ'], o: ['JO', 'じょ']),
                  StudyTableRow(a: ['DYA', 'ぢゃ'], u: ['DYU', 'ぢゅ'], o: ['DYO', 'ぢょ']),
                  StudyTableRow(a: ['BYA', 'びゃ'], u: ['BYU', 'びゅ'], o: ['BYO', 'びょ']),
                  StudyTableRow(a: ['PYA', 'ぴゃ'], u: ['PYU', 'ぴゅ'], o: ['PYO', 'ぴょ']),
                ],
              ),
              _StudyText(text: strings.studyHiraganaText4),
              StudyTable(
                title: strings.studyGeminatedTitle,
                rows: const [
                  StudyTableRow(a: ['TSU', 'っ']),
                ],
              ),
              _StudyTitle(title: strings.studyKatakanaTitle),
              _StudyText(text: strings.studyKatakanaText1),
              StudyTable(
                title: strings.studyMonographsTitle,
                rows: const [
                  StudyTableRow(a: ['A', 'ア'], i: ['I', 'イ'], u: ['U', 'ウ'], e: ['E', 'エ'], o: ['O', 'オ']),
                  StudyTableRow(a: ['KA', 'カ'], i: ['KI', 'キ'], u: ['KU', 'ク'], e: ['KE', 'ケ'], o: ['KO', 'コ']),
                  StudyTableRow(a: ['SA', 'サ'], i: ['SHI', 'シ'], u: ['SU', 'ス'], e: ['SE', 'セ'], o: ['SO', 'ソ']),
                  StudyTableRow(a: ['TA', 'タ'], i: ['CHI', 'チ'], u: ['TSU', 'ツ'], e: ['TE', 'テ'], o: ['TO', 'ト']),
                  StudyTableRow(a: ['NA', 'ナ'], i: ['NI', 'ニ'], u: ['NU', 'ヌ'], e: ['NE', 'ネ'], o: ['NO', 'ノ']),
                  StudyTableRow(a: ['HA', 'ハ'], i: ['HI', 'ヒ'], u: ['FU', 'フ'], e: ['HE', 'ヘ'], o: ['HO', 'ホ']),
                  StudyTableRow(a: ['MA', 'マ'], i: ['MI', 'ミ'], u: ['MU', 'ム'], e: ['ME', 'メ'], o: ['MO', 'モ']),
                  StudyTableRow(a: ['YA', 'ヤ'], i: [' ', ' '], u: ['YU', 'ユ'], e: [' ', ' '], o: ['YO', 'ヨ']),
                  StudyTableRow(a: ['RA', 'ラ'], i: ['RI', 'リ'], u: ['RU', 'ル'], e: ['RE', 'レ'], o: ['RO', 'ロ']),
                  StudyTableRow(a: ['WA', 'ワ'], i: [' ', ' '], u: ['N', 'ン'], e: [' ', ' '], o: ['WO', 'ヲ']),
                ],
              ),
              _StudyText(text: strings.studyKatakanaText2),
              StudyTable(
                title: strings.studyDiacriticsTitle,
                rows: const [
                  StudyTableRow(a: ['GA', 'ガ'], i: ['GI', 'ギ'], u: ['GU', 'グ'], e: ['GE', 'ゲ'], o: ['GO', 'ゴ']),
                  StudyTableRow(a: ['ZA', 'ザ'], i: ['JI', 'ジ'], u: ['ZU', 'ズ'], e: ['ZE', 'ゼ'], o: ['ZO', 'ゾ']),
                  StudyTableRow(a: ['DA', 'ダ'], i: ['DJI', 'ヂ'], u: ['DZU', 'ヅ'], e: ['DE', 'デ'], o: ['DO', 'ド']),
                  StudyTableRow(a: ['BA', 'バ'], i: ['BI', 'ビ'], u: ['BU', 'ブ'], e: ['BE', 'ベ'], o: ['BO', 'ボ']),
                  StudyTableRow(a: ['PA', 'パ'], i: ['PI', 'ピ'], u: ['PU', 'プ'], e: ['PE', 'ペ'], o: ['PO', 'ポ']),
                ],
              ),
              _StudyText(text: strings.studyKatakanaText3),
              StudyTable(
                title: strings.studyDigraphsTitle,
                rows: const [
                  StudyTableRow(a: ['KYA', 'キャ'], u: ['KYU', 'キュ'], o: ['KYO', 'キョ']),
                  StudyTableRow(a: ['SHA', 'シャ'], u: ['SHU', 'シュ'], o: ['SHO', 'ショ']),
                  StudyTableRow(a: ['CHA', 'チャ'], u: ['CHU', 'チュ'], o: ['CHO', 'チョ']),
                  StudyTableRow(a: ['NYA', 'ニャ'], u: ['NYU', 'ニュ'], o: ['NYO', 'ニョ']),
                  StudyTableRow(a: ['HYA', 'ヒャ'], u: ['HYU', 'ヒュ'], o: ['HYO', 'ヒョ']),
                  StudyTableRow(a: ['MYA', 'ミャ'], u: ['MYU', 'ミュ'], o: ['MYO', 'ミョ']),
                  StudyTableRow(a: ['RYA', 'リャ'], u: ['RYU', 'リュ'], o: ['RYO', 'リョ']),
                  StudyTableRow(a: ['GYA', 'ギャ'], u: ['GYU', 'ギュ'], o: ['GYO', 'ギョ']),
                  StudyTableRow(a: ['JA', 'ジャ'], u: ['JU', 'ジュ'], o: ['JO', 'ジョ']),
                  StudyTableRow(a: ['DYA', 'ヂャ'], u: ['DYU', 'ヂュ'], o: ['DYO', 'ヂョ']),
                  StudyTableRow(a: ['BYA', 'ビャ'], u: ['BYU', 'ビュ'], o: ['BYO', 'ビョ']),
                  StudyTableRow(a: ['PYA', 'ピャ'], u: ['PYU', 'ピュ'], o: ['PYO', 'ピョ']),
                  StudyTableRow(a: ['VYA', 'ヴャ'], u: ['VYU', 'ヴュ'], o: ['VYO', 'ヴョ']),
                  StudyTableRow(a: ['SYA', 'スャ'], u: ['SYU', 'スュ'], o: ['SYO', 'スョ']),
                  StudyTableRow(a: ['ZYA', 'ズャ'], u: ['ZYU', 'ズュ'], o: ['ZYO', 'ズョ']),
                  StudyTableRow(a: ['TYA', 'テャ'], u: ['TYU', 'テュ'], o: ['TYO', 'テョ']),
                  StudyTableRow(a: ['DYA', 'デャ'], u: ['DYU', 'デュ'], o: ['DYO', 'デョ']),
                  StudyTableRow(a: ['FYA', 'フャ'], u: ['FYU', 'フュ'], o: ['FYO', 'フョ']),
                  StudyTableRow(a: ['WYA', 'ウャ'], u: ['WYU', 'ウュ'], o: ['WYO', 'ウョ']),
                ],
              ),
              _StudyText(text: strings.studyKatakanaText4),
              StudyTable(
                title: strings.studyGeminatedTitle,
                rows: const [
                  StudyTableRow(a: ['TSU', 'ッ']),
                ],
              ),
              _StudyText(text: strings.studyKatakanaText5),
              StudyTable(
                title: strings.studyLongVowelsTitle,
                rows: const [
                  StudyTableRow(a: ['-', 'ー']),
                ],
              ),
              _StudyText(text: strings.studyKatakanaText6),
              StudyTable(
                title: strings.studyExtraSyllabesTitle,
                rows: const [
                  StudyTableRow(a: [' ', ' '], i: ['YI', 'イィ'], u: [' ', ' '], e: ['YE', 'イェ'], o: [' ', ' ']),
                  StudyTableRow(a: ['VA', 'ヴァ'], i: ['VI', 'ヴィ'], u: ['VU', 'ヴゥ'], e: ['VE', 'ヴェ'], o: ['VO', 'ヴォ']),
                  StudyTableRow(a: [' ', ' '], i: [' ', ' '], u: [' ', ' '], e: ['SHE', 'シェ'], o: [' ', ' ']),
                  StudyTableRow(a: [' ', ' '], i: [' ', ' '], u: [' ', ' '], e: ['JE', 'ジェ'], o: [' ', ' ']),
                  StudyTableRow(a: [' ', ' '], i: [' ', ' '], u: [' ', ' '], e: ['CHE', 'チェ'], o: [' ', ' ']),
                  StudyTableRow(a: ['SWA', 'スァ'], i: ['SWI', 'スィ'], u: ['SWU', 'スゥ'], e: ['SWE', 'スェ'], o: ['SWO', 'スォ']),
                  StudyTableRow(a: ['ZWA', 'ズァ'], i: ['ZWI', 'ズィ'], u: ['ZWU', 'ズゥ'], e: ['ZWE', 'ズェ'], o: ['ZWO', 'ズォ']),
                  StudyTableRow(a: ['TSA', 'ツァ'], i: ['TSI', 'ツィ'], u: [' ', ' '], e: ['TSE', 'ツェ'], o: ['TSO', 'ツォ']),
                  StudyTableRow(a: ['THA', 'テァ'], i: ['TI', 'ティ'], u: ['THU', 'テゥ'], e: ['TYE', 'テェ'], o: ['THO', 'テォ']),
                  StudyTableRow(a: ['DHA', 'デァ'], i: ['DI', 'ディ'], u: ['DHU', 'デゥ'], e: ['DYE', 'デェ'], o: ['DHO', 'デォ']),
                  StudyTableRow(a: ['TWA', 'トァ'], i: ['TWI', 'トィ'], u: ['TU', 'トゥ'], e: ['TWE', 'トェ'], o: ['TWO', 'トォ']),
                  StudyTableRow(a: ['DWA', 'ドァ'], i: ['DWI', 'ドィ'], u: ['DU', 'ドゥ'], e: ['DWE', 'ドェ'], o: ['DWO', 'ドォ']),
                  StudyTableRow(a: ['FA', 'ファ'], i: ['FI', 'フィ'], u: ['HU', 'ホゥ'], e: ['FE', 'フェ'], o: ['FO', 'フォ']),
                  StudyTableRow(a: [' ', ' '], i: ['RYI', 'リィ'], u: [' ', ' '], e: ['RYE', 'リェ'], o: [' ', ' ']),
                  StudyTableRow(a: ['WA', 'ウァ'], i: ['WI', 'ウィ'], u: ['WU', 'ウゥ'], e: ['WE', 'ウェ'], o: ['WO', 'ウォ']),
                  StudyTableRow(a: ['KWA', 'クァ'], i: ['KWI', 'クィ'], u: ['KWU', 'クゥ'], e: ['KWE', 'クェ'], o: ['KWO', 'クォ']),
                  StudyTableRow(a: ['GWA', 'グァ'], i: ['GWI', 'グィ'], u: ['GWU', 'グゥ'], e: ['GWE', 'グェ'], o: ['GWO', 'グォ']),
                  StudyTableRow(a: ['MWA', 'ムァ'], i: ['MWI', 'ムィ'], u: ['MWU', 'ムゥ'], e: ['MWE', 'ムェ'], o: ['MWO', 'ムォ']),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StudyTitle extends StatelessWidget {
  const _StudyTitle({required this.title, Key? key}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(title, style: TextStyle(fontSize: Device.get().isTablet ? 28.0 : 18.0, fontWeight: FontWeight.bold)),
    );
  }
}

class _StudyText extends StatelessWidget {
  const _StudyText({required this.text, Key? key}) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 8, 0, 8),
      child: Text(text, style: TextStyle(fontSize: Device.get().isTablet ? 24.0 : 16.0), textAlign: TextAlign.justify),
    );
  }
}
