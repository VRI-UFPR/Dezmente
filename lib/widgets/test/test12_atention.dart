import 'package:dezmente/services/models/result_model.dart';
import 'package:dezmente/services/results.dart';
import 'package:dezmente/common/super.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_6.dart';
import 'package:dezmente/widgets/dialog.dart';

class TestAtention extends SuperTest {
  @override
  get description => "Responda as questões com base na história:";

  @override
  get audioFile => "teste-12a.mp3";

  @override
  get title => "Teste 12: Atenção";

  @override
  get needErase => false;

  const TestAtention({Key? key}) : super(key: key);

  @override
  TestAtentionState createState() => TestAtentionState();
}

class TestAtentionState extends SuperTestState {
  @override
  erase() {
    _textController.clear();
  }

  final List<String> questions = [
    "01) Após dar 7 reais ao primeiro neto, com quantos reais seu Maurício ficou?",
    "02) Após dar 7 reais ao segundo neto, com quantos reais seu Maurício ficou?",
    "03) Após dar 7 reais ao terceiro neto, com quantos reais seu Maurício ficou?",
    "04) Após dar 7 reais ao quarto neto, com quantos reais seu Maurício ficou?",
    "05) Após dar 7 reais ao quinto neto, com quantos reais seu Maurício ficou?"
  ];

  int questionIndex = -1;
  List<int> answers = [];
  final _textController = TextEditingController();

  int _calculateScore() {
    int score = 0;

    if (answers.isEmpty) {
      return score;
    }

    if (answers.first == 93) {
      score++;
    }

    for (var i = 0; i < answers.length - 1; i++) {
      if (answers.elementAt(i) == answers.elementAt(i + 1) + 7) {
        score++;
      }
    }

    return score;
  }

  @override
  Result getData() {
    if (questionIndex == 4) {
      data.code = Code.next;
      data.testId = 12;
      data.responses = {"numbers": answers.toString()};
      data.score = _calculateScore();
      data.testType = TestTag.arth;
    } else {
      if (questionIndex > -1) {
        showAlertDialog(
          context: context,
          titleText: "Deseja ir para a próxima pergunta?",
          contentText: "Não será possível retornar após esta ação.",
          callback: () {
            setState(() {
              questionIndex++;
              _textController.clear();
            });
          },
        );
      } else {
        setState(() {
          questionIndex++;
          _textController.clear();
        });
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
    if (questionIndex == -1) {
      return buildHistory(context);
    } else {
      return buildQuestion(context);
    }
  }

  Widget buildHistory(context) {
    final double scrHfactor = MediaQuery.of(context).size.height / 640;

    return Container(
      //color: const Color(0xFFB4EADF),
      child: Column(
        children: [
          Container(
            height: 300 * scrHfactor,
            padding: const EdgeInsets.fromLTRB(10, 30, 10, 10),
            margin: const EdgeInsets.only(bottom: 20),
            color: Colors.white,
            child: const Center(
              child: Text(
                "Seu Maurício tinha 100 reais e resolveu dar uma mesada de 7 reais para cada um de seus 5 netos.",
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
          color: const Color(0xFFB4EADF),
          child: Text(
            questions[questionIndex],
            style: const TextStyle(
              fontFamily: "Montserrat",
              fontSize: 28,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        Container(
          width: 160 * scrWfactor,
          margin: const EdgeInsets.fromLTRB(0, 66, 0, 20),
          child: const Center(
            child: Text(
              "DIGITE SUA RESPOSTA:",
              style: TextStyle(
                fontFamily: "montserrat",
                fontWeight: FontWeight.w700,
                fontSize: 25,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        Center(
          child: Container(
            margin: const EdgeInsets.only(top: 15),
            width: 150 * scrWfactor,
            height: 61 * scrHfactor,
            decoration: BoxDecoration(
              border: Border.all(
                color: const Color(0xFFEAEAEA),
              ),
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              color: const Color(0xFFEAEAEA),
            ),
            child: TextField(
              controller: _textController,
              cursorColor: Colors.transparent,
              style: const TextStyle(
                fontFamily: "montserrat",
                fontSize: 42,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(9, 20, 0, 0),
                border: InputBorder.none,
                counterStyle: TextStyle(color: Colors.transparent),
              ),
              keyboardType: TextInputType.number,
              autocorrect: false,
              maxLength: 3,
              onSubmitted: (input) {
                setState(() {
                  answers.insert(questionIndex, int.parse(input));
                });
              },
            ),
          ),
        ),
      ],
    );
  }
}
