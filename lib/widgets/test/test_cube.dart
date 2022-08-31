import 'package:dezmente/services/models/resultModel.dart';
import 'package:dezmente/services/results.dart';
import 'package:dezmente/common/super.dart';
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
  get description =>
      "Clique na imagem que forma o cubo com uma face pintada de cinza e a oposta de quadriculado, conforme a figura:";

  @override
  get audioFile => "teste-02.mp3";

  @override
  get title => "Test 2: Cubo";

  @override
  get needErase => false;

  const TestCube({Key? key}) : super(key: key);

  @override
  TestCubeState createState() => TestCubeState();
}

enum Boxes { face1, face2, face3, face4, face5, face6 }

class TestCubeState extends SuperTestState {
  @override
  erase() {
    setState(() {
      _boxSelected = null;
    });
  }

  @override
  Result getData() {
    data.score = _boxSelected == Boxes.face2 ? 1 : 0;
    data.testId = 2;
    data.responses = {"face": _boxSelected.toString()};
    return super.getData();
  }

  Boxes? _boxSelected;

  @override
  Widget build(BuildContext context) => Column(
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
              SizedBox(
                width: 160 * MediaQuery.of(context).size.width / 360,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: cubeFaces1.mapIndexed<Widget>((index, face) {
                    return RadioListTile(
                        value: Boxes.values[index],
                        title: Image.asset(face.asset),
                        groupValue: _boxSelected,
                        onChanged: (Boxes? value) {
                          setState(() {
                            _boxSelected = value;
                          });
                        });
                  }).toList(),
                ),
              ),
              SizedBox(
                width: 160 * MediaQuery.of(context).size.width / 360,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: cubeFaces2.mapIndexed<Widget>((index, face) {
                    return RadioListTile(
                        value: Boxes.values[index + cubeFaces1.length],
                        title: Image.asset(face.asset),
                        groupValue: _boxSelected,
                        onChanged: (Boxes? value) {
                          setState(() {
                            _boxSelected = value;
                          });
                        });
                  }).toList(),
                ),
              ),
            ],
          ),
        ],
      );
}
