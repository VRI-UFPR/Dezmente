import 'package:dezmente/services/models/result_model.dart';
import 'package:dezmente/services/results.dart';
import 'package:dezmente/common/super.dart';
import 'package:flutter/material.dart';

class TestMemory extends SuperTest {
  @override
  get description => editMode == 0
      ? "Leia as palavras destacadas em voz alta e as memorize"
      : editMode == 1
          ? "Agora, clique nas palavras que estavam destacadas, só para treino"
          : "Clique nas palavras que estavam em destaque na lista anterior";

  @override
  get audioFile => editMode == 0
      ? "teste-05a.mp3"
      : editMode == 1
          ? "teste-05b.mp3"
          : "teste-11.mp3";

  @override
  get title => editMode == 0
      ? "Teste 5: Memorização"
      : editMode == 1
          ? "Teste 5: Reforço Memorização"
          : "Teste 11: Memorização";
  //editMode 0 é apenas as palavras, 1 teste sem nota e 2 e o teste com nota

  @override
  get needErase => false;

  final int editMode;

  const TestMemory({Key? key, required this.editMode}) : super(key: key);

  @override
  TestMemoryState createState() => TestMemoryState();
}

class _Word {
  String text = "";
  bool answer = false;
  bool selected = false;

  _Word(this.text, this.answer, this.selected);
}

class TestMemoryState extends SuperTestState<TestMemory> {
  late bool buffer;

  @override
  void initState() {
    super.initState();
    buffer = false;
    if (widget.editMode == 0) {
      for (int i = 0; i < words.length; i++) {
        words[i].answer ? words[i].selected = true : null;
      }
    } else {
      words.shuffle();
    }
  }

  @override
  init() {
    super.init();
    buffer = false;

    if (widget.editMode == 1) {
      for (int i = 0; i < words.length; i++) {
        words[i].selected = false;
      }
      words.shuffle();
      setState(() {});
    }
  }

  @override
  erase() {}

  @override
  Result getData() {
    data.code = Code.notInclude;
    if (widget.editMode == 1 && !buffer) {
      data.code = Code.stay;
      setState(() {
        buffer = true;
      });
    }

    if (widget.editMode == 2) {
      int acerto = 0, erro = 0;

      data.code = Code.next;
      for (var r in words) {
        if (r.answer) {
          if (r.selected) {
            acerto++;
          } else {
            erro++;
          }
        }
      }
      data.score = acerto;
      data.testId = 11;
      data.testTitle = widget.title;
      data.responses = {
        for (var r in words)
          r.text: {'respostaCorreta': r.answer, 'resposta': r.selected}
      };
    }

    return super.getData();
  }

  List<_Word> words = [
    _Word("Lírio", false, false),
    _Word("Cravo", false, false),
    _Word("Branco", false, false),
    _Word("Padaria", false, false),
    _Word("Verde", false, false),
    _Word("Perna", false, false),
    _Word("Orquidea", true, false),
    _Word("Braço", true, false),
    _Word("Casa", false, false),
    _Word("Linho", false, false),
    _Word("Algodão", false, false),
    _Word("Igreja", true, false),
    _Word("Azul", true, false),
    _Word("Seda", true, false),
  ];

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight) / 8;
    final double itemWidth = size.width / 2;

    return Container(
      height: size.height - kToolbarHeight,
      alignment: Alignment.center,
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        padding:
            EdgeInsetsDirectional.only(top: (size.height - itemHeight * 8)),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, childAspectRatio: (itemWidth / itemHeight)),
        itemCount: 14,
        itemBuilder: (_, int index) {
          return InkWell(
            onTap: widget.editMode == 0
                ? null
                : () {
                    setState(() {
                      words[index].selected = !words[index].selected;
                    });
                  },
            child: GridTile(
              child: Container(
                height: 10,
                alignment: Alignment.center,
                margin: EdgeInsets.symmetric(
                    horizontal: 30, vertical: itemHeight / 5),
                decoration: !buffer
                    ? words[index].selected
                        ? BoxDecoration(
                            color: Colors.amber,
                            border: Border.all(color: Colors.black, width: 0.5),
                          )
                        : BoxDecoration(
                            color: Colors.transparent,
                            border: Border.all(color: Colors.blue, width: 2),
                          )
                    : words[index].answer
                        ? words[index].selected
                            ? BoxDecoration(
                                color: Colors.green,
                                border:
                                    Border.all(color: Colors.black, width: 0.5),
                              )
                            : BoxDecoration(
                                color: Colors.red,
                                border:
                                    Border.all(color: Colors.blue, width: 2),
                              )
                        : BoxDecoration(
                            color: Colors.transparent,
                            border: Border.all(color: Colors.blue, width: 2),
                          ),
                child: Text(
                  words[index].text,
                  style: words[index].selected
                      ? const TextStyle(
                          color: Colors.black,
                          fontFamily: 'Montserrat',
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1,
                        )
                      : const TextStyle(
                          color: Colors.black,
                          fontFamily: 'Montserrat',
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1,
                        ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
