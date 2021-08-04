import "package:flutter/material.dart";
import 'package:kana_plus_plus/src/presentation/state_management/training_kana_state_management.dart';
import 'package:kana_plus_plus/src/presentation/widgets/kana_viewer.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

class KanaViewers extends StatefulWidget {
  const KanaViewers({
    Key? key,
    required this.stateManagement,
    required this.wordIdxToShow,
  }) : super(key: key);

  final TrainingKanaStateManagement stateManagement;
  final int wordIdxToShow;

  @override
  _KanaViewersState createState() => _KanaViewersState();
}

class _KanaViewersState extends State<KanaViewers> {
  late AutoScrollController _autoScrollController;

  @override
  void initState() {
    super.initState();
    print("initState");
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
    print("_scrollToIndex");
    await _autoScrollController.scrollToIndex(
      widget.stateManagement.kanaIdx,
      preferPosition: AutoScrollPosition.middle,
    );
    _autoScrollController.highlight(widget.stateManagement.kanaIdx);
  }

  @override
  void dispose() {
    print("dispose");
    _autoScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("build");
    return AnimatedBuilder(
      animation: widget.stateManagement,
      builder: (context, child) {
        return ListView.separated(
          scrollDirection: Axis.horizontal,
          controller: _autoScrollController,
          itemCount:
              widget.stateManagement.maxKanasOfWord(widget.wordIdxToShow),
          itemBuilder: (context, index) {
            return AutoScrollTag(
              key: ValueKey(index),
              controller: _autoScrollController,
              index: index,
              child: KanaViewer(
                widget.stateManagement.kanaOfWord(widget.wordIdxToShow, index),
              ),
            );
          },
          separatorBuilder: (context, index) => const SizedBox(width: 5),
        );
      },
    );
  }
}
