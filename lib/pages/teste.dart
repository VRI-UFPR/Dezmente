import 'package:dezmente/super/super.dart';
import 'package:dezmente/widgets/debug_select_test.dart';
import 'package:dezmente/widgets/test/test_abstraction.dart';
import 'package:dezmente/widgets/test/test_animals.dart';
import 'package:dezmente/widgets/test/test_clock.dart';
import 'package:dezmente/widgets/test/test_conection.dart';
import 'package:dezmente/widgets/test/test_cube.dart';
import 'package:dezmente/widgets/test/test_memory.dart';
import 'package:dezmente/widgets/test/test_vigilance.dart';
import 'package:flutter/material.dart';

import 'package:dezmente/widgets/help.dart';

class Teste extends StatefulWidget {
  const Teste({Key? key}) : super(key: key);

  @override
  State<Teste> createState() => _TesteState();
}

const debugMode = true;
GlobalObjectKey<SuperTestState> _globalKey = const GlobalObjectKey("key");

class _TesteState extends State<Teste> {
  late SuperTest currentTest;
  int index = 0;

  void nextTest() async {
    if (_globalKey.currentState?.getData().code == Code.next) {
      if (index < _testes.length - 1) {
        setState(() {
          index++;
          currentTest = _testes[index]();
        });

        await Navigator.of(context).push(
          PageRouteBuilder(
            opaque: false,
            pageBuilder: (context, animation, secondaryAnimation) =>
                HelpTemplateButton(
              callback: () {
                Navigator.pop(this.context);
              },
              title: "",
              description: currentTest.description,
              buttonText: "Começar",
            ),
          ),
        );
        _globalKey.currentState?.init();
      }
    }
  }

  late final List<Function> _testes;

  final List<String> _testeNames = [
    "Test Conection",
    "Test Cube",
    "Test Animals",
    "Test Memory Memorize",
    "Test Vigilance",
    "Test Clock",
    "Test Abstraction",
    "Test Memory Check",
  ];

  @override
  void initState() {
    super.initState();

    _testes = [
      () => TestConection(
            key: _globalKey,
          ),
      () => TestCube(
            key: _globalKey,
          ),
      () => TestAnimals(
            key: _globalKey,
          ),
      () => TestMemory(
            key: _globalKey,
            editMode: false,
          ),
      () => TestVigilance(
            key: _globalKey,
            completeOnFinalChar: () {
              nextTest();
            },
          ),
      () => TestClock(
            key: _globalKey,
          ),
      () => TestAbstraction(
            key: _globalKey,
          ),
      () => TestMemory(
            key: _globalKey,
            editMode: true,
          ),
    ];

    currentTest = _testes.first();

    WidgetsBinding.instance!.addPostFrameCallback(
      (timeStamp) async {
        await Navigator.of(context).push(
          PageRouteBuilder(
            opaque: false,
            pageBuilder: (context, animation, secondaryAnimation) =>
                HelpTemplateButton(
              callback: () {
                Navigator.pop(this.context);
              },
              title: "",
              description: currentTest.description,
              buttonText: "Começar",
            ),
          ),
        );
        _globalKey.currentState?.init();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
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
                setState(
                  () {
                    _globalKey.currentState?.erase();
                  },
                );
              },
            ),
            TextButton.icon(
              icon: const Icon(Icons.check, color: Color(0xff060607)),
              label: const Text(
                "Concluir",
                style: TextStyle(color: Color(0xff060607)),
              ),
              onLongPress: !debugMode
                  ? null
                  : () {
                      setState(
                        () {
                          currentTest = DebugSelectTest(
                            testList: _testeNames,
                            onTestSelected: (i) {
                              setState(() {
                                currentTest = _testes[i]();
                              });
                            },
                          );
                        },
                      );
                    },
              onPressed: () {
                nextTest();
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
                          description: currentTest.description,
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
