import 'package:dezmente/super/super.dart';
import 'package:dezmente/widgets/test/test_clock.dart';
import 'package:flutter/material.dart';

import 'package:dezmente/widgets/help.dart';
import 'package:dezmente/widgets/test/test_cube.dart';
import 'package:dezmente/widgets/test/test_memory.dart';
import 'package:dezmente/widgets/test/test_conection.dart';

class Teste extends StatefulWidget {
  const Teste({Key? key}) : super(key: key);

  @override
  State<Teste> createState() => _TesteState();
}

SuperTest? currentTest;
GlobalObjectKey<SuperTestState> _globalKey = const GlobalObjectKey("key");

int index = 0;
List<Function> _testes = [
  () => TestConection(
        key: _globalKey,
      ),
  () => TestCube(
        key: _globalKey,
      ),
  () => TestClock(
        key: _globalKey,
      ),
  () => TestMemory(
        key: _globalKey,
      ),
];

class _TesteState extends State<Teste> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback(
      (timeStamp) {
        Navigator.of(context).push(
          PageRouteBuilder(
            opaque: false,
            pageBuilder: (context, animation, secondaryAnimation) =>
                HelpTemplateButton(
              callback: () {
                Navigator.pop(this.context);
              },
              title: "",
              description: currentTest!.description,
              buttonText: "Começar",
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    currentTest = _testes[index]();
    return Scaffold(
      body: currentTest,
      backgroundColor: const Color(0xffffffff),
      bottomNavigationBar: BottomAppBar(
        color: const Color(0xffe984b8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TextButton.icon(
              icon: const Icon(Icons.undo, color: Color(0xff060607)),
              label: const Text(
                "Apagar",
                style: TextStyle(color: Color(0xff060607)),
              ),
              onPressed: () {
                setState(() {
                  _globalKey.currentState?.erase();
                });
              },
            ),
            TextButton.icon(
              icon: const Icon(Icons.check, color: Color(0xff060607)),
              label: const Text(
                "Concluir",
                style: TextStyle(color: Color(0xff060607)),
              ),
              onPressed: () {
                setState(() {
                  timeSpended =
                      DateTime.now().millisecondsSinceEpoch - timeSpended;
                  if (index < _testes.length - 1) {
                    index++;
                    currentTest = _testes[index]();

                    Navigator.of(context).push(PageRouteBuilder(
                        opaque: false,
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            HelpTemplateButton(
                              callback: () {
                                Navigator.pop(this.context);
                              },
                              title: "",
                              description: currentTest!.description,
                              buttonText: "Começar",
                            )));
                  }
                });
              },
            ),
            TextButton.icon(
              onPressed: () {
                Navigator.of(context).push(PageRouteBuilder(
                    opaque: false,
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        HelpTemplateButton(
                          callback: () {
                            Navigator.pop(this.context);
                          },
                          title: "",
                          description: currentTest!.description,
                          buttonText: "Voltar",
                        )));
              },
              icon: const Icon(Icons.info, color: Color(0xff060607)),
              label: const Text(
                "Ajuda",
                style: TextStyle(color: Color(0xff060607)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}