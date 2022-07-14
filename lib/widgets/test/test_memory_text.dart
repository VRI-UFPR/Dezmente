import 'package:dezmente/services/super.dart';
import 'package:flutter/material.dart';

class TestMemoryText extends SuperTest {
  @override
  final description = "Leia e responda as questões sobre a história:";

  @override
  get title => "Test 5: Memorização de Texto";

  const TestMemoryText({Key? key}) : super(key: key);

  @override
  TestMemoryTextState createState() => TestMemoryTextState();
}

class TestMemoryTextState extends SuperTestState {
  @override
  erase() {}

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        body: Center(child: SingleChildScrollView(child: _body(width))));
  }

  _body(double width) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: _buildText(width),
    );
  }

  Widget _buildText(double width) => Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: const Color(0xffe984b8),
          border: Border.all(),
          borderRadius: BorderRadius.circular(10)),
      child: Text(
        "João combinou de ir à biblioteca municipal com o filho de seu tio no sábado. Antes de entrar no ônibus, percebeu que tinha esquecido o livro que havia emprestado em casa. Eles tiveram que voltar, pegaram o livro e atrasaram meia hora o passeio.",
        textAlign: TextAlign.justify,
        style: TextStyle(fontSize: width * 0.06),
      ));
}
