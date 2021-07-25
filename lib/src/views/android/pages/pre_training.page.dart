import "package:flutter/material.dart";
import 'package:kana_plus_plus/src/presentation/widgets/kana_type_tile.dart';
import 'package:kana_plus_plus/src/presentation/widgets/quantity_of_words_tile.dart';
import 'package:kana_plus_plus/src/presentation/widgets/show_hint_tile.dart';
import 'package:kana_plus_plus/src/models/pre_training_arguments.dart';
import 'package:kana_plus_plus/src/presentation/routes.dart';

class PreTrainingPage extends StatefulWidget {
  const PreTrainingPage({Key? key}) : super(key: key);

  @override
  _PreTrainingPageState createState() => _PreTrainingPageState();
}

class _PreTrainingPageState extends State<PreTrainingPage> {
  bool _showHint = true;
  int _kanaType = 2; // both
  int _quantityOfWords = 5;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Training settings"), // AQUI localization
      ),
      body: ListView(
        physics: const NeverScrollableScrollPhysics(),
        children: [
          // ShowHintTile(
          //   _showHint,
          //   onChanged: (value) => setState(() {
          //     _showHint = value;
          //   }),
          // ),
          // KanaTypeTile(
          //   _kanaType,
          //   onOptionSelected: (index) => setState(() {
          //     _kanaType = index;
          //   }),
          // ),
          // QuantityOfWordsTile(
          //   _quantityOfWords,
          //   onQuantityChanged: (quantity) => setState(() {
          //     _quantityOfWords = quantity;
          //   }),
          // ),
          Container(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () => Navigator.pushNamed(
                context,
                Routes.training,
                arguments: PreTrainingArguments(
                  showHint: _showHint,
                  kanaType: _kanaType,
                  quantityOfWords: _quantityOfWords,
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
