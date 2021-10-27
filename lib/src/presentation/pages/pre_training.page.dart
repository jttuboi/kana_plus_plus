import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/j_strings.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kwriting/src/domain/controllers/pre_training.controller.dart';
import 'package:kwriting/src/infrastructure/datasources/banner_url.storage.dart';
import 'package:kwriting/src/infrastructure/datasources/icon_url.storage.dart';
import 'package:kwriting/src/presentation/arguments/pre_training_arguments.dart';
import 'package:kwriting/src/presentation/state_management/pre_training.change_notifier.dart';
import 'package:kwriting/src/presentation/utils/consts.dart';
import 'package:kwriting/src/presentation/utils/routes.dart';
import 'package:kwriting/src/presentation/widgets/flexible_scaffold.dart';
import 'package:kwriting/src/presentation/widgets/kana_type_tile.dart';
import 'package:kwriting/src/presentation/widgets/quantity_of_words_tile.dart';
import 'package:kwriting/src/presentation/widgets/show_hint_tile.dart';
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
  const _PreTrainingPage({
    required this.preTrainingController,
    Key? key,
  }) : super(key: key);

  final PreTrainingController preTrainingController;

  @override
  Widget build(BuildContext context) {
    final strings = JStrings.of(context)!;
    return FlexibleScaffold(
      isFlexible: false,
      title: strings.preTrainingTitle,
      bannerUrl: BannerUrl.preTraining,
      onBackButtonPressed: () => Navigator.popUntil(context, (route) => route.isFirst),
      sliverContent: SliverFillRemaining(
        child: Consumer<PreTrainingProvider>(
          builder: (context, provider, child) {
            return ListView(
              padding: EdgeInsets.zero,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                const SizedBox(height: 8),
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
                  color: Theme.of(context).colorScheme.secondary,
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
                    padding: const EdgeInsets.all(16),
                    child: SvgPicture.asset(
                      IconUrl.play,
                      color: preTrainingPlayIconThemeData.color,
                      width: preTrainingPlayIconThemeData.size,
                      height: preTrainingPlayIconThemeData.size,
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
