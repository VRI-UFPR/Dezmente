import 'dart:async';
import 'package:dezmente/common/super.dart';
import 'package:dezmente/services/models/result_model.dart';
import 'package:flutter/material.dart';

class TestVigilance extends SuperTest {
  @override
  get description => "Clique no botão na tela toda vez que aparecer a letra A";

  @override
  get audioFile => "teste-07.mp3";

  @override
  get title => "Teste 7: Vigilância";

  final VoidCallback completeOnFinalChar;

  const TestVigilance({Key? key, required this.completeOnFinalChar})
      : super(key: key);

  @override
  TestVigilanceState createState() => TestVigilanceState();
}

const chars = [
  "F", "B", "A", "C", "M", "N", "A", "A", "J", "K", "L", "B", "A", "F", //
  "A", "K", "D", "E", "A", "A", "A", "J", "A", "M", "O", "F", "A", "A", "B"
];

class TestVigilanceState extends SuperTestState<TestVigilance> {
  @override
  erase() {}

  @override
  init() {
    super.init();
    Future.delayed(const Duration(milliseconds: 500), setTimerChar);
  }

  String _char = "";
  int _acertos = 0;
  int _index = -1;

  late Timer _timer;

  void clearTimer() => _timer.cancel();

  void setTimerChar() {
    if (_index == chars.length - 1) {
      widget.completeOnFinalChar();
      return;
    }
    setNextChar();
    _timer = Timer(const Duration(milliseconds: 600), () {
      if (_char != "A") _acertos++;
      setTimerVoid();
    });
  }

  void setTimerVoid() {
    setState(() => _char = "");
    _timer = Timer(const Duration(milliseconds: 400), () => setTimerChar());
  }

  void setNextChar() {
    _index++;
    setState(() => _char = chars[_index]);
  }

  void onTap() {
    if (_char == "") return;
    clearTimer();
    if (_char == "A") _acertos++;
    setTimerVoid();
  }

  @override
  Result getData() {
    data.testId = 7;
    data.score = _acertos == chars.length ? 1 : 0;
    data.responses = {"acertos": _acertos};

    return super.getData();
  }

  @override
  Widget build(BuildContext context) => GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(body: Center(child: _body())));

  _body() {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          _buildChar(),
          const SizedBox(height: 30),
          _buildButton()
        ]);
  }

  Widget _buildChar() => Text(_char,
      style: const TextStyle(
        fontSize: 116,
      ));

  Widget _buildButton() => Material(
        elevation: 5,
        borderRadius: const BorderRadius.all(Radius.circular(125)),
        child: Ink(
          height: 125,
          width: 125,
          decoration: const BoxDecoration(
              color: Color(0xfff95f62),
              borderRadius: BorderRadius.all(Radius.circular(125))),
          child: InkWell(
            enableFeedback: true,
            splashColor: Colors.pink[200],
            borderRadius: const BorderRadius.all(Radius.circular(125)),
            onTap: onTap,
            child: const Center(
              child: Text(
                'CLIQUE',
                style: TextStyle(fontSize: 24),
              ),
            ),
          ),
        ),
      );
}
