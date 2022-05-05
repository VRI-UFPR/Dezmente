import 'package:dezmente/pages/teste.dart';
import 'package:dezmente/super/supertest.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'dart:math';

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
  final description = "Digite o nome dos animais que aparecem na tela";

  const TestAnimals({Key? key}) : super(key: key);

  @override
  TestAnimalsState createState() => TestAnimalsState();
}

enum Boxes { face1, face2, face3, face4, face5, face6 }

class TestAnimalsState extends SuperTestState {
  @override
  erase() {
    controller.text = "";
  }

  final _random = Random();

  Map<String, String> imageNames = {
    "leão": "leao.png",
    "camelo": "camelo.png",
    "rinoceronte": "rinoceronte.png",
  };

  String _animal = "", _file = "";

  void getRandomImage() {
    int max = imageNames.length;
    int randomIndex = _random.nextInt(max - 0);
    _file = imageNames.values.elementAt(randomIndex);
    _animal = imageNames.keys.elementAt(randomIndex);
  }

  @override
  initState() {
    getRandomImage();
  }

  TextEditingController controller = TextEditingController();

  int pressedErase = 0; // quantidade de vezes que o botao apagar foi utilizado
  int timeSpended = DateTime.now().millisecondsSinceEpoch;

  @override
  Widget build(BuildContext context) =>
      Scaffold(body: Center(child: SingleChildScrollView(child: _body())));

  _body() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
        _buildImageBox(),
        _buildInput(),
        SizedBox(
          height: 30,
        ),
        _buildButton(),
      ]),
    );
  }

  _buildImageBox() => Container(
      height: MediaQuery.of(context).size.width * 0.65,
      decoration: BoxDecoration(
          color: const Color(0xffececec),
          border: Border.all(color: const Color(0xffe984b8), width: 2.5),
          borderRadius: BorderRadius.circular(5),
          image: DecorationImage(
            image: AssetImage('assets/images/animals/$_file'),
            fit: BoxFit.contain,
          )));

  _buildTextField() => TextField(
        controller: controller,
        cursorColor: const Color.fromARGB(17, 38, 38, 42),
        decoration: const InputDecoration(
          fillColor: Colors.transparent,
          filled: true,
          border: InputBorder.none,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          floatingLabelAlignment: FloatingLabelAlignment.center,
          label: Text(
            "DIGITE O NOME DO ANIMAL",
            style: TextStyle(
              fontSize: 20,
              height: 0.3,
              color: Color(0xff060607),
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      );

  _buildInput() => Container(
        margin: const EdgeInsets.fromLTRB(15, 20, 15, 0),
        decoration: const BoxDecoration(
            color: Color(0x9000B3BE),
            borderRadius: BorderRadius.all(Radius.circular(8))),
        child: _buildTextField(),
      );

  _buildButton() => ElevatedButton.icon(
        icon: const Text('Próximo',
            style: TextStyle(color: Color(0xff060607), fontSize: 16)),
        label: const Icon(Icons.arrow_forward, color: Color(0xff060607)),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith((states) =>
              states.contains(MaterialState.pressed)
                  ? const Color(0xcfe984b8)
                  : const Color(0xffe984b8)),
          padding: MaterialStateProperty.all(
              const EdgeInsets.symmetric(vertical: 10, horizontal: 20)),
        ),
        onPressed: () {},
      );
}
