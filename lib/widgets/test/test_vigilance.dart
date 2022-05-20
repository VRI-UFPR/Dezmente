import 'dart:async';

import 'package:dezmente/super/super.dart';
import 'package:flutter/material.dart';

class TestVigilance extends SuperTest {
  @override
  final description = "Clique no botão na tela toda vez que aparecer a letra A";

  const TestVigilance({Key? key}) : super(key: key);

  @override
  TestVigilanceState createState() => TestVigilanceState();
}

const chars = [
  "F", "B", "A", "C", "M", "N", "A", "A", "J", "K", "L", "B", "A", "F", //
  "A", "K", "D", "E", "A", "A", "A", "J", "A", "M", "O", "F", "A", "A", "B"
];

class TestVigilanceState extends SuperTestState {
  @override
  erase() {}

  @override
  init() {
    super.init();
    data.code = Code.next;
    setTimer();
  }

  String _char = "";
  int _acertos = 0;
  int _index = -1;

  late Timer _timer;

  void clearTimer() => _timer.cancel();

  void setTimer() {
    if (_index == chars.length - 1) {
      print(_acertos / chars.length);
      return;
    }
    setNextChar();
    _timer = Timer(const Duration(seconds: 3), () {
      if (_char != "A") _acertos++;
      setTimer();
    });
  }

  void setNextChar() {
    _index++;
    setState(() {
      _char = chars[_index];
    });
  }

  @override
  Widget build(BuildContext context) => GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(body: Center(child: _body())));

  _body() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _buildChar(),
            const SizedBox(height: 30),
            _buildButton()
          ]),
    );
  }

  Widget _buildChar() => Text(_char,
      style: TextStyle(
          fontSize: 116,
          color: _index % 2 == 0 ? Colors.blue[900] : Colors.yellow[800]));

  Widget _buildButton() => ElevatedButton(
        child: const Text(
          'CLIQUE',
          style: TextStyle(fontSize: 24),
        ),
        onPressed: () {
          clearTimer();
          if (_char == "A") _acertos++;
          setTimer();
        },
        style: ButtonStyle(
          fixedSize: MaterialStateProperty.all(const Size(125, 125)),
          shape: MaterialStateProperty.all(const CircleBorder()),
          backgroundColor: MaterialStateProperty.all(const Color(0xfff95f62)),
        ),
      );
}
