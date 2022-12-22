import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dezmente/common/super.dart';
import 'package:dezmente/services/models/result_model.dart';
import 'package:flutter/material.dart';
import 'package:widget_arrows/widget_arrows.dart';

// nome
// se foi pressionado
// destino da seta
// se deve mostrar a seta
// posicao em relacao ao eixo x
// posicao em relacao ao eixo y
class _ConectButtons {
  _ConectButtons(this.label, this.isChecked, this.targetArrow, this.showArrow,
      this.x, this.y);
  double x, y;
  bool isChecked, showArrow;
  String targetArrow, label;
}

class TestConection extends SuperTest {
  @override
  get description =>
      "Clique alternando entre número e letra, respeitando a ordem dos números e do alfabeto. Ex: 1->A->2";

  @override
  get title => "Teste 1: Conexão";

  @override
  get audioFile => "teste-01.mp3";

  const TestConection({Key? key}) : super(key: key);

  @override
  TestConectionState createState() => TestConectionState();
}

class TestConectionState extends SuperTestState {
// lista de botoes utilizados no teste
  final List<_ConectButtons> _buttons = [
    _ConectButtons("1", true, "A", true, 96, 230),
    _ConectButtons("A", true, "2", true, 212, 102),
    _ConectButtons("2", true, "B", false, 270, 180),
    _ConectButtons("B", false, "3", false, 200, 240),
    _ConectButtons("3", false, "C", false, 270, 350),
    _ConectButtons("C", false, "4", false, 44, 432),
    _ConectButtons("4", false, "D", false, 154, 356),
    _ConectButtons("D", false, "A", false, 30, 340),
    _ConectButtons("5", false, "E", false, 17, 190),
    _ConectButtons("E", false, "E", false, 104, 92),
  ];

  // ordem dos botoes pressionados pelo usuario
  final List<String> _score = ["1", "A", "2"];

  int _mapIndex = 2; // index na lista do ultimo botao pressionado
  bool _canErase = false; // se pode utilizar o apagar
  //int pressedErase = 0; // quantidade de vezes que o botao apagar foi utilizado
  //int timeSpended = DateTime.now().millisecondsSinceEpoch; // tempo total gasto

  @override
  Result getData() {
    data.testId = 1;
    data.score = const ListEquality()
            .equals(_score, ["1", "A", "2", "B", "3", "C", "4", "D", "5", "E"])
        ? 1
        : 0;
    data.responses = {"sequence": _score.toString()};
    data.testType = TestTag.vse;

    return super.getData();
  }

  @override
  void erase() {
    setState(() {
      // caso ja tenha apagado uma vez
      if (!_canErase) {
        return;
      }

      // apaga o ultimo botao pressionado
      int last = _score.length - 1;

      // index do ultimo botao pressionado na lista
      if (last > -1) {
        int ib =
            _buttons.indexWhere((element) => element.label == _score[last]);
        _buttons[ib].isChecked = false;
        _score.removeAt(last);

        if (last > 0) {
          // remove a flecha do botao anterior caso esse exista
          ib = _buttons
              .indexWhere((element) => element.label == _score[last - 1]);
          _buttons[ib].showArrow = false;
          _mapIndex = ib;
          _canErase = false;
          //pressedErase++;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // fatores para posicao e tamanho dos widgets em relacao a tela
    final double screenHeightFactor = MediaQuery.of(context).size.height / 640;
    final double screenWidthFactor = MediaQuery.of(context).size.width / 360;

    return ArrowContainer(
      child: Stack(
        children: _buttons.map<Widget>((button) {
          return Positioned(
            top: button.y * screenHeightFactor,
            left: button.x * screenWidthFactor,
            child: ArrowElement(
              show: button.showArrow,
              targetAnchor: entrada(button),
              sourceAnchor: saida(button),
              bow: -0.4,
              straights: true,
              id: button.label,
              targetId: button.targetArrow,
              color: const Color(0xff1d181c),
              child: ElevatedButton(
                child: Text(
                  button.label,
                  style: const TextStyle(fontSize: 25),
                ),
                style: ElevatedButton.styleFrom(
                  // nao pressionado cor vermelha, pressionado cor azul
                  primary: button.isChecked ? Colors.blue : Colors.red,
                  shape: const CircleBorder(),
                  minimumSize: const Size(50, 50),
                ),
                onPressed: (() {
                  setState(() {
                    if (_score.length < 10) {
                      if (button.isChecked == false) {
                        // caso o botao ainda n tenha sido pressionado
                        button.isChecked = true;
                        _score.add(button.label);
                        _canErase = true;
                      }
                      if (_score.length > 1) {
                        // desenha as flechas apenas se tiver mais de um botao pressionado
                        _buttons[_mapIndex].targetArrow = button.label;
                        _buttons[_mapIndex].showArrow = true;
                      }
                      // ultimo botao pressionado
                      _mapIndex = _buttons.indexOf(button);
                    }
                  });
                }),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Alignment saida(_ConectButtons button) {
    double xa = button.x;
    double xb = _buttons.where((e) => e.label == button.targetArrow).last.x;
    double ya = button.y;
    double yb = _buttons.where((e) => e.label == button.targetArrow).last.y;

    double ham = atan((xb - xa) / (ya - yb));

    double sen = 0;
    double co = 0;

    xb > xa ? sen = 1 : sen = -1;
    yb > ya ? co = 1 : co = -1;

    return Alignment(sin(ham).abs() * sen, cos(ham).abs() * co);
  }

  Alignment entrada(_ConectButtons button) {
    double xa = _buttons.where((e) => e.label == button.targetArrow).last.x;
    double xb = button.x;
    double ya = _buttons.where((e) => e.label == button.targetArrow).last.y;
    double yb = button.y;

    double ham = atan((xb - xa) / (ya - yb));

    double sen = 0;
    double co = 0;

    xb > xa ? sen = 1 : sen = -1;
    yb > ya ? co = 1 : co = -1;

    return Alignment(sin(ham).abs() * sen, cos(ham).abs() * co);
  }
}
