import "package:flutter/material.dart";

enum Status {
  selected,
  unselected,
}

class KanaViewerWidget extends StatefulWidget {
  @override
  _KanaViewerWidgetState createState() => _KanaViewerWidgetState();
}

class _KanaViewerWidgetState extends State<KanaViewerWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160.0,
      color: Colors.red,
    );
  }
}
