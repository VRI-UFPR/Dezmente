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

class TestVigilanceState extends SuperTestState {
  @override
  erase() {}

  final _random = Random();

  void setRandomImage() {
    // int max = imageNames.length;
    // int randomIndex = _random.nextInt(max - 0);
    // imageNames.remove(_animal);
    // controller.clear();
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
            Text("A", style: TextStyle(fontSize: 128)),
            SizedBox(height: 30),
            ElevatedButton(
              child: const Text(
                'CLIQUE',
                style: TextStyle(fontSize: 24),
              ),
              onPressed: () {},
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
