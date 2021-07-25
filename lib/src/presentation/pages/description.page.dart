import 'package:flutter/material.dart';
import 'package:kana_plus_plus/src/presentation/viewmodels/description.viewmodel.dart';

class DescriptionPage extends StatelessWidget {
  const DescriptionPage({
    Key? key,
    required this.title,
    required this.descriptions,
  }) : super(key: key);

  final String title;
  final List<DescriptionViewModel> descriptions;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: _buildDescriptions(),
        ),
      ),
    );
  }

  List<Widget> _buildDescriptions() {
    return descriptions.map((DescriptionViewModel description) {
      if (description.isTitle()) {
        return _DescriptionTitle(description.text);
      } else if (description.isContent()) {
        return _DescriptionContent(description.text);
      }
      return Container();
    }).toList();
  }
}

class _DescriptionTitle extends StatelessWidget {
  const _DescriptionTitle(this.text, {Key? key}) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        text,
        style: const TextStyle(fontWeight: FontWeight.w700),
      ),
    );
  }
}

class _DescriptionContent extends StatelessWidget {
  const _DescriptionContent(this.text, {Key? key}) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(text);
  }
}
