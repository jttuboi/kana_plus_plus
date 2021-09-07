import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/j_strings.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kana_plus_plus/src/data/datasources/banner_url.storage.dart';
import 'package:kana_plus_plus/src/data/datasources/icon_url.storage.dart';
import 'package:kana_plus_plus/src/domain/controllers/pre_training.controller.dart';
import 'package:kana_plus_plus/src/presentation/arguments/pre_training_arguments.dart';
import 'package:kana_plus_plus/src/presentation/state_management/pre_training.provider.dart';
import 'package:kana_plus_plus/src/presentation/utils/routes.dart';
import 'package:kana_plus_plus/src/presentation/widgets/kana_type_tile.dart';
import 'package:kana_plus_plus/src/presentation/widgets/quantity_of_words_tile.dart';
import 'package:kana_plus_plus/src/presentation/widgets/show_hint_tile.dart';
import 'package:kana_plus_plus/src/presentation/widgets/sliver_flexible_app_bar.dart';
import 'package:provider/provider.dart';

class PreTrainingPage extends StatelessWidget {
  const PreTrainingPage(this.preTrainingController, {Key? key}) : super(key: key);

  final PreTrainingController preTrainingController;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => PreTrainingProvider(preTrainingController)),
      ],
      builder: (context, child) => _PreTrainingPage(preTrainingController: preTrainingController),
    );
  }
}

class _PreTrainingPage extends StatelessWidget {
  const _PreTrainingPage({Key? key, required this.preTrainingController}) : super(key: key);

  final PreTrainingController preTrainingController;

  @override
  Widget build(BuildContext context) {
    final strings = JStrings.of(context)!;
    return Scaffold(
      body: CustomScrollView(
        physics: const NeverScrollableScrollPhysics(),
        slivers: [
          SliverFlexibleAppBar(
            title: strings.preTrainingTitle,
            bannerUrl: BannerUrl.preTraining,
            isFlexible: false,
            onBackButtonPressed: () => Navigator.popUntil(context, (route) => route.isFirst),
          ),
          SliverFillRemaining(
            child: Consumer<PreTrainingProvider>(
              builder: (context, provider, child) {
                return ListView(
                  padding: EdgeInsets.zero,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    const SizedBox(height: 8.0),
                    ShowHintTile(
                      showHint: preTrainingController.showHint,
                      iconUrl: preTrainingController.showHintIconUrl,
                      updateShowHint: provider.updateShowHint,
                    ),
                    KanaTypeTile(
                      kanaType: preTrainingController.kanaType,
                      iconUrl: preTrainingController.kanaTypeIconUrl,
                      options: provider.getKanaTypeOptions,
                      updateKanaType: provider.updateKanaType,
                    ),
                    QuantityOfWordsTile(
                      quantity: preTrainingController.quantityOfWords,
                      updateQuantity: provider.updateQuantity,
                    ),
                    MaterialButton(
                      color: Theme.of(context).accentColor,
                      shape: const CircleBorder(),
                      onPressed: () => Navigator.pushNamedAndRemoveUntil(
                        context,
                        Routes.training,
                        ModalRoute.withName(Routes.menu),
                        arguments: PreTrainingArguments(
                          showHint: preTrainingController.showHint,
                          kanaType: preTrainingController.kanaType,
                          quantityOfWords: preTrainingController.quantityOfWords,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: SvgPicture.asset(
                          IconUrl.play,
                          color: Theme.of(context).accentIconTheme.color,
                          width: Theme.of(context).accentIconTheme.size,
                          height: Theme.of(context).accentIconTheme.size,
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
