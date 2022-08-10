import 'package:dezmente/services/results.dart';
import 'package:dezmente/pages/common/super.dart';
import 'package:flutter/material.dart';

class TestMemoryQuestions extends SuperTest {
  @override
  final description = "Agora responda as perguntas: ";

  @override
  get title => "Test 6: Memorização de Texto";

  const TestMemoryQuestions({Key? key}) : super(key: key);

  @override
  TestMemoryQuestionsState createState() => TestMemoryQuestionsState();
}

class Question {
  String pergunta;
  List<String> opcoes;
  int correta;

  Question(
      {required this.pergunta, required this.opcoes, required this.correta});
}

class TestMemoryQuestionsState extends SuperTestState {
  @override
  erase() {}

  final questions = [
    Question(
        pergunta: "01) Qual foi a biblioteca em que foram?",
        opcoes: [
          "a) Biblioteca municipal",
          "b) Biblioteca estadual",
          "c) Biblioteca da universidade",
          "d) Biblioteca central"
        ],
        correta: 0),
    Question(
        pergunta: "02) O que João esqueceu em casa?",
        opcoes: ["a) Carteira", "b) Livro", "c) Cartão", "d) Relógio"],
        correta: 1)
  ];

  void setNextQuestion() {
    questions.removeAt(0);
    setState(() => _selected = -1);
  }

  int _selected = -1;

  @override
  Result getData() {
    print(_selected == questions[0].correta ? "Acertou" : "Errou");
    if (questions.length == 1) {
      data.code = Code.next;
    } else {
      setNextQuestion();
    }
    return super.getData();
  }

  @override
  init() {
    super.init();
    data.code = Code.stay;
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        body: Center(
            child: SingleChildScrollView(
                child: Padding(
                    padding: const EdgeInsets.all(20), child: _body(width)))));
  }

  _body(width) {
    return Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: const Color(0xffe984b8),
            border: Border.all(),
            borderRadius: BorderRadius.circular(10)),
        child: Column(
          children: [
            _buildText(questions[0].pergunta, width),
            _buildOptions(questions[0].opcoes, width)
          ],
        ));
  }

  Widget _buildText(text, width) => Text(
        text,
        textAlign: TextAlign.justify,
        style: TextStyle(fontSize: width * 0.06, fontWeight: FontWeight.w600),
      );

  Widget _buildOptions(options, width) => ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      padding: const EdgeInsets.all(8),
      itemCount: options.length,
      itemBuilder: (context, index) {
        bool isSelected = _selected == index;
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 14),
          child: InkWell(
            onTap: () => setState(() => _selected = index),
            child: Text(
              options[index],
              style: TextStyle(
                  fontSize: width * 0.05,
                  fontWeight: isSelected ? FontWeight.w500 : FontWeight.normal,
                  color: isSelected ? Colors.amberAccent : Colors.black),
            ),
          ),
        );
      });
}
