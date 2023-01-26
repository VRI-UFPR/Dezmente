import 'package:dezmente/services/models/result_model.dart';
import 'package:dezmente/services/results.dart';
import 'package:dezmente/common/super.dart';
//import 'package:dezmente/widgets/play_audio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_6.dart';

class TestMemoryText extends SuperTest {
  @override
  get description => "Leia e responda as questões sobre a história:";

  @override
  get audioFile => "teste-06a.mp3";

  @override
  get title => "Teste 6: Memorização de Texto";

  const TestMemoryText({Key? key}) : super(key: key);

  @override
  TestMemoryTextState createState() => TestMemoryTextState();
}

class Question {
  String name;
  String pergunta;
  List<String> opcoes;
  int correta;
  String audioFile;

  Question(
      {required this.name,
      required this.pergunta,
      required this.opcoes,
      required this.correta,
      required this.audioFile});
}

List<Question> questions = [
  Question(
      name: "biblioteca",
      pergunta: "01) Qual foi a biblioteca em que foram?",
      opcoes: [
        "a) Biblioteca municipal",
        "b) Biblioteca estadual",
        "c) Biblioteca da universidade",
        "d) Biblioteca central"
      ],
      correta: 0,
      audioFile: "teste-06c.mp3"),
  Question(
      name: "esqueceu",
      pergunta: "02) O que João esqueceu em casa?",
      opcoes: ["a) Carteira", "b) Livro", "c) Cartão", "d) Relógio"],
      correta: 1,
      audioFile: "teste-06d.mp3")
];

class TestMemoryTextState extends SuperTestState {
  @override
  erase() {}

  int score = 0;

  void setNextQuestion() {
    questions.removeAt(0);
    setState(() => _selected = -1);
  }

  bool _isQuestion = false;
  int _selected = -1;
  final String _audioFile = "teste-06b.mp3";

  final Map<String, String> _answers = {};

  @override
  Result getData() {
    _answers[questions[0].name] = questions[0].opcoes[_selected];
    if (_selected == questions[0].correta) {
      score++;
    }
    if (questions.length == 1) {
      data.code = Code.next;
      data.testId = 6;
      data.score = score;
      data.responses = _answers;
      data.testType = TestTag.imMem;
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
    final double scrHfactor = MediaQuery.of(context).size.height / 640;
    double width = MediaQuery.of(context).size.width;
    return Center(
      child: SingleChildScrollView(
        child: Column(
          children: [
            // PlayAudio(
            //   audioFile: _isQuestion ? questions[0].audioFile : _audioFile,
            //   iconSize: 48,
            // ),
            _isQuestion ? _bodyQuestions(width) : _body(width, scrHfactor),
          ],
        ),
      ),
    );
  }

  _body(double width, double scrHfactor) {
    return Column(
      children: [
        _buildTitle(width),
        _buildText(width),
        _buildZuno(width, scrHfactor)
      ],
    );
  }

  Widget _buildTitle(width) => Text(
        "LEIA COM ATENÇÃO",
        style: TextStyle(
          color: const Color(0xffe984b8),
          fontSize: width * 0.06,
        ),
        textAlign: TextAlign.center,
      );

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

  Widget _buildZuno(double width, double scrHfactor) => Column(
        children: [
          ChatBubble(
            clipper: ChatBubbleClipper6(
              radius: 40,
              nipSize: 10,
            ),
            elevation: 0,
            alignment: Alignment.center,
            backGroundColor: const Color(0xff8FDEE3),
            margin: EdgeInsets.fromLTRB(width * 0.25, 15, 15, 5),
            child: const Text(
              "Agora responda as perguntas",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'montserrat',
                fontWeight: FontWeight.w600,
                fontSize: 20,
                fontStyle: FontStyle.normal,
                color: Colors.black,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/zunokansei.png',
                height: 80 * scrHfactor,
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() => _isQuestion = true);
                },
                style: ElevatedButton.styleFrom(
                  primary: const Color(0xffe984b8),
                  elevation: 5.0,
                ),
                child: const Text(
                  "AVANÇAR",
                  style: TextStyle(
                    fontFamily: 'montserrat',
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    fontStyle: FontStyle.normal,
                    color: Colors.black,
                  ),
                ),
              )
            ],
          ),
        ],
      );

  _bodyQuestions(width) {
    return Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: const Color(0xffe984b8),
            border: Border.all(),
            borderRadius: BorderRadius.circular(10)),
        child: Column(
          children: [
            _buildQuestionText(questions[0].pergunta, width),
            _buildOptions(questions[0].opcoes, width)
          ],
        ));
  }

  Widget _buildQuestionText(text, width) => Text(
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
