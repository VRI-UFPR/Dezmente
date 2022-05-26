import 'package:dezmente/super/super.dart';
import 'package:flutter/material.dart';

class TestMemoryText extends SuperTest {
  @override
  final description = "Leia e responda as questões sobre a história:";

  const TestMemoryText({Key? key}) : super(key: key);

  @override
  TestMemoryTextState createState() => TestMemoryTextState();
}

class TestMemoryTextState extends SuperTestState {
  @override
  erase() {}

  double fontSize = 16;
  final magnifyingFactor = 2.0;
  final max = 30;
  final min = 12;

  void changeFontSize(double op) {
    double newFontSize = fontSize + op;
    if (newFontSize < min || newFontSize > max) return;
    setState(() => fontSize = newFontSize);
  }

  @override
  Widget build(BuildContext context) =>
      Scaffold(body: Center(child: SingleChildScrollView(child: _body())));

  _body() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
        _buildText(),
        Row(
          children: [
            ElevatedButton(
                onPressed: () => changeFontSize(magnifyingFactor),
                child: const Icon(Icons.text_increase_rounded)),
            const SizedBox(
              width: 10,
            ),
            ElevatedButton(
                onPressed: () => changeFontSize(magnifyingFactor * -1),
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Colors.blueGrey)),
                child: const Icon(Icons.text_decrease_rounded))
          ],
        )
      ]),
    );
  }

  Widget _buildText() => Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: const Color(0xffe984b8),
          border: Border.all(),
          borderRadius: BorderRadius.circular(10)),
      child: Text(
        "João combinou de ir à biblioteca municipal com o filho de seu tio no sábado. Antes de entrar no ônibus, percebeu que tinha esquecido o livro que havia emprestado em casa. Eles tiveram que voltar, pegaram o livro e atrasaram meia hora o passeio.",
        textAlign: TextAlign.justify,
        style: TextStyle(fontSize: fontSize),
      ));
}
