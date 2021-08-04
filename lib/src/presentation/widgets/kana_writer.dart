import 'dart:math';
import "package:flutter/material.dart";
import 'package:kana_plus_plus/src/domain/entities/writing_hand.dart';
import 'package:kana_plus_plus/src/presentation/state_management/kana_writer.state_management.dart';

class KanaWriter extends StatelessWidget {
  const KanaWriter({
    Key? key,
    required this.stateManagement,
    required this.writingHand,
    required this.showHint,
    required this.onKanaRecovered,
  }) : super(key: key);

  final KanaWriterStateManagement stateManagement;
  final WritingHand writingHand;
  final bool showHint;
  final Function(
          List<Point> pointsFiltered, int kanaIdWrote, Image imageStrokeDrew)
      onKanaRecovered;

  @override
  Widget build(BuildContext context) {
    return writingHand.isRight ? _buildRightHand() : _buildLeftHand();
  }

  Widget _buildRightHand() {
    return Row(
      children: [
        _buildSupportButtons(),
        const SizedBox(width: 4),
        _buildKanaDraw(),
      ],
    );
  }

  Widget _buildLeftHand() {
    return Row(
      children: [
        _buildKanaDraw(),
        const SizedBox(width: 4),
        _buildSupportButtons(),
      ],
    );
  }

  Widget _buildSupportButtons() {
    return Column(
      children: [
        Flexible(
          fit: FlexFit.tight,
          child: AnimatedBuilder(
            animation: stateManagement,
            builder: (context, child) {
              return ElevatedButton(
                onPressed: (stateManagement.isDisabled)
                    ? null
                    : stateManagement.clearStrokes,
                child: ImageIcon(AssetImage(stateManagement.eraserIconUrl)),
              );
            },
          ),
        ),
        const SizedBox(height: 4),
        Flexible(
          fit: FlexFit.tight,
          child: AnimatedBuilder(
            animation: stateManagement,
            builder: (context, child) {
              return ElevatedButton(
                onPressed: (stateManagement.isDisabled)
                    ? null
                    : stateManagement.undoTheLastStroke,
                child: ImageIcon(AssetImage(stateManagement.undoIconUrl)),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildKanaDraw() {
    return Expanded(
      child: AspectRatio(
        aspectRatio: 1.0,
        // TODO aqui só deve atualizar essa caixa, os botoes não podem ser atualizados
        child: AnimatedBuilder(
            animation: stateManagement,
            builder: (context, child) {
              return GestureDetector(
                onTap: (stateManagement.isDisabled)
                    ? null
                    : () {
                        // TODO teste enviando pontos simulando o traço
                        // aqui apenas envia, o tratamento dos traços é feito no controller do training
                        // esse onTap deve ser substituido futuramente por algo que desenhe e crie os pontos
                        final List<Point> points = [
                          const Point(0, 0),
                          const Point(1, 0),
                          const Point(1, 3),
                          const Point(3, 5),
                        ];
                        // precisa devolver qual o numero do stroke, e os pontos filtrados
                        // a imagem é pego daqui mesmo (nao sei como funciona o draw)
                        final Map<String, dynamic> result =
                            stateManagement.processStroke(points);
                        if (result.containsKey("kanaId")) {
                          onKanaRecovered(
                            result["pointsFiltered"] as List<Point<num>>,
                            result["kanaId"] as int,
                            // TODO trocar por uma imagem escrita pelo usuario
                            Image.asset("lib/assets/images/h_a_test.png"),
                          );
                        }
                      },
                // não será um container, pois ainda falta a parte do draw aqui
                child: Container(
                  color: Colors.grey,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        // representa o background com o hiragana/katakana
                        Text(showHint ? "showing hint" : "hided hint"),
                        // representa os strokes, futuramente será umas imagens
                        // com cada stroke
                        Text(
                            "${stateManagement.strokeNumber}/${stateManagement.maxStrokes}"),
                      ],
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }
}
