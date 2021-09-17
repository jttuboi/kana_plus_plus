import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/j_strings.dart';
import 'package:kana_plus_plus/src/data/datasources/banner_url.storage.dart';
import 'package:kana_plus_plus/src/presentation/utils/consts.dart';
import 'package:kana_plus_plus/src/presentation/widgets/flexible_scaffold.dart';
import 'package:kana_plus_plus/src/presentation/widgets/study_table.dart';
import 'package:kana_plus_plus/src/presentation/widgets/study_table_row.dart';

class StudyPage extends StatelessWidget {
  const StudyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const studyIntroductionTitle = 'Introdução';
    const studyIntroductionText = ' auhd uahd uahd uashd uashd uahd uahsd  ';
    const studyHiraganaTitle = 'Hiragana';
    const studyHiraganaText1 = 'ijvbinjibvjnivbjn ivbj nivbj nivb jnvib jnvbi njvbi njvbi v ibjnivbjnivbj nivbnjvbij nbvijnb ijb ';
    const studyKatakanaTitle = 'Katakana';
    const studyKatakanaText1 = 'ijvbinjibvjnivbjn ivbj nivbj nivb jnvib jnvbi njvbi njvbi vbj nivbnjvbij nbvijnb ijb ';
    const studyMonographsTitle = 'Gojuon';
    const studyDiacriticsTitle = 'Gojuon with han dakuten';
    const studyDigraphsTitle = 'Yoon and yoon with han dakuten';
    const studyGeminatedTitle = 'Sokuon';
    const studyExtraDigraphsTitle = 'Yoon katkaana';

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
            children: const [
              _StudyTitle(title: studyIntroductionTitle),
              _StudyText(text: studyIntroductionText),
              _StudyTitle(title: studyHiraganaTitle),
              _StudyText(text: studyHiraganaText1),
              StudyTable(
                title: studyMonographsTitle,
                rows: [
                  StudyTableRow(a: ['A', 'あ'], i: ['I', 'い'], u: ['U', 'う'], e: ['E', 'え'], o: ['O', 'お']),
                  StudyTableRow(a: ['KA', 'か'], i: ['KI', 'き'], u: ['KU', 'く'], e: ['KE', 'け'], o: ['KO', 'こ']),
                  StudyTableRow(a: ['SA', 'さ'], i: ['SHI', 'し'], u: ['SU', 'す'], e: ['SE', 'せ'], o: ['SO', 'そ']),
                  StudyTableRow(a: ['TA', 'た'], i: ['CHI', 'ち'], u: ['TSU', 'つ'], e: ['TE', 'て'], o: ['TO', 'と']),
                  StudyTableRow(a: ['NA', 'な'], i: ['NI', 'に'], u: ['NU', 'ぬ'], e: ['NE', 'ね'], o: ['NO', 'の']),
                  StudyTableRow(a: ['HA', 'は'], i: ['HI', 'ひ'], u: ['FU', 'ふ'], e: ['HE', 'へ'], o: ['HO', 'ほ']),
                  StudyTableRow(a: ['MA', 'ま'], i: ['MI', 'み'], u: ['MU', 'む'], e: ['ME', 'め'], o: ['MO', 'も']),
                  StudyTableRow(a: ['YA', 'や'], u: ['YU', 'ゆ'], o: ['YO', 'よ']),
                  StudyTableRow(a: ['RA', 'ら'], i: ['RI', 'り'], u: ['RU', 'る'], e: ['RE', 'れ'], o: ['RO', 'ろ']),
                  StudyTableRow(a: ['WA', 'わ'], u: ['N', '	ん'], o: ['WO', 'を']),
                ],
              ),
              StudyTable(
                title: studyDiacriticsTitle,
                rows: [
                  StudyTableRow(a: ['GA', 'が'], i: ['GI', 'ぎ'], u: ['GU', 'ぐ'], e: ['GE', 'げ'], o: ['GO', 'ご']),
                  StudyTableRow(a: ['ZA', 'ざ'], i: ['JI', 'じ'], u: ['ZU', 'ず'], e: ['ZE', 'ぜ'], o: ['ZO', 'ぞ']),
                  StudyTableRow(a: ['DA', 'だ'], i: ['DJI', 'ぢ'], u: ['DZU', 'づ'], e: ['DE', 'で'], o: ['DO', 'ど']),
                  StudyTableRow(a: ['BA', 'ば'], i: ['BI', 'び'], u: ['BU', 'ぶ'], e: ['BE', 'べ'], o: ['BO', 'ぼ']),
                  StudyTableRow(a: ['PA', 'ぱ'], i: ['PI', 'ぴ'], u: ['PU', 'ぷ'], e: ['PE', 'ぺ'], o: ['PO', 'ぽ']),
                ],
              ),
              StudyTable(
                title: studyDigraphsTitle,
                rows: [
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
              StudyTable(
                title: studyGeminatedTitle,
                rows: [
                  StudyTableRow(a: ['KKA', 'っか'], i: ['KKI', 'っき'], u: ['KKU', 'っく'], e: ['KKE', 'っけ'], o: ['KKO', 'っこ']),
                  StudyTableRow(a: ['SSA', 'っさ'], i: ['SSHI', 'っし'], u: ['SSU', 'っす'], e: ['SSE', 'っせ'], o: ['SSO', 'っそ']),
                  StudyTableRow(a: ['TTA', 'った'], i: ['CCHI', 'っち'], u: ['TTSU', 'っつ'], e: ['TTE', 'って'], o: ['TTO', 'っと']),
                  StudyTableRow(a: ['BBA', 'っば'], i: ['BBI', 'っび'], u: ['BBU', 'っぶ'], e: ['BBE', 'っべ'], o: ['BBO', 'っぼ']),
                  StudyTableRow(a: ['PPA', 'っぱ'], i: ['PPI', 'っぴ'], u: ['PPU', 'っぷ'], e: ['PPE', 'っぺ'], o: ['PPO', 'っぽ']),
                ],
              ),
              _StudyTitle(title: studyKatakanaTitle),
              _StudyText(text: studyKatakanaText1),
              StudyTable(
                title: studyMonographsTitle,
                rows: [
                  StudyTableRow(a: ['A', 'ア'], i: ['I', 'イ'], u: ['U', 'ウ'], e: ['E', 'エ'], o: ['O', 'オ']),
                  StudyTableRow(a: ['KA', 'カ'], i: ['KI', 'キ'], u: ['KU', 'ク'], e: ['KE', 'ケ'], o: ['KO', 'コ']),
                  StudyTableRow(a: ['SA', 'サ'], i: ['SHI', 'シ'], u: ['SU', 'ス'], e: ['SE', 'セ'], o: ['SO', 'ソ']),
                  StudyTableRow(a: ['TA', 'タ'], i: ['CHI', 'チ'], u: ['TSU', 'ツ'], e: ['TE', 'テ'], o: ['TO', 'ト']),
                  StudyTableRow(a: ['NA', 'ナ'], i: ['NI', 'ニ'], u: ['NU', 'ヌ'], e: ['NE', 'ネ'], o: ['NO', 'ノ']),
                  StudyTableRow(a: ['HA', 'ハ'], i: ['HI', 'ヒ'], u: ['FU', 'フ'], e: ['HE', 'ヘ'], o: ['HO', 'ホ']),
                  StudyTableRow(a: ['MA', 'マ'], i: ['MI', 'ミ'], u: ['MU', 'ム'], e: ['ME', 'メ'], o: ['MO', 'モ']),
                  StudyTableRow(a: ['YA', 'ヤ'], u: ['YU', 'ユ'], o: ['YO', 'ヨ']),
                  StudyTableRow(a: ['RA', 'ラ'], i: ['RI', 'リ'], u: ['RU', 'ル'], e: ['RE', 'レ'], o: ['RO', 'ロ']),
                  StudyTableRow(a: ['WA', 'ワ'], u: ['N', 'ン'], o: ['WO', 'ヲ']),
                ],
              ),
              StudyTable(
                title: studyDiacriticsTitle,
                rows: [
                  StudyTableRow(a: ['GA', 'ガ'], i: ['GI', 'ギ'], u: ['GU', 'グ'], e: ['GE', 'ゲ'], o: ['GO', 'ゴ']),
                  StudyTableRow(a: ['ZA', 'ザ'], i: ['JI', 'ジ'], u: ['ZU', 'ズ'], e: ['ZE', 'ゼ'], o: ['ZO', 'ゾ']),
                  StudyTableRow(a: ['DA', 'ダ'], i: ['DJI', 'ヂ'], u: ['DZU', 'ヅ'], e: ['DE', 'デ'], o: ['DO', 'ド']),
                  StudyTableRow(a: ['BA', 'バ'], i: ['BI', 'ビ'], u: ['BU', 'ブ'], e: ['BE', 'ベ'], o: ['BO', 'ボ']),
                  StudyTableRow(a: ['PA', 'パ'], i: ['PI', 'ピ'], u: ['PU', 'プ'], e: ['PE', 'ペ'], o: ['PO', 'ポ']),
                ],
              ),
              StudyTable(
                title: studyDigraphsTitle,
                rows: [
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
                ],
              ),
              StudyTable(
                title: studyExtraDigraphsTitle,
                rows: [
                  StudyTableRow(a: ['VYA', 'ヴャ'], u: ['VYU', 'ヴュ'], o: ['VYO', 'ヴョ']),
                  StudyTableRow(a: ['SYA', 'スャ'], u: ['SYU', 'スュ'], o: ['SYO', 'スョ']),
                  StudyTableRow(a: ['ZYA', 'ズャ'], u: ['ZYU', 'ズュ'], o: ['ZYO', 'ズョ']),
                  StudyTableRow(a: ['TYA', 'テャ'], u: ['TYU', 'テュ'], o: ['TYO', 'テョ']),
                  StudyTableRow(a: ['DYA', 'デャ'], u: ['DYU', 'デュ'], o: ['DYO', 'デョ']),
                  StudyTableRow(a: ['FYA', 'フャ'], u: ['FYU', 'フュ'], o: ['FYO', 'フョ']),
                  StudyTableRow(a: ['WYA', 'ウャ'], u: ['WYU', 'ウュ'], o: ['WYO', 'ウョ']),
                ],
              ),
              StudyTable(
                title: studyExtraDigraphsTitle,
                rows: [
                  StudyTableRow(a: ['TSU', 'ッ'], u: ['-', 'ー']),
                ],
              ),

// ッカ KKA	ッキ KKI	ック KKU	ッケ KKE	ッコ KKO
// ッサ SSA	ッシ SSHI	ッス SSU	ッセ SSE	ッソ SSO
// ッタ TTA	ッチ CCHI	ッツ TTSU	ッテ TTE	ット TTO
// ッパ PPA	ッピ PPI	ップ PPU	ッぺ PPE	ッポ PPO

//             イィ YI		    イェ YE
//     ヴァ VA	ヴィ VI	ヴ VU	ヴェ VE	ヴォ VO
//                             シェ SHE
//                             ジェ JE
//                             チェ CHE
// (スヮ)スァ SWA	スィ SI	スゥ SWU	スェ SWE	スォ SWO
// (ズヮ)ズァ ZWA	ズィ ZI	ズゥ ZWU	ズェ ZWE	ズォ ZWO
//     ツァ TSA	ツィ TSI		    ツェ TSE	ツォ TSO
//     テァ THA	ティ TI	テゥ THU	テェ TYE	テォ THO
//     デァ DHA	ディ DI	デゥ DHU	デェ DYE	デォ DHO
// (トヮ)トァ TWA	トィ TWI	トゥ TU	トェ TWE	トォ TWO
// (ドヮ)ドァ DWA	ドィ DWI	ドゥ DU	ドェ DWE	ドォ DWO
//     ファ FA	フィ FI	ホゥ HU	フェ FE	フォ FO
//             リィ RYI	        リェ RYE
//     ウァ WA	ウィ WI	ウゥ WU	ウェ WE	ウォ WO
// (クヮ)クァ KWA	クィ KWI	クゥ KWU	クェ KWE	クォ KWO
// (グヮ)グァ GWA	グィ GWI	グゥ GWU	グェ GWE	グォ GWO
// (ムヮ)ムァ MWA	ムィ MWI	ムゥ MWU	ムェ MWE	ムォ MWO
            ],
          ),
        ),
      ),
    );
  }
}

class _StudyTitle extends StatelessWidget {
  const _StudyTitle({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(title, style: studyTitleTextStyle),
    );
  }
}

class _StudyText extends StatelessWidget {
  const _StudyText({Key? key, required this.text}) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 8.0, 0.0, 8.0),
      child: Text(text, style: studyTextStyleText),
    );
  }
}
