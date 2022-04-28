import 'package:dezmente/super/superTest.dart';
import 'package:flutter/material.dart';

class _Cubes {
  _Cubes(this.asset, this.checked);

  String asset = "";
  bool checked = false;
}

List<_Cubes> cubeFaces1 = [
  _Cubes("assets/images/cube/face1.png", false),
  _Cubes("assets/images/cube/face2.png", false),
  _Cubes("assets/images/cube/face3.png", false)
];

List<_Cubes> cubeFaces2 = [
  _Cubes("assets/images/cube/face4.png", false),
  _Cubes("assets/images/cube/face5.png", false),
  _Cubes("assets/images/cube/face6.png", false)
];

int pressedErase = 0; // quantidade de vezes que o botao apagar foi utilizado
int timeSpended = DateTime.now().millisecondsSinceEpoch;

class TestCube extends SuperTest {
  @override
  final description =
      "Clique na imagem que forma o cubo com uma face pintada de cinza e a oposta de quadriculado, conforme a figura:";

  const TestCube({Key? key}) : super(key: key);

  @override
  TestCubeState createState() => TestCubeState();
}

//State<TestCube> with Super
class TestCubeState extends SuperTestState {
  @override
  erase() {
    setState(() {
      for (_Cubes item in cubeFaces1) {
        item.checked = false;
      }
      for (_Cubes item in cubeFaces2) {
        item.checked = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Container(
          margin: const EdgeInsets.fromLTRB(5, 30, 5, 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Center(
                child: Image.asset(
                  'assets/images/cube/cube.png',
                  scale: 2,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IntrinsicWidth(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: cubeFaces1.map<Widget>((face) {
                        return CheckboxListTile(
                          value: face.checked,
                          onChanged: (value) {
                            setState(() {
                              if (!face.checked) {
                                erase();
                                face.checked = true;
                              } else {
                                face.checked = false;
                              }
                            });
                          },
                          contentPadding: EdgeInsets.zero,
                          secondary: Image.asset(face.asset),
                          controlAffinity: ListTileControlAffinity.trailing,
                        );
                      }).toList(),
                    ),
                  ),
                  IntrinsicWidth(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: cubeFaces2.map<Widget>((face) {
                        return CheckboxListTile(
                          value: face.checked,
                          onChanged: (value) {
                            setState(() {
                              if (!face.checked) {
                                erase();
                                face.checked = true;
                              } else {
                                face.checked = false;
                              }
                            });
                          },
                          contentPadding: EdgeInsets.zero,
                          secondary: Image.asset(face.asset),
                          controlAffinity: ListTileControlAffinity.trailing,
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
}
