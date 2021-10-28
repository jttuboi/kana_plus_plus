import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WordItem extends StatelessWidget {
  const WordItem({
    required this.word,
    required this.imageUrl,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  static const japaneseFontFamily = 'M PLUS Rounded 1c';

  final String word;
  final String imageUrl;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              alignment: Alignment.topCenter,
              child: Hero(
                tag: imageUrl,
                child: SvgPicture.asset(imageUrl),
              ),
            ),
            Container(),
            Container(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
              alignment: Alignment.bottomCenter,
              child: Stack(
                children: [
                  FittedBox(
                    fit: BoxFit.fitWidth,
                    child: Text(
                      word,
                      style: TextStyle(
                        fontFamily: japaneseFontFamily,
                        fontSize: 37,
                        fontWeight: FontWeight.w900,
                        foreground: Paint()
                          ..style = PaintingStyle.stroke
                          ..strokeWidth = 1
                          ..color = Colors.white,
                      ),
                    ),
                  ),
                  FittedBox(
                    fit: BoxFit.fitWidth,
                    child: Text(
                      word,
                      style: const TextStyle(
                        fontFamily: japaneseFontFamily,
                        fontSize: 37,
                        fontWeight: FontWeight.w900,
                        color: Colors.deepPurple,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
