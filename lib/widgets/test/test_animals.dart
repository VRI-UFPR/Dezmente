import 'package:dezmente/pages/teste.dart';
import 'package:dezmente/super/supertest.dart';
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

class TestAnimals extends SuperTest {
  @override
  final description =
      "Digite o nome dos animais que aparecem na tela";

  const TestAnimals({Key? key}) : super(key: key);

  @override
  TestAnimalsState createState() => TestAnimalsState();
}

enum Boxes { face1, face2, face3, face4, face5, face6 }

class TestAnimalsState extends SuperTestState {
  @override
  erase() {
    setState(() {
      _boxes = null;
    });
  }

  Boxes? _boxes;

  int pressedErase = 0; // quantidade de vezes que o botao apagar foi utilizado
  int timeSpended = DateTime.now().millisecondsSinceEpoch;

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(image: AssetImage('assets/images/animals/borboleta.png')),
            TextField(
              
            )
          ]

        )
      );
}
