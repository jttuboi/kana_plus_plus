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
              padding: const EdgeInsets.all(8.0),
              alignment: Alignment.topCenter,
              child: Hero(
                tag: imageUrl,
                child: Image.asset(imageUrl),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16.0),
              alignment: Alignment.bottomCenter,
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
    );
  }
}
