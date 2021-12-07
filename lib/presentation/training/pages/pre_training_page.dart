import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kwriting/domain/domain.dart';
import 'package:kwriting/infra/infra.dart';
import 'package:kwriting/presentation/settings/settings.dart';
import 'package:kwriting/presentation/shared/shared.dart';
import 'package:kwriting/presentation/training/training.dart';
import 'package:provider/provider.dart';

class PreTrainingPage extends StatelessWidget {
  const PreTrainingPage({
    required this.showHintRepository,
    required this.kanaTypeRepository,
    required this.quantityOfWordsRepository,
    Key? key,
  }) : super(key: key);

  static const routeName = '/pre_training';

  static Route route() {
    return MaterialPageRoute(builder: (context) {
      return PreTrainingPage(
        showHintRepository: ShowHintRepository(HiveDatabase()),
        kanaTypeRepository: KanaTypeRepository(HiveDatabase()),
        quantityOfWordsRepository: QuantityOfWordsRepository(HiveDatabase()),
      );
    });
  }

  final IShowHintRepository showHintRepository;
  final IKanaTypeRepository kanaTypeRepository;
  final IQuantityOfWordsRepository quantityOfWordsRepository;

  @override
  Widget build(BuildContext context) {
    final strings = JStrings.of(context)!;
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ShowHintChangeNotifier(showHintRepository, mustPersist: false)),
        ChangeNotifierProvider(create: (context) => KanaTypeChangeNotifier(kanaTypeRepository, mustPersist: false)),
        ChangeNotifierProvider(create: (context) => QuantityOfWordsChangeNotifier(quantityOfWordsRepository, mustPersist: false)),
      ],
      builder: (context, child) {
        return FlexibleScaffold(
          isFlexible: false,
          title: strings.preTrainingTitle,
          bannerUrl: BannerUrl.preTraining,
          onBackButtonPressed: () => Navigator.popUntil(context, (route) => route.isFirst),
          sliverContent: SliverFillRemaining(
            child: ListView(
              padding: EdgeInsets.zero,
              physics: const NeverScrollableScrollPhysics(),
              children: const [
                SizedBox(height: 8),
                ShowHintTile(),
                KanaTypeTile(),
                QuantityOfWordsTile(),
                PlayButton(),
              ],
            ),
          ),
        );
      },
    );
  }
}

class PlayButton extends StatelessWidget {
  const PlayButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      color: Theme.of(context).colorScheme.secondary,
      shape: const CircleBorder(),
      onPressed: () => _onPlayClicked(context),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: SvgPicture.asset(IconUrl.play, color: Colors.grey.shade300, width: 40, height: 40),
      ),
    );
  }

  void _onPlayClicked(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(
      context,
      TrainingPage.routeName,
      (route) => route.isFirst,
      arguments: {
        TrainingPage.argTrainingSettings: TrainingSettings(
          showHint: context.read<ShowHintChangeNotifier>().data.showHint,
          kanaType: context.read<KanaTypeChangeNotifier>().data.kanaType,
          quantityOfWords: context.read<QuantityOfWordsChangeNotifier>().quantity,
          languageCode: Localizations.localeOf(context).languageCode,
        ),
      },
    );
  }
}
