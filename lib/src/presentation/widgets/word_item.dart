import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WordItem extends StatelessWidget {
  const WordItem({
    Key? key,
    required this.word,
    required this.imageUrl,
    required this.onTap,
  }) : super(key: key);

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
              padding: const EdgeInsets.all(16.0),
              alignment: Alignment.topCenter,
              child: Hero(
                tag: imageUrl,
                child: SvgPicture.asset(imageUrl),
              ),
            ),
            Container(),
            Container(
              padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 24.0),
              alignment: Alignment.bottomCenter,
              child: Stack(
                children: [
                  FittedBox(
                    fit: BoxFit.fitWidth,
                    child: Text(
                      word,
                      style: TextStyle(
                        fontSize: 37,
                        fontWeight: FontWeight.bold,
                        foreground: Paint()
                          ..style = PaintingStyle.stroke
                          ..strokeWidth = 8
                          ..color = Colors.white.withOpacity(0.5),
                      ),
                    ),
                  ),
                  FittedBox(
                    fit: BoxFit.fitWidth,
                    child: Text(
                      word,
                      style: TextStyle(
                        fontSize: 37,
                        fontWeight: FontWeight.bold,
                        foreground: Paint()
                          ..style = PaintingStyle.stroke
                          ..strokeWidth = 4
                          ..color = Colors.deepPurple,
                      ),
                    ),
                  ),
                  FittedBox(
                    fit: BoxFit.fitWidth,
                    child: Text(
                      word,
                      style: TextStyle(
                        fontSize: 37,
                        fontWeight: FontWeight.bold,
                        color: Colors.white.withOpacity(0.8),
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
