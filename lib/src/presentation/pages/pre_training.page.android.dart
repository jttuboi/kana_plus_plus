import 'package:flutter/material.dart';
import 'package:kana_plus_plus/src/domain/usecases/pre_training.controller.dart';
import 'package:kana_plus_plus/src/presentation/arguments/pre_training_arguments.dart';
import 'package:kana_plus_plus/src/presentation/state_management/pre_training.state_management.dart';
import 'package:kana_plus_plus/src/presentation/utils/routes.dart';
import 'package:kana_plus_plus/src/presentation/widgets/kana_type_tile.dart';
import 'package:kana_plus_plus/src/presentation/widgets/quantity_of_words_tile.dart';
import 'package:kana_plus_plus/src/presentation/widgets/show_hint_tile.dart';
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Training settings'), // AQUI localization
      ),
      body: Consumer<PreTrainingProvider>(
        builder: (context, provider, child) => ListView(
          physics: const NeverScrollableScrollPhysics(),
          children: [
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
            Container(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: () => Navigator.pushNamed(
                  context,
                  Routes.training,
                  arguments: PreTrainingArguments(
                    showHint: preTrainingController.showHint,
                    kanaType: preTrainingController.kanaType,
                    quantityOfWords: preTrainingController.quantityOfWords,
                  ),
                ),
                child: const Icon(Icons.play_arrow),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
