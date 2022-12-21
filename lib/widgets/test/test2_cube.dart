import 'package:dezmente/services/models/result_model.dart';
import 'package:dezmente/common/super.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:flutter_svg/flutter_svg.dart';

class _Cubes {
  _Cubes(this.asset, this.correct);

  String asset = "";
  bool correct = false;
}

List<_Cubes> cubeFaces1 = [
  _Cubes("assets/images/cube_new/face1.svg", false),
  _Cubes("assets/images/cube_new/face2.svg", true),
  _Cubes("assets/images/cube_new/face3.svg", false)
];

List<_Cubes> cubeFaces2 = [
  _Cubes("assets/images/cube_new/face4.svg", false),
  _Cubes("assets/images/cube_new/face5.svg", false),
  _Cubes("assets/images/cube_new/face6.svg", false)
];

int pressedErase = 0; // quantidade de vezes que o botao apagar foi utilizado
int timeSpended = DateTime.now().millisecondsSinceEpoch;

class TestCube extends SuperTest {
  @override
  get description =>
      "Clique na imagem que forma o cubo com uma face pintada de azul e a oposta de quadriculado em laranja, conforme a figura:";

  @override
  get audioFile => "teste-02.mp3";

  @override
  get title => "Teste 2: Cubo";

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
            child: Container(
              margin: EdgeInsets.only(top: 0),
              child: SizedBox(
                width: 190,
                child: Image.asset(
                  "assets/images/cube_new/cube.png",
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 165 * MediaQuery.of(context).size.width / 360,
                height: 380 * MediaQuery.of(context).size.height / 640,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: cubeFaces1.mapIndexed<Widget>((index, face) {
                    return RadioListTile(
                        value: Boxes.values[index],
                        title: SvgPicture.asset(
                          face.asset,
                          fit: BoxFit.contain,
                          height: 125,
                        ),
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
                width: 165 * MediaQuery.of(context).size.width / 360,
                height: 380 * MediaQuery.of(context).size.height / 640,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: cubeFaces2.mapIndexed<Widget>((index, face) {
                    return RadioListTile(
                        value: Boxes.values[index + cubeFaces1.length],
                        title: SvgPicture.asset(
                          face.asset,
                          fit: BoxFit.fitWidth,
                          height: 125,
                        ),
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
