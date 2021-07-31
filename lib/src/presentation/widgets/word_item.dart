import 'dart:ui';

import "package:flutter/material.dart";

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
                child: Image.asset(imageUrl),
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
                          ..strokeWidth = 10
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
                            ..strokeWidth = 7
                            ..color = Colors.grey[200]! //.withOpacity(0.8),
                          ),
                    ),
                  ),
                  FittedBox(
                    fit: BoxFit.fitWidth,
                    child: Text(
                      word,
                      style: const TextStyle(
                        fontSize: 37,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
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
