import 'package:dezmente/pages/teste.dart';
import 'package:dezmente/super/superTest.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';

class _Cubes {
  _Cubes(this.asset, this.correct);

  String asset = "";
  bool correct = false;
}

List<_Cubes> cubeFaces1 = [
  _Cubes("assets/images/cube/face1.png", false),
  _Cubes("assets/images/cube/face2.png", true),
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

enum Boxes { face1, face2, face3, face4, face5, face6 }

class TestCubeState extends SuperTestState {
  @override
  erase() {
    setState(() {
      _boxes = null;
    });
  }

  Boxes? _boxes;

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
                      children: cubeFaces1.mapIndexed<Widget>((index, face) {
                        return RadioListTile(
                            value: Boxes.values[index],
                            secondary: Image.asset(face.asset),
                            groupValue: _boxes,
                            onChanged: (Boxes? value) {
                              setState(() {
                                _boxes = value;
                              });
                            });
                      }).toList(),
                    ),
                  ),
                  IntrinsicWidth(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: cubeFaces2.mapIndexed<Widget>((index, face) {
                        return RadioListTile(
                            value: Boxes.values[index + cubeFaces1.length],
                            secondary: Image.asset(face.asset),
                            groupValue: _boxes,
                            onChanged: (Boxes? value) {
                              setState(() {
                                _boxes = value;
                              });
                            });
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
