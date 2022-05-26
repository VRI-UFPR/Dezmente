import 'package:dezmente/super/super.dart';
import 'package:dezmente/widgets/test/test_abstraction_2.dart';
import 'package:dezmente/widgets/test/test_animals.dart';
import 'package:dezmente/widgets/test/test_clock.dart';
import 'package:dezmente/widgets/test/test_conection.dart';
import 'package:dezmente/widgets/test/test_cube.dart';
import 'package:flutter/material.dart';

import 'package:dezmente/widgets/help.dart';
import 'package:dezmente/widgets/debugSelectTest.dart';

import 'package:dezmente/widgets/test/test_abstraction.dart';
import 'package:dezmente/widgets/test/test_memory.dart';

class Teste extends StatefulWidget {
  const Teste({Key? key}) : super(key: key);

  @override
  State<Teste> createState() => _TesteState();
}

const debugMode = true;

SuperTest currentTest = _testes.first();
GlobalObjectKey<SuperTestState> _globalKey = const GlobalObjectKey("key");

int index = 0;

List<Function> _testes = [
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
  () => TestClock(
        key: _globalKey,
      ),
  () => TestAbstraction(
        key: _globalKey,
      ),
  () => TesteAbstraction2(
        key: _globalKey,
      ),
  () => TestMemory(
        key: _globalKey,
        editMode: true,
      ),
];

List<String> _testeNames = [
  "Test Conection",
  "Test Cube",
  "Test Animals",
  "Test Memory Memorize",
  "Test Clock",
  "Test Abstraction",
  "Test Memory Check",
];

class _TesteState extends State<Teste> {
  @override
  void initState() {
    super.initState();
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
                setState(
                  () async {
                    if (_globalKey.currentState?.getData().code == Code.next) {
                      if (index < _testes.length - 1) {
                        index++;
                        currentTest = _testes[index]();

                        await Navigator.of(context).push(
                          PageRouteBuilder(
                            opaque: false,
                            pageBuilder:
                                (context, animation, secondaryAnimation) =>
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
                  },
                );
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
