import 'package:flutter/material.dart';

enum WritingHand {
  left,
  right,
}

class KanaWriterWidget extends StatefulWidget {
  //const KanaWriterWidget({ Key? key }) : super(key: key);
  KanaWriterWidget({required this.writingHand});

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
        SizedBox(width: 4),
        _buildKanaDraw(),
      ],
    );
  }

  Widget _buildLeftHand() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildKanaDraw(),
        SizedBox(width: 4),
        _buildSupportButtons(),
      ],
    );
  }

  Widget _buildSupportButtons() {
    return Column(
      children: [
        Container(
          constraints: BoxConstraints.expand(width: 100, height: 158),
          child: ElevatedButton(
            style: ButtonStyle(alignment: Alignment.center),
            child: Icon(Icons.delete),
            onPressed: () {},
          ),
        ),
        SizedBox(height: 4),
        Container(
          constraints: BoxConstraints.expand(width: 100, height: 158),
          child: ElevatedButton(
            style: ButtonStyle(alignment: Alignment.center),
            child: Icon(Icons.undo),
            onPressed: () {},
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
