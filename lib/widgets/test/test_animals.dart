import 'package:dezmente/services/results.dart';
import 'package:dezmente/pages/common/super.dart';
import 'package:dezmente/utils/levenshtein_dist.dart';
import 'package:dezmente/widgets/dialog.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class TestAnimals extends SuperTest {
  @override
  get description => "Digite o nome dos animais que aparecem na tela";

  @override
  get title => "Test 3: Animais";

  const TestAnimals({Key? key}) : super(key: key);

  @override
  TestAnimalsState createState() => TestAnimalsState();
}

class TestAnimalsState extends SuperTestState {
  @override
  erase() {
    controller.text = "";
  }

  @override
  Result getData() {
    if (imageNames.isEmpty) {
      print(_similarity(_animal, controller.text));
      data.code = Code.next;
    } else {
      showAlertDialog(
          context: context,
          titleText: "Deseja ir para próxima imagem?",
          contentText: "Não será possível retornar após esta ação.",
          callback: setRandomImage);
    }
    return super.getData();
  }

  @override
  init() {
    super.init();
    data.code = Code.stay;
  }

  final _random = Random();

  Map<String, String> imageNames = {
    "leão": "leao.png",
    "elefante": "elefante.png",
    "girafa": "girafa.png",
  };

  String _animal = "", _file = "";

  void setRandomImage() {
    print(_similarity(_animal, controller.text));
    int max = imageNames.length;
    int randomIndex = _random.nextInt(max - 0);
    setState(() {
      _file = imageNames.values.elementAt(randomIndex);
      _animal = imageNames.keys.elementAt(randomIndex);
    });
    imageNames.remove(_animal);
    controller.clear();
  }

  @override
  initState() {
    super.initState();
    int max = imageNames.length;
    int randomIndex = _random.nextInt(max - 0);
    _file = imageNames.values.elementAt(randomIndex);
    _animal = imageNames.keys.elementAt(randomIndex);
    imageNames.remove(_animal);
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
            image: AssetImage('assets/images/animals/$_file'),
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

  double _similarity(String a, String b) {
    double similarity;
    a = a.toUpperCase();
    b = b.toUpperCase();
    similarity = 1 - levenshteinDist(a, b) / (max(a.length, b.length));
    return (similarity);
  }
}
