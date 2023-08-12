import 'package:dezmente/services/models/result_model.dart';
import 'package:dezmente/services/results.dart';
import 'package:dezmente/common/super.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_6.dart';
import 'package:dezmente/widgets/dialog.dart';

class TestMemoryText extends SuperTest {
  @override
  get description => "Leia e responda as questões sobre a história:";

  @override
  get audioFile => "teste-06a.mp3";

  @override
  get title => "Teste 6: Memorização de Texto";

  @override
  get needErase => false;

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
    setState(() {
      questionIndex++;
      _selected = -1;
    });
  }

  int questionIndex = -1;
  int _selected = -1;

  final Map<String, String> _answers = {};

  @override
  Result getData() {
    if (questionIndex == 1) {
      if (_selected == questions[questionIndex].correta) {
        score++;
      }
      _answers[questions[questionIndex].name] =
          questions[questionIndex].opcoes[_selected];

      data.code = Code.next;
      data.testId = 6;
      data.score = score;
      data.responses = _answers;
      data.testType = TestTag.imMem;
    } else {
      if (questionIndex > -1) {
        if (_selected == questions[questionIndex].correta) {
          score++;
        }
        _answers[questions[questionIndex].name] =
            questions[questionIndex].opcoes[_selected];

        showAlertDialog(
          context: context,
          titleText: "Deseja ir para a próxima pergunta?",
          contentText: "Não será possível retornar após esta ação.",
          callback: () {
            setNextQuestion();
          },
        );
      } else {
        setNextQuestion();
      }
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
    if (questionIndex < 0) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const SizedBox(height: 20),
          _buildTitle(),
          buildHistory(context),
        ],
      );
    } else {
      return buildQuestion(context);
    }
  }

  Widget _buildTitle() => const Text(
        "LEIA COM ATENÇÃO",
        style: TextStyle(
          color: Color(0xffe984b8),
          fontSize: 30,
          fontWeight: FontWeight.bold,
          fontFamily: "montserrat",
        ),
        textAlign: TextAlign.center,
      );

  Widget buildHistory(context) {
    final double scrHfactor = MediaQuery.of(context).size.height / 640;

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      //color: const Color(0xFF569DB3),
      child: Column(
        children: [
          Container(
            height: 300 * scrHfactor,
            padding: const EdgeInsets.fromLTRB(10, 30, 10, 10),
            margin: const EdgeInsets.only(bottom: 20),
            color: Colors.white,
            child: const Center(
              child: Text(
                "João combinou de ir à biblioteca municipal com o filho de seu tio no sábado. Antes de entrar no ônibus, percebeu que tinha esquecido o livro que havia emprestado em casa. Eles tiveram que voltar, pegaram o livro e atrasaram meia hora o passeio.",
                style: TextStyle(
                  fontFamily: "Montserrat",
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          ChatBubble(
            clipper: ChatBubbleClipper6(
              radius: 40,
              nipSize: 10,
            ),
            elevation: 0,
            alignment: Alignment.center,
            backGroundColor: const Color(0xff8FDEE3),
            margin: const EdgeInsets.all(10.0),
            child: const Text(
              "Agora responda as perguntas com base na história:",
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
          Container(
            margin: const EdgeInsets.only(left: 15),
            child: Align(
              alignment: Alignment.topLeft,
              child: Image.asset(
                'assets/images/zunokansei.png',
                height: 100 * scrHfactor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildQuestion(context) {
    final double scrHfactor = MediaQuery.of(context).size.height / 640;
    final double scrWfactor = MediaQuery.of(context).size.width / 360;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.fromLTRB(25, 33, 25, 33),
          color: const Color(0xFF569DB3),
          child: Text(
            questions[questionIndex].pergunta,
            style: const TextStyle(
              fontFamily: "Montserrat",
              fontSize: 28,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.fromLTRB(20, 66, 0, 20),
          child: Container(
            padding: const EdgeInsets.all(10),
            child: _buildOptions(questions[questionIndex].opcoes),
          ),
        ),
      ],
    );
  }

  Widget _buildOptions(options) => ListView.builder(
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
                fontFamily: "montserrat",
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: isSelected ? Colors.amberAccent : Colors.black,
              ),
            ),
          ),
        );
      });
}
