import 'package:flutter/material.dart';

class QuantityOfCardsTile extends StatefulWidget {
  const QuantityOfCardsTile(
    this.initialQuantityOfCards, {
    Key? key,
    required this.onQuantityChanged,
  }) : super(key: key);

  final int initialQuantityOfCards;
  final Function(int) onQuantityChanged;

  @override
  _QuantityOfCardsTileState createState() => _QuantityOfCardsTileState();
}

class _QuantityOfCardsTileState extends State<QuantityOfCardsTile> {
  final double _step = 1;
  final double _min = 5;
  final double _max = 20;

  int _quantityOfCards = 5;

  @override
  void initState() {
    _quantityOfCards = widget.initialQuantityOfCards;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.recent_actors), // AQUI icon
      title: const Text("Quantity of cards"), // AQUI localization
      subtitle: SliderTheme(
        data: SliderTheme.of(context).copyWith(
          trackShape: _CustomTrackShape(),
        ),
        child: Slider(
          value: _quantityOfCards.toDouble(),
          onChanged: (value) => setState(() {
            _quantityOfCards = value.toInt();
            widget.onQuantityChanged(_quantityOfCards);
          }),
          divisions: (_max - _min) ~/ _step,
          label: _quantityOfCards.toString(),
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
