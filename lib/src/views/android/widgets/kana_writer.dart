import "package:flutter/material.dart";
import 'package:kana_plus_plus/src/domain/entities/writing_hand.dart';

class KanaWriter extends StatefulWidget {
  const KanaWriter({
    Key? key,
    required this.writingHand,
    required this.showHint,
  }) : super(key: key);

  final WritingHand writingHand;
  final bool showHint;

  @override
  _KanaWriterState createState() => _KanaWriterState();
}

class _KanaWriterState extends State<KanaWriter> {
  @override
  Widget build(BuildContext context) {
    return widget.writingHand == WritingHand.right
        ? _buildRightHand()
        : _buildLeftHand();
  }

  Widget _buildRightHand() {
    return Row(
      children: [
        _buildSupportButtons(),
        const SizedBox(width: 4),
        _buildKanaDraw(),
      ],
    );
  }

  Widget _buildLeftHand() {
    return Row(
      children: [
        _buildKanaDraw(),
        const SizedBox(width: 4),
        _buildSupportButtons(),
      ],
    );
  }

  Widget _buildSupportButtons() {
    return Column(
      children: [
        Flexible(
          fit: FlexFit.tight,
          child: ElevatedButton(
            onPressed: () {},
            child: const ImageIcon(
                AssetImage("lib/assets/icons/black/eraser.png")),
          ),
        ),
        const SizedBox(height: 4),
        Flexible(
          fit: FlexFit.tight,
          child: ElevatedButton(
            onPressed: () {},
            child:
                const ImageIcon(AssetImage("lib/assets/icons/black/undo.png")),
          ),
        ),
      ],
    );
  }

  Widget _buildKanaDraw() {
    return Expanded(
      child: AspectRatio(
        aspectRatio: 1.0,
        child: Container(
          color: Colors.grey,
          child: Text(widget.showHint ? "showing hint" : "hided hint"),
        ),
      ),
    );
  }
}
