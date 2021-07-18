import "package:flutter/material.dart";
import 'package:kana_plus_plus/src/widgets/kana_type_tile.dart';
import 'package:kana_plus_plus/src/widgets/quantity_of_cards_tile.dart';
import 'package:kana_plus_plus/src/widgets/show_hint_tile.dart';
import 'package:kana_plus_plus/src/models/pre_training_arguments.dart';
import 'package:kana_plus_plus/src/shared/routes.dart';

class PreTrainingPage extends StatefulWidget {
  const PreTrainingPage({Key? key}) : super(key: key);

  @override
  _PreTrainingPageState createState() => _PreTrainingPageState();
}

class _PreTrainingPageState extends State<PreTrainingPage> {
  bool _showHint = false;
  int _kanaType = 2; // both
  int _quantityOfCards = 5;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Training settings"), // AQUI localization
      ),
      body: ListView(
        physics: const NeverScrollableScrollPhysics(),
        children: [
          ShowHintTile(
            _showHint,
            onChanged: (value) => setState(() {
              _showHint = value;
            }),
          ),
          KanaTypeTile(
            _kanaType,
            onOptionSelected: (index) => setState(() {
              _kanaType = index;
            }),
          ),
          QuantityOfCardsTile(
            _quantityOfCards,
            onQuantityChanged: (quantity) => setState(() {
              _quantityOfCards = quantity;
            }),
          ),
          Container(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () => Navigator.pushNamed(
                context,
                Routes.training,
                arguments: PreTrainingArguments(
                  showHint: _showHint,
                  kanaType: _kanaType,
                  quantityOfCards: _quantityOfCards,
                ),
              ),
              child: const Icon(Icons.play_arrow),
            ),
          ),
        ],
      ),
    );
  }
}
