import 'package:dezmente/super/super.dart';
import 'package:flutter/material.dart';

class TestMemory extends SuperTest {
  @override
  get description => editMode
      ? "Clique nas palavras que estavam em azul na lista anterior"
      : "Leia as palavras destacadas em voz alta e as memorize";

  @override
  get title => editMode ? "Test 11: Memorização" : "Test 4: Memorização";

  final bool editMode;

  const TestMemory({Key? key, required this.editMode}) : super(key: key);

  @override
  TestMemoryState createState() => TestMemoryState();
}

class _Word {
  _Word(this.text, this.corrected, this.selected);
  String text = "";
  bool corrected = false;
  bool selected = false;
}

class TestMemoryState extends SuperTestState<TestMemory> {
  @override
  void initState() {
    super.initState();

    if (!widget.editMode) {
      for (int i = 0; i < words.length; i++) {
        words[i].corrected ? words[i].selected = true : null;
      }
    } else {
      words.shuffle();
    }

    // if (!widget.editMode) {
    //   final randomPicker = List<int>.generate(12, (i) => i)..shuffle();

    //   for (int i = 0; i < 4; i++) {
    //     words[randomPicker[i]].selected = true;
    //   }
    // }
  }

  @override
  erase() {}

  @override
  TestData getData() {
    return super.getData();
  }

  List<_Word> words = [
    _Word("Amarelo", false, false),
    _Word("Braço", true, false),
    _Word("Seda", true, false),
    _Word("Porcelana", false, false),
    _Word("Barriga", false, false),
    _Word("Algodão", false, false),
    _Word("Orquidea", true, false),
    _Word("Rosa", false, false),
    _Word("Perna", false, false),
    _Word("Igreja", true, false),
    _Word("Casa", false, false),
    _Word("Violeta", false, false),
    _Word("Azul", true, false),
    _Word("Pescoço", false, false),
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
                    horizontal: 30, vertical: itemHeight / 5),
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
