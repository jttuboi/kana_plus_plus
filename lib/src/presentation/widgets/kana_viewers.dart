import "package:flutter/material.dart";
import 'package:kana_plus_plus/src/presentation/arguments/kana_viewer_content.dart';
import 'package:kana_plus_plus/src/presentation/widgets/kana_viewer.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

class KanaViewers extends StatefulWidget {
  const KanaViewers({
    Key? key,
    required this.kanaViewerContents,
    required this.currentKanaIdx,
  }) : super(key: key);

  final List<KanaViewerContent> kanaViewerContents;
  final int currentKanaIdx;

  @override
  _KanaViewersState createState() => _KanaViewersState();
}

class _KanaViewersState extends State<KanaViewers> {
  late AutoScrollController _controller;

  @override
  void initState() {
    super.initState();
    _initController();
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

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      controller: _controller,
      itemCount: widget.kanaViewerContents.length,
      itemBuilder: (context, index) {
        return _wrapScrollTag(
          index: index,
          child: KanaViewer(widget.kanaViewerContents[index]),
        );
      },
      separatorBuilder: (context, index) => const SizedBox(width: 5),
    );
  }

  void _initController() {
    _controller = AutoScrollController(
        viewportBoundaryGetter: () =>
            Rect.fromLTRB(0, 0, 0, MediaQuery.of(context).padding.bottom),
        axis: Axis.horizontal);
  }

  Future _scrollToIndex() async {
    await _controller.scrollToIndex(widget.currentKanaIdx,
        preferPosition: AutoScrollPosition.middle);
    _controller.highlight(widget.currentKanaIdx);
  }

  Widget _wrapScrollTag({required int index, required Widget child}) {
    return AutoScrollTag(
      key: ValueKey(index),
      controller: _controller,
      index: index,
      child: child,
    );
  }
}
