import "package:flutter/material.dart";
import 'package:kana_plus_plus/src/domain/entities/word.entity.dart';

class WordDetailPage extends StatelessWidget {
  const WordDetailPage({Key? key, required this.word}) : super(key: key);

  final Word word;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context);
        return false;
      },
      child: Scaffold(
        // TODO precisa tirar esse bar. Ele precisa ser substituido por algo
        // que faça o item continuar na mesma posicao quando usa o bar,
        // e não deve ficar grudado no topo da tela como fica quando tira o bar.
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: Container(),
        ),
        body: InkWell(
          onTap: () => Navigator.pop(context),
          child: Column(
            children: [
              const Spacer(),
              Flexible(
                flex: 11,
                child: Hero(
                  tag: word.imageUrl,
                  child: Image.asset(word.imageUrl),
                ),
              ),
              const Spacer(),
              Flexible(
                flex: 3,
                fit: FlexFit.tight,
                child: Center(child: Text(word.word)),
              ),
              Flexible(
                flex: 3,
                fit: FlexFit.tight,
                child: Center(child: Text(word.romaji)),
              ),
              Flexible(
                flex: 3,
                fit: FlexFit.tight,
                child: Center(child: Text(word.translate.translate)),
              ),
              Flexible(
                flex: 3,
                fit: FlexFit.tight,
                child: Center(child: Text(word.kanas[0].kana)),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
