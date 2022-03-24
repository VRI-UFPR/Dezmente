import 'package:flutter/material.dart';
import 'package:widget_arrows/widget_arrows.dart';

class Test1 extends StatefulWidget {
  const Test1({Key? key}) : super(key: key);

  @override
  _Test1State createState() => _Test1State();
}

class _Test1State extends State<Test1> {
  final List<String> score = [];

  List<Map<String, dynamic>> buttons = [
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

  void clearScoreArray() {
    // reseta o array com a ordem dos botoes precionados
    for (var i = 0; i < buttons.length; i++) {
      buttons[i].update("isChecked", (value) => false);
      buttons[i].update("targetArrow", (value) => buttons[i]["label"]);
      buttons[i].update("showArrow", (value) => false);
    }
    score.clear();
  }

  int mapIndex = 0;

  @override
  Widget build(BuildContext context) => Scaffold(
        bottomNavigationBar: BottomAppBar(
          color: const Color(0xffe984b8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton.icon(
                onPressed: () {
                  setState(() {
                    clearScoreArray();
                  });
                },
                icon: const Icon(Icons.undo, color: Color(0xff060607)),
                label: const Text("Apagar",
                    style: TextStyle(color: Color(0xff060607))),
              ),
              TextButton.icon(
                onPressed: () {
                  setState(() {});
                },
                icon: const Icon(Icons.check, color: Color(0xff060607)),
                label: const Text("Concluir",
                    style: TextStyle(color: Color(0xff060607))),
              ),
              TextButton.icon(
                onPressed: () {
                  setState(() {});
                },
                icon: const Icon(Icons.info, color: Color(0xff060607)),
                label: const Text("Ajuda",
                    style: TextStyle(color: Color(0xff060607))),
              ),
            ],
          ),
        ),
        body: ArrowContainer(
          child: Stack(
              children: buttons.map<Widget>((button) {
            return Positioned(
              top: button['y'] * MediaQuery.of(context).size.height / 590,
              left: button['x'] * MediaQuery.of(context).size.width / 330,
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
                    primary: button['isChecked'] ? Colors.blue : Colors.red,
                    shape: const CircleBorder(),
                    minimumSize: const Size(50, 50),
                  ),
                  onPressed: (() {
                    setState(() {
                      if (button['isChecked'] == false) {
                        button['isChecked'] = true;
                        score.add(button['label']);
                      }
                      if (score.length > 1) {
                        buttons[mapIndex]
                            .update("targetArrow", (value) => button['label']);
                        buttons[mapIndex].update("showArrow", (value) => true);
                      }
                      mapIndex = buttons.indexOf(button);
                      print("$score\n");
                      print("$buttons\n");
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
