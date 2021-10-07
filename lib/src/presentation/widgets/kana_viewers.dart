import 'package:flutter/material.dart';
import 'package:kwriting/src/domain/controllers/training.controller.dart';
import 'package:kwriting/src/presentation/state_management/training_kana.provider.dart';
import 'package:kwriting/src/presentation/widgets/kana_viewer.dart';
import 'package:provider/provider.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

class KanaViewers extends StatefulWidget {
  const KanaViewers({
    Key? key,
    required this.width,
    required this.height,
    required this.trainingController,
    required this.wordIdxToShow,
  }) : super(key: key);

  final double width;
  final double height;
  final TrainingController trainingController;
  final int wordIdxToShow;

  @override
  _KanaViewersState createState() => _KanaViewersState();
}

class _KanaViewersState extends State<KanaViewers> {
  late AutoScrollController _autoScrollController;

  @override
  void initState() {
    super.initState();
    _autoScrollController = AutoScrollController(
      viewportBoundaryGetter: () {
        return Rect.fromLTRB(0, 0, 0, MediaQuery.of(context).padding.bottom);
      },
      axis: Axis.horizontal,
    );
  }

  @override
  void didUpdateWidget(covariant KanaViewers oldWidget) {
    super.didUpdateWidget(oldWidget);
    _scrollToIndex();
  }

  Future _scrollToIndex() async {
    await _autoScrollController.scrollToIndex(
      widget.trainingController.kanaIdx,
      preferPosition: AutoScrollPosition.middle,
    );
    _autoScrollController.highlight(widget.trainingController.kanaIdx);
  }

  @override
  void dispose() {
    _autoScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: Consumer<TrainingKanaProvider>(
        builder: (context, value, child) {
          return ListView.separated(
            scrollDirection: Axis.horizontal,
            controller: _autoScrollController,
            itemCount: widget.trainingController.maxKanasOfWord(widget.wordIdxToShow),
            itemBuilder: (context, index) {
              return AutoScrollTag(
                key: ValueKey(index),
                controller: _autoScrollController,
                index: index,
                child: KanaViewer(widget.trainingController.kanaOfWord(widget.wordIdxToShow, index), size: widget.height),
              );
            },
            separatorBuilder: (context, index) => const SizedBox(width: 5),
          );
        },
      ),
    );
  }
}
