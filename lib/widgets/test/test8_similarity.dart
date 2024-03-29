import 'package:dezmente/services/models/result_model.dart';
import 'package:dezmente/services/results.dart';
import 'package:dezmente/common/super.dart';
import 'package:dezmente/utils/get_similarity.dart';
import 'package:flutter/material.dart';

class TestSimilarity extends SuperTest {
  @override
  get description =>
      "Digite qual é a semelhança entre as imagens em UMA palavra";

  @override
  get audioFile => "teste-08.mp3";

  @override
  get title => "Teste 8: Similaridade";

  @override
  get continueButtonText => "Próximo";

  @override
  get needErase => false;

  const TestSimilarity({Key? key}) : super(key: key);

  @override
  TestSimilarityState createState() => TestSimilarityState();
}

class TestSimilarityState extends SuperTestState<TestSimilarity> {
  @override
  erase() {}

  List similarityPairOne = ['laranja.png', 'trem.png', 'relogio.png'];
  List similarityPairTwo = ['banana.png', 'bicicleta.png', 'regua.png'];

  int _imageIndex = 0;

  TextEditingController controller = TextEditingController();

  final Map<String, String> _answers = {};

  int _calculateScore(Map<String, String> answers) {
    int score = 0;

    if (answers["1"]!.contains("transp")) {
      score++;
    }

    if (answers["2"]!.contains("med") ||
        (getSimilarity(answers["2"]!, "métrica") > 0.7)) {
      score++;
    }

    return score;
  }

  @override
  init() {
    super.init();
    data.code = Code.stay;
    controller.text = 'FRUTA';
  }

  @override
  Result getData() {
    _answers[_imageIndex.toString()] = controller.text;
    if (_imageIndex < 2) {
      setState(() => _imageIndex++);
      controller.text = '';
    } else {
      data.code = Code.next;
      data.testId = 8;
      data.score = _calculateScore(_answers);
      data.responses = _answers;
      data.testType = TestTag.abst;
    }
    return super.getData();
  }

  int selected = -1;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return Container(
        padding: EdgeInsets.fromLTRB(10, height * 0.05, 10, 10),
        child: SingleChildScrollView(
          child: Center(
            child: Column(children: [
              _imageIndex == 0 ? _buildExampleText() : Container(),
              Image.asset(
                'assets/images/similarity/${similarityPairOne[_imageIndex]}',
                height: height * 0.3,
              ),
              Image.asset(
                  'assets/images/similarity/${similarityPairTwo[_imageIndex]}',
                  height: height * 0.3),
              _buildInput(!(_imageIndex == 0))
            ]),
          ),
        ));
  }

  Widget _buildExampleText() => const Padding(
        padding: EdgeInsets.symmetric(vertical: 15),
        child: Text("Faça conforme o exemplo",
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.w600)),
      );

  _buildTextField(bool active) => TextField(
        controller: controller,
        autocorrect: false,
        keyboardType: TextInputType.visiblePassword,
        enableSuggestions: false,
        cursorColor: const Color.fromARGB(17, 38, 38, 42),
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 25),
        decoration: InputDecoration(
            fillColor: Colors.transparent,
            filled: true,
            border: InputBorder.none,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            floatingLabelAlignment: FloatingLabelAlignment.center,
            enabled: active,
            label: active
                ? const Text(
                    "DIGITE A SIMILARIDADE",
                    style: TextStyle(
                      fontSize: 25,
                      height: 0.5,
                      color: Color(0xff060607),
                      fontWeight: FontWeight.w700,
                    ),
                  )
                : null),
      );

  Widget _buildInput(bool active) => Container(
        margin: const EdgeInsets.fromLTRB(15, 20, 15, 0),
        decoration: const BoxDecoration(
            color: Color(0x9000B3BE),
            borderRadius: BorderRadius.all(Radius.circular(8))),
        child: _buildTextField(active),
      );
}
