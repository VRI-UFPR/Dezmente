import 'package:dezmente/services/results.dart';
import 'package:dezmente/services/super.dart';
import 'package:dezmente/utils/get_similarity.dart';
import 'package:dezmente/widgets/dialog.dart';
import 'package:flutter/material.dart';

class AnimalData {
  String name = "";
  String file = "";
  double targetSimilarity = 0.0;

  AnimalData(
      {required this.name, required this.file, required this.targetSimilarity});
}

List<AnimalData> animalsData = [
  AnimalData(name: "elefante", file: "elefante.png", targetSimilarity: 0.7),
  AnimalData(name: "girafa", file: "girafa.png", targetSimilarity: 0.7),
  AnimalData(name: "leão", file: "leao.png", targetSimilarity: 0.5),
];

class TestAnimals extends SuperTest {
  @override
  get description => "Digite o nome dos animais que aparecem na tela";

  @override
  get audioFile => "teste-04.mp3";

  @override
  get title => "Test 4: Animais";

  const TestAnimals({Key? key}) : super(key: key);

  @override
  TestAnimalsState createState() => TestAnimalsState();
}

class TestAnimalsState extends SuperTestState {
  @override
  erase() {
    controller.text = "";
  }

  int score = 0;

  void _scoreFunction() {
    String name = animalsData[_animalIndex].name.toLowerCase();
    double targetSimilarity = animalsData[_animalIndex].targetSimilarity;
    double similarity = getSimilarity(name, controller.text);
    if (similarity > targetSimilarity) score++;
  }

  @override
  TestResults getData() {
    if (_animalIndex == 2) {
      _scoreFunction();
      data.code = Code.next;
      print(score);
    } else {
      showAlertDialog(
          context: context,
          titleText: "Deseja ir para próxima imagem?",
          contentText: "Não será possível retornar após esta ação.",
          callback: setNextAnimal);
    }
    return super.getData();
  }

  @override
  init() {
    super.init();
    data.code = Code.stay;
  }

  final _random = Random();

  void setNextAnimal() {
    _scoreFunction();
    setState(() => _animalIndex += 1);
    controller.clear();
  }

  TextEditingController controller = TextEditingController();

  int pressedErase = 0; // quantidade de vezes que o botao apagar foi utilizado
  int timeSpended = DateTime.now().millisecondsSinceEpoch;

  @override
  Widget build(BuildContext context) => GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Center(child: SingleChildScrollView(child: _body())));

  _body() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
        _buildImageBox(),
        _buildInput(),
      ]),
    );
  }

  _buildImageBox() => Container(
      height: MediaQuery.of(context).size.width * 0.65,
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: const Color(0xffe984b8), width: 2.5),
          borderRadius: BorderRadius.circular(5),
          image: DecorationImage(
            image: AssetImage(
                'assets/images/animals/${animalsData[_animalIndex].file}'),
            fit: BoxFit.contain,
          )));

  _buildTextField() => TextField(
        controller: controller,
        cursorColor: const Color.fromARGB(17, 38, 38, 42),
        textAlign: TextAlign.center,
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
}
