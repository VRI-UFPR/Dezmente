import 'package:dezmente/super/super.dart';
import 'package:flutter/material.dart';

class TestMemory extends SuperTest {
  @override
  final description = "Leia as palavras destacadas em voz alta e as memorize";

  final bool editMode;

  const TestMemory({Key? key, required this.editMode}) : super(key: key);

  @override
  TestMemoryState createState() => TestMemoryState();
}

class _Word {
  _Word(this.text, this.selected);

  String text = "";
  bool selected = false;
}

class TestMemoryState extends SuperTestState<TestMemory> {
  @override
  void initState() {
    super.initState();

    if (!widget.editMode) initMemorize();
  }

  @override
  erase() {}

  initMemorize() {
    final randomPicker = List<int>.generate(12, (i) => i)..shuffle();

    for (int i = 0; i < 4; i++) {
      words[randomPicker[i]].selected = true;
    }
  }

  List<_Word> words = [
    _Word("Amarelo", false),
    _Word("Seda", false),
    _Word("Barriga", false),
    _Word("Orquidea", false),
    _Word("Perna", false),
    _Word("Casa", false),
    _Word("Azul", false),
    _Word("Braço", false),
    _Word("Porcelana", false),
    _Word("Algodão", false),
    _Word("Rosa", false),
    _Word("Igreja", false),
    _Word("Violeta", false),
    _Word("Pescoço", false),
  ];

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight) / 7;
    final double itemWidth = size.width / 2;

    return Container(
      height: size.height - kToolbarHeight,
      alignment: Alignment.center,
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        padding:
            EdgeInsetsDirectional.only(top: (size.height - itemHeight * 7)),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, childAspectRatio: (itemWidth / itemHeight)),
        itemCount: 12,
        itemBuilder: (_, int index) {
          return InkWell(
            onTap: !widget.editMode
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
                    horizontal: 30, vertical: itemHeight / 4),
                decoration: words[index].selected
                    ? BoxDecoration(
                        color: Colors.amber,
                        //borderRadius: BorderRadius.circular(100),
                        border: Border.all(color: Colors.black, width: 0.5),
                      )
                    : BoxDecoration(
                        color: Colors.transparent,
                        //borderRadius: BorderRadius.circular(100),
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
