import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/j_strings.dart';
import 'package:kana_plus_plus/src/domain/usecases/pre_training.controller.dart';
import 'package:kana_plus_plus/src/presentation/arguments/pre_training_arguments.dart';
import 'package:kana_plus_plus/src/presentation/state_management/pre_training.state_management.dart';
import 'package:kana_plus_plus/src/presentation/utils/routes.dart';
import 'package:kana_plus_plus/src/presentation/widgets/kana_type_tile.dart';
import 'package:kana_plus_plus/src/presentation/widgets/quantity_of_words_tile.dart';
import 'package:kana_plus_plus/src/presentation/widgets/show_hint_tile.dart';

class PreTrainingPage extends StatefulWidget {
  const PreTrainingPage(this.controller, {Key? key}) : super(key: key);

  final PreTrainingController controller;

  @override
  _PreTrainingPageState createState() => _PreTrainingPageState();
}

class _PreTrainingPageState extends State<PreTrainingPage> {
  late final PreTrainingStateManagement _stateManagement;

  @override
  void initState() {
    super.initState();
    _stateManagement = PreTrainingStateManagement(widget.controller);
  }

  @override
  Widget build(BuildContext context) {
    final JStrings strings = JStrings.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Training settings'), // AQUI localization
      ),
      body: AnimatedBuilder(
        animation: _stateManagement,
        builder: (context, child) => ListView(
          physics: const NeverScrollableScrollPhysics(),
          children: [
            ShowHintTile(
              showHint: _stateManagement.showHint,
              iconUrl: _stateManagement.showHintIconUrl,
              updateShowHint: _stateManagement.updateShowHint,
            ),
            KanaTypeTile(
              kanaType: _stateManagement.kanaType,
              iconUrl: _stateManagement.kanaTypeIconUrl,
              options: _stateManagement.getKanaTypeOptions,
              updateKanaType: _stateManagement.updateKanaType,
            ),
            QuantityOfWordsTile(
              quantity: _stateManagement.quantityOfWords,
              updateQuantity: _stateManagement.updateQuantity,
            ),
            Container(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: () => Navigator.pushNamed(
                  context,
                  Routes.training,
                  arguments: PreTrainingArguments(
                    showHint: _stateManagement.showHint,
                    kanaType: _stateManagement.kanaType,
                    quantityOfWords: _stateManagement.quantityOfWords,
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
