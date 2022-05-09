import 'dart:async';

import 'package:dezmente/super/supertest.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class TestVigilance extends SuperTest {
  @override
  final description = "Clique no botão na tela toda vez que aparecer a letra A";

  const TestVigilance({Key? key}) : super(key: key);

  @override
  TestVigilanceState createState() => TestVigilanceState();
}

const chars = [
  "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", //
  "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z" //
];

const probA = 0.35; // Probabilty of A being chosen
const probOthers = 0.026; // Probabilty of other character being chosen
const max = 5;

class TestVigilanceState extends SuperTestState {
  @override
  erase() {}

  String _char = "";
  int _acertos = 0;
  int _tries = 0;

  final _random = Random();

  late Timer _timer;

  void clearTimer() => _timer.cancel();

  void setTimer() {
    if (_tries == max) {
      print(_acertos / max);
      return;
    }

    setRandomChar();
    _timer = Timer(const Duration(seconds: 3), () {
      if (_char != "A") _acertos++;
      setTimer();
    });
  }

  void setRandomChar() {
    _tries++;
    int index = 0;
    do {
      index = 0;
      double randomDouble = _random.nextDouble();
      if (randomDouble > probA) {
        index = ((randomDouble - probA) / probOthers).round();
      }
    } while (_char == chars[index]);

    setState(() {
      _char = chars[index];
    });
  }

  @override
  initState() {
    super.initState();
    setTimer();
  }

  int timeSpended = DateTime.now().millisecondsSinceEpoch;

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
            Text(_char, style: TextStyle(fontSize: 116)),
            const SizedBox(height: 30),
            ElevatedButton(
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
                backgroundColor:
                    MaterialStateProperty.all(const Color(0xfff95f62)),
              ),
            ),
          ]),
    );
  }
}
