import 'package:dezmente/services/results.dart';
import 'package:dezmente/common/super.dart';
import 'package:flutter/material.dart';

class TestSimilarity extends SuperTest {
  @override
  get description => "Digite qual é a semelhança entre as imagens";

  @override
  get audioFile => "teste-08.mp3";

  @override
  get title => "Test 8: Abstração";

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

  @override
  init() {
    super.init();
    data.code = Code.stay;
    controller.text = 'FRUTA';
  }

  @override
  Result getData() {
    if (_imageIndex < 2) {
      setState(() => _imageIndex++);
      controller.text = '';
    } else {
      data.code = Code.next;
    }
    return super.getData();
  }

  int selected = -1;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Container(
        padding: EdgeInsets.fromLTRB(10, height * 0.05, 10, 10),
        child: SingleChildScrollView(
          child: Center(
            child: Column(children: [
              _imageIndex == 0 ? _buildExampleText() : Container(),
              Image.asset(
                  'assets/images/similarity/${similarityPairOne[_imageIndex]}',
                  height: height * 0.3),
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
        cursorColor: const Color.fromARGB(17, 38, 38, 42),
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
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
                      fontSize: 20,
                      height: 0.3,
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
