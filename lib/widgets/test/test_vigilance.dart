import 'dart:async';

import 'package:audioplayers/audio_cache.dart';
import 'package:dezmente/super/super.dart';
import 'package:flutter/material.dart';

class TestVigilance extends SuperTest {
  @override
  get description => "Clique no botão na tela toda vez que aparecer a letra A";
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

  final AudioCache _audioCache = AudioCache();

  @override
  init() {
    super.init();
    Future.delayed(const Duration(milliseconds: 500), setTimer);
  }

  String _char = "";
  int _acertos = 0;
  int _index = -1;

  late Timer _timer;

  void clearTimer() => _timer.cancel();

  void setTimer() {
    if (_index == chars.length - 1) {
      print(_acertos / chars.length);
      widget.completeOnFinalChar();
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

  Future<void> onTap() async {
    clearTimer();
    await _audioCache.play('audio/bell-ding.mp3');
    if (_char == "A") _acertos++;
    setTimer();
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
            splashColor: Colors.pink[200],
            borderRadius: const BorderRadius.all(Radius.circular(125)),
            child: const Center(
              child: Text(
                'CLIQUE',
                style: TextStyle(fontSize: 24),
              ),
            ),
            onTap: onTap,
          ),
        ),
      );
}
