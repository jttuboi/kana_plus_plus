import "package:flutter/material.dart";
import 'package:kana_plus_plus/src/shared/images.dart';
import 'package:kana_plus_plus/src/training/kana_viewer.dart';
import 'package:kana_plus_plus/src/training/kana_viewer_status.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

class KanaViewers extends StatefulWidget {
  const KanaViewers({
    Key? key,
    required this.currentSyllabe,
  }) : super(key: key);

  final int currentSyllabe;

  @override
  _KanaViewersState createState() => _KanaViewersState();
}

class _KanaViewersState extends State<KanaViewers> {
  late AutoScrollController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AutoScrollController(
        viewportBoundaryGetter: () =>
            Rect.fromLTRB(0, 0, 0, MediaQuery.of(context).padding.bottom),
        axis: Axis.horizontal);
  }

  @override
  void didUpdateWidget(covariant KanaViewers oldWidget) {
    super.didUpdateWidget(oldWidget);
    _scrollToIndex();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future _scrollToIndex() async {
    await _controller.scrollToIndex(widget.currentSyllabe,
        preferPosition: AutoScrollPosition.middle);
    _controller.highlight(widget.currentSyllabe);
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      controller: _controller,
      itemCount: 10,
      itemBuilder: (context, index) {
        /////// TEST
        KanaViewerStatus status = KanaViewerStatus.showInitial;
        if (index == widget.currentSyllabe) {
          status = KanaViewerStatus.showSelected;
        } else if (index < widget.currentSyllabe) {
          status = KanaViewerStatus.showCorrect;
        }

        ///
        return _wrapScrollTag(
          index: index,
          child: KanaViewer(
            status: status,
            romaji: JImages.rA,
            kana: JImages.hA,
            userKana: JImages.hATest,
          ),
        );
      },
      separatorBuilder: (context, index) => const SizedBox(width: 5),
    );
  }

  Widget _wrapScrollTag({required int index, required Widget child}) {
    return AutoScrollTag(
      key: ValueKey(index),
      controller: _controller,
      index: index,
      highlightColor: Colors.black.withOpacity(0.1),
      child: child,
    );
  }

  // return ListView.separated(
  //   scrollDirection: Axis.horizontal,
  //   itemCount: 10,
  //   itemBuilder: (context, index) {
  //     return KanaViewer(
  //       status: KanaViewerStatus.showCorrect,
  //       romaji: JImages.rA,
  //       kana: JImages.hA,
  //       userKana: JImages.hATest,
  //     );
  //   },
  //   separatorBuilder: (context, index) => const SizedBox(width: 5),
  // );

}
