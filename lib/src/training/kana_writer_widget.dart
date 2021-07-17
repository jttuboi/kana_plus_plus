import "package:flutter/material.dart";
import 'package:kana_plus_plus/src/shared/icons.dart';

enum WritingHand {
  left,
  right,
}

class KanaWriterWidget extends StatefulWidget {
  //const KanaWriterWidget({ Key? key }) : super(key: key);
  const KanaWriterWidget({required this.writingHand});

  final WritingHand writingHand;

  @override
  _KanaWriterWidgetState createState() => _KanaWriterWidgetState();
}

class _KanaWriterWidgetState extends State<KanaWriterWidget> {
  @override
  Widget build(BuildContext context) {
    return widget.writingHand == WritingHand.right
        ? _buildRightHand()
        : _buildLeftHand();
  }

  Widget _buildRightHand() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildSupportButtons(),
        const SizedBox(width: 4),
        _buildKanaDraw(),
      ],
    );
  }

  Widget _buildLeftHand() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
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
        Container(
          constraints: const BoxConstraints.expand(width: 100, height: 158),
          child: ElevatedButton(
            style: const ButtonStyle(alignment: Alignment.center),
            onPressed: () {},
            child: KIcons.eraser,
          ),
        ),
        const SizedBox(height: 4),
        Container(
          constraints: const BoxConstraints.expand(width: 100, height: 158),
          child: ElevatedButton(
            style: const ButtonStyle(alignment: Alignment.center),
            onPressed: () {},
            child: KIcons.undo,
          ),
        ),
      ],
    );
  }

  Widget _buildKanaDraw() {
    return Container(
      color: Colors.grey,
      height: 320,
      width: 320,
    );
  }
}
