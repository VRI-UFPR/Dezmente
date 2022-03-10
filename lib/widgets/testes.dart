import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class Test1 extends StatefulWidget {
  const Test1({Key? key}) : super(key: key);

  @override
  _Test1State createState() => _Test1State();
}

class _Test1State extends State<Test1> {
  final List<String> score = [];

  List<Map> buttons = [
    {"label": "1", "isChecked": false},
    {"label": "2", "isChecked": false},
    {"label": "3", "isChecked": false},
    {"label": "4", "isChecked": false},
    {"label": "a", "isChecked": false},
    {"label": "b", "isChecked": false},
    {"label": "c", "isChecked": false},
    {"label": "d", "isChecked": false},
  ];

  void clearScoreArray() {
    // reseta o array com a ordem dos botoes precionados
    for (var i = 0; i < buttons.length; i++) {
      buttons[i].update("isChecked", (value) => false);
    }
    score.clear();
    print("$score\n$buttons");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        color: Colors.pink,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TextButton.icon(
              onPressed: () {
                setState(() {
                  clearScoreArray();
                });
              },
              icon: const Icon(Icons.undo),
              label: const Text("Apagar"),
            ),
            TextButton.icon(
              onPressed: () {
                setState(() {});
              },
              icon: const Icon(Icons.check),
              label: const Text("Concluir"),
            ),
            TextButton.icon(
              onPressed: () {
                setState(() {});
              },
              icon: const Icon(Icons.info),
              label: const Text("Ajuda"),
            ),
          ],
        ),
      ),
      body: Container(
        margin: const EdgeInsets.only(top: 60.0, left: 10.0, right: 10.0),
        child: StaggeredGrid.count(
            crossAxisCount: 2,
            mainAxisSpacing: 30.0,
            children: buttons.map<Widget>((number) {
              return ElevatedButton(
                child: Text(number['label']),
                style: ElevatedButton.styleFrom(
                  primary: number['isChecked'] ? Colors.blue : Colors.red,
                  shape: const CircleBorder(),
                ),
                onPressed: (() {
                  setState(() {
                    if (number['isChecked'] == false) {
                      number['isChecked'] = true;
                      score.add(number['label']);
                    }
                    print("$score\n$buttons");
                  });
                }),
              );
            }).toList()
            //..shuffle(),
            ),
      ),
    );
  }
}
