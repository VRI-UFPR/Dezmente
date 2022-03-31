import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:widget_arrows/widget_arrows.dart';

class Test1 extends StatefulWidget {
  const Test1({Key? key}) : super(key: key);

  @override
  _Test1State createState() => _Test1State();
}

class _Test1State extends State<Test1> {
  // ordem dos botoes pressionados pelo usuario
  final List<String> score = [];

  // lista de botoes utilizados no teste
  List<Map<String, dynamic>> buttons = [
    // nome
    // se foi pressionado
    // destino da seta
    // se deve mostrar a seta
    // posicao em relacao ao eixo x
    // posicao em relacao ao eixo y
    {
      "label": "1",
      "isChecked": false,
      "targetArrow": "A",
      "showArrow": false,
      "x": 96,
      "y": 230
    },
    {
      "label": "A",
      "isChecked": false,
      "targetArrow": "2",
      "showArrow": false,
      "x": 212,
      "y": 102
    },
    {
      "label": "2",
      "isChecked": false,
      "targetArrow": "B",
      "showArrow": false,
      "x": 270,
      "y": 180
    },
    {
      "label": "B",
      "isChecked": false,
      "targetArrow": "3",
      "showArrow": false,
      "x": 200,
      "y": 240
    },
    {
      "label": "3",
      "isChecked": false,
      "targetArrow": "C",
      "showArrow": false,
      "x": 270,
      "y": 350
    },
    {
      "label": "C",
      "isChecked": false,
      "targetArrow": "4",
      "showArrow": false,
      "x": 44,
      "y": 432
    },
    {
      "label": "4",
      "isChecked": false,
      "targetArrow": "D",
      "showArrow": false,
      "x": 154,
      "y": 356
    },
    {
      "label": "D",
      "isChecked": false,
      "targetArrow": "A",
      "showArrow": false,
      "x": 30,
      "y": 340
    },
    {
      "label": "5",
      "isChecked": false,
      "targetArrow": "E",
      "showArrow": false,
      "x": 17,
      "y": 190
    },
    {
      "label": "E",
      "isChecked": false,
      "targetArrow": "E",
      "showArrow": false,
      "x": 104,
      "y": 92
    },
  ];

  int mapIndex = 0; // index na lista do ultimo botao pressionado
  bool canErase = false; // se pode utilizar o apagar
  int pressedErase = 0; // quantidade de vezes que o botao apagar foi utilizado
  int timeSpended = DateTime.now().millisecondsSinceEpoch; // tempo total gasto

  void eraseLastPressed() {
    // apaga o ultimo botao pressionado
    int last = score.length - 1;

    // index do ultimo botao pressionado na lista
    int ib = buttons.indexWhere((element) => element["label"] == score[last]);
    buttons[ib].update("isChecked", (value) => false);

    if (last > 0) {
      // remove a flecha do botao anterior caso esse exista
      ib = buttons.indexWhere((element) => element["label"] == score[last - 1]);
      buttons[ib].update("showArrow", (value) => false);
      mapIndex = ib;
    }

    score.removeAt(last);
    canErase = false;
    pressedErase++;
  }

  @override
  Widget build(BuildContext context) {
    // fatores para posicao e tamanho dos widgets em relacao a tela
    final double screenHeightFactor = MediaQuery.of(context).size.height / 640;
    final double screenWidthFactor = MediaQuery.of(context).size.width / 360;

    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        color: const Color(0xffe984b8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TextButton.icon(
              onPressed: () {
                setState(() {
                  if (canErase) eraseLastPressed();
                });
              },
              icon: const Icon(Icons.undo, color: Color(0xff060607)),
              label: const Text(
                "Apagar",
                style: TextStyle(color: Color(0xff060607)),
              ),
              // style: TextButton.styleFrom(
              //   side: const BorderSide(
              //     color: Colors.black,
              //     width: 1.0,
              //     style: BorderStyle.solid,
              //   ),
              //   elevation: 0.5,
              // ),
            ),
            TextButton.icon(
              onPressed: () {
                setState(() {
                  timeSpended =
                      DateTime.now().millisecondsSinceEpoch - timeSpended;
                  print(timeSpended);
                  print(pressedErase);
                });
              },
              icon: const Icon(Icons.check, color: Color(0xff060607)),
              label: const Text(
                "Concluir",
                style: TextStyle(color: Color(0xff060607)),
              ),
            ),
            TextButton.icon(
              onPressed: () {
                setState(() {});
              },
              icon: const Icon(Icons.info, color: Color(0xff060607)),
              label: const Text(
                "Ajuda",
                style: TextStyle(color: Color(0xff060607)),
              ),
            ),
          ],
        ),
      ),
      body: ArrowContainer(
        child: Stack(
            children: buttons.map<Widget>((button) {
          return Positioned(
            top: button['y'] * screenHeightFactor,
            left: button['x'] * screenWidthFactor,
            child: ArrowElement(
              show: button["showArrow"],
              sourceAnchor: Alignment.center,
              targetAnchor: Alignment.center,
              bow: -0.3,
              straights: true,
              id: button['label'],
              targetId: button['targetArrow'],
              color: const Color(0xff1d181c),
              child: ElevatedButton(
                child: Text(
                  button['label'],
                  style: const TextStyle(fontSize: 25),
                ),
                style: ElevatedButton.styleFrom(
                  // nao pressionado cor vermelha, pressionado cor azul
                  primary: button['isChecked'] ? Colors.blue : Colors.red,
                  shape: const CircleBorder(),
                  minimumSize: const Size(50, 50),
                ),
                onPressed: (() {
                  setState(() {
                    if (button['isChecked'] == false) {
                      // caso o botao ainda n tenha sido pressionado
                      button['isChecked'] = true;
                      score.add(button['label']);
                      canErase = true;
                    }
                    if (score.length > 1) {
                      // desenha as flechas apenas se tiver mais de um botao pressionado
                      buttons[mapIndex]
                          .update("targetArrow", (value) => button['label']);
                      buttons[mapIndex].update("showArrow", (value) => true);
                    }
                    // ultimo botao pressionado
                    mapIndex = buttons.indexOf(button);

                    // para testes
                    print("$score\n");
                    print("$buttons\n");
                    print(buttons[mapIndex]);
                  });
                }),
              ),
            ),
          );
        }).toList()
            //..shuffle(),
            ),
      ),
    );
  }
}
