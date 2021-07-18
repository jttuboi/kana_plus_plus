import "package:flutter/material.dart";
import 'package:kana_plus_plus/src/shared/icons.dart';
import 'package:kana_plus_plus/src/shared/writing_hand.dart';

class KanaWriter extends StatefulWidget {
  const KanaWriter({
    Key? key,
    required this.writingHand,
  }) : super(key: key);

  final WritingHand writingHand;

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
            child: JIcons.eraser,
          ),
        ),
        const SizedBox(height: 4),
        Flexible(
          fit: FlexFit.tight,
          child: ElevatedButton(
            onPressed: () {},
            child: JIcons.undo,
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
        ),
      ),
    );
  }
}
