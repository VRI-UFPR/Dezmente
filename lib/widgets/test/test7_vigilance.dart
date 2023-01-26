import 'dart:async';
import 'dart:io';
import 'package:dezmente/common/super.dart';
import 'package:dezmente/services/models/result_model.dart';
import 'package:flutter/material.dart';

class TestVigilance extends SuperTest {
  @override
  get description =>
      "Clique no botão vermelho toda vez que aparecer a letra A na tela";

  @override
  get needErase => false;

  @override
  get needInfo => false;

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
  int _initTimer = 4;

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
    Feedback.forTap(context);
    if (_char == "") return;
    clearTimer();
    if (_char == "A") _acertos++;
    setTimerVoid();
  }

  @override
  Result getData() {
    data.testId = 7;

    if ((chars.length - _acertos) == 1) {
      data.score = 1;
    } else if ((chars.length - _acertos) == 0) {
      data.score = 2;
    } else {
      data.score = 0;
    }

    data.responses = {"acertos": _acertos};
    data.testType = TestTag.attention;

    return super.getData();
  }

  @override
  Widget build(BuildContext context) => GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(body: Center(child: _body())));

  _body() {
    if (_initTimer >= 0) {
      _initTimer--;

      if (_initTimer < 3) {
        sleep(const Duration(seconds: 1));
      }

      if (_initTimer <= 0) {
        return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _buildCountdown("COMEÇAR!", 70),
              const SizedBox(height: 80),
              _buildButton(false)
            ]);
      }

      return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _buildCountdown(_initTimer.toString(), 116),
            const SizedBox(height: 30),
            _buildButton(false)
          ]);
    }

    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          _buildChar(),
          const SizedBox(height: 30),
          _buildButton(true)
        ]);
  }

  Widget _buildCountdown(String number, double size) => Text(number,
      style: TextStyle(
        fontSize: size,
      ));

  Widget _buildChar() => Text(_char,
      style: const TextStyle(
        fontSize: 116,
      ));

  Widget _buildButton(bool canPress) => Material(
        elevation: canPress ? 5 : 0,
        borderRadius: const BorderRadius.all(Radius.circular(125)),
        child: Opacity(
          opacity: canPress ? 1 : 0.1,
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
              onTap: canPress ? onTap : () {},
              child: const Center(
                child: Text(
                  'CLIQUE',
                  style: TextStyle(fontSize: 24),
                ),
              ),
            ),
          ),
        ),
      );
}
