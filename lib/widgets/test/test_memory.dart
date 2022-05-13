import 'package:dezmente/super/super.dart';
import 'package:flutter/material.dart';

class TestMemory extends SuperTest {
  @override
  final description = "Leia as palavras destacadas em voz alta e as memorize";

  const TestMemory({Key? key}) : super(key: key);

  @override
  TestMemoryState createState() => TestMemoryState();
}

class TestMemoryState extends SuperTestState {
  @override
  erase() {
    print("hey");
  }

  List<String> words = [
    "Amarelo",
    "Seda",
    "Barriga",
    "Orquidea",
    "Perna",
    "Casa",
    "Azul",
    "Braço",
    "Porcelana",
    "Algodão",
    "Rosa",
    "Igreja",
    "Violeta",
    "Pescoço"
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemCount: 12,
      itemBuilder: (BuildContext context, int index) {
        return Card(
          color: Colors.white,
          child: Text(words[index]),
        );
      },
    );
  }
}
