import 'package:dezmente/services/results.dart';
import 'package:dezmente/pages/common/super.dart';
import 'package:dezmente/widgets/dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_6.dart';

class TestAtention extends SuperTest {
  @override
  get description => "Responda as questões com base na história:";

  @override
  get title => "Test 12: Atenção";

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
  List<String> answers = [];
  var _textController = TextEditingController();

  @override
  TestResults getData() {
    if (questionIndex == 4) {
      data.code = Code.next;
    } else {
      if (questionIndex == -1) {
        showAlertDialog(
          context: context,
          titleText: "Deseja começar a responder as perguntas?",
          contentText: "Não será possível retornar após esta ação.",
          callback: () {
            setState(() {
              questionIndex++;
              _textController.clear();
            });
          },
        );
      } else {
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
      }
    }
    return super.getData();
  }

  @override
  init() {
    super.init();
    data.code = Code.stay;
  }

  int pressedErase = 0; // quantidade de vezes que o botao apagar foi utilizado
  int timeSpended = DateTime.now().millisecondsSinceEpoch;

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

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.fromLTRB(10, 30, 10, 10),
          margin: const EdgeInsets.only(bottom: 20),
          child: const Text(
            "Seu Maurício tinha 100 reais e resolveu dar uma mesada de 7 reais para cada um de seus 5 netos.",
            style: TextStyle(
              fontFamily: "Montserrat",
              fontSize: 24,
              fontWeight: FontWeight.w600,
            ),
          ),
          color: const Color(0xFEAA8899),
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
            "Agora responda as perguntas:",
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
    );
  }

  Widget buildQuestion(context) {
    final double scrHfactor = MediaQuery.of(context).size.height / 640;
    final double scrWfactor = MediaQuery.of(context).size.width / 360;

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.fromLTRB(10, 30, 10, 10),
          child: Text(
            questions[questionIndex],
            style: const TextStyle(
              fontFamily: "Montserrat",
              fontSize: 24,
              fontWeight: FontWeight.w600,
            ),
          ),
          color: const Color(0xFEAA8899),
        ),
        Container(
          margin: const EdgeInsets.only(top: 20),
          child: const Center(
            child: Text(
              "Digite sua resposta:",
              style: TextStyle(
                fontFamily: "montserrat",
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
        ),
        Center(
          child: Container(
            margin: const EdgeInsets.only(top: 15),
            color: const Color(0xC4C4C4CC),
            width: 70 * scrWfactor,
            height: 92 * scrHfactor,
            child: TextField(
              controller: _textController,
              cursorColor: Colors.transparent,
              style: const TextStyle(
                fontFamily: "montserrat",
                fontSize: 24,
                fontWeight: FontWeight.w600,
              ),
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(9, 25, 0, 0),
                border: InputBorder.none,
                counterStyle: TextStyle(color: Colors.transparent),
              ),
              keyboardType: TextInputType.number,
              autocorrect: false,
              maxLength: 3,
              onSubmitted: (input) {
                setState(() {
                  answers.insert(questionIndex, input);
                  print(answers);
                  print(questionIndex);
                });
              },
            ),
          ),
        ),
      ],
    );
  }
}
