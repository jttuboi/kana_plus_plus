import 'package:flutter/material.dart';

class SubHeaderTile extends StatelessWidget {
  const SubHeaderTile(
    this.title, {
    Key? key,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48.0,
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Text(title, style: Theme.of(context).textTheme.subtitle2),
    );
  }
}
