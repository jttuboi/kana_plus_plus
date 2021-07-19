import 'package:flutter/material.dart';
import 'package:kana_plus_plus/src/shared/icons.dart';

class QuantityOfWordsTile extends StatefulWidget {
  const QuantityOfWordsTile(
    this.initialQuantityOfWords, {
    Key? key,
    required this.onQuantityChanged,
  }) : super(key: key);

  final int initialQuantityOfWords;
  final Function(int) onQuantityChanged;

  @override
  _QuantityOfWordsTileState createState() => _QuantityOfWordsTileState();
}

class _QuantityOfWordsTileState extends State<QuantityOfWordsTile> {
  final double _step = 1;
  final double _min = 5;
  final double _max = 20;

  int _quantityOfWords = 5;

  @override
  void initState() {
    _quantityOfWords = widget.initialQuantityOfWords;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: JIcons.quantityOfWords,
      title: const Text("Quantity of words"), // AQUI localization
      subtitle: SliderTheme(
        data: SliderTheme.of(context).copyWith(
          trackShape: _CustomTrackShape(),
        ),
        child: Slider(
          value: _quantityOfWords.toDouble(),
          onChanged: (value) => setState(() {
            _quantityOfWords = value.toInt();
            widget.onQuantityChanged(_quantityOfWords);
          }),
          divisions: (_max - _min) ~/ _step,
          label: _quantityOfWords.toString(),
          min: _min,
          max: _max,
        ),
      ),
    );
  }
}

class _CustomTrackShape extends RoundedRectSliderTrackShape {
  @override
  Rect getPreferredRect({
    required RenderBox parentBox,
    Offset offset = Offset.zero,
    required SliderThemeData sliderTheme,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    final double trackHeight = sliderTheme.trackHeight!;
    final double trackLeft = offset.dx + 6;
    final double trackTop =
        offset.dy + (parentBox.size.height - trackHeight) / 2;
    final double trackWidth = parentBox.size.width - 22;
    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
  }
}
