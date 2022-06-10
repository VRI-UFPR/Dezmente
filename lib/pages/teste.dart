import 'package:dezmente/super/super.dart';
import 'package:dezmente/widgets/test/test_abstraction_2.dart';
import 'package:dezmente/widgets/debug_select_test.dart';
import 'package:dezmente/widgets/test/test_abstraction.dart';
import 'package:dezmente/widgets/test/test_animals.dart';
import 'package:dezmente/widgets/test/test_atention.dart';
import 'package:dezmente/widgets/test/test_clock.dart';
import 'package:dezmente/widgets/test/test_conection.dart';
import 'package:dezmente/widgets/test/test_cube.dart';
import 'package:dezmente/widgets/test/test_memory.dart';
import 'package:dezmente/widgets/test/test_space_orientation.dart';
import 'package:dezmente/widgets/test/test_memory_questions.dart';
import 'package:dezmente/widgets/test/test_memory_text.dart';
import 'package:dezmente/widgets/test/test_vigilance.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

  void nextTest({int i = -1}) async {
    if (_globalKey.currentState?.getData().code == Code.next || i != -1) {
      if (i != -1 || index < _testes.length - 1) {
        setState(() {
          i == -1 ? index++ : index = i;
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
    "Test Memory Text",
    "Test Memory Questions",
    "Test Vigilance",
    "Test Clock",
    "Test Abstraction",
    "Test Abstraction 2",
    "Test Memory Check",
    "Test Atention",
    "Test Space Orientation"
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
      () => TestMemoryText(
            key: _globalKey,
          ),
      () => TestMemoryQuestions(
            key: _globalKey,
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
      () => TestAbstraction2(
            key: _globalKey,
          ),
      () => TestMemory(
            key: _globalKey,
            editMode: true,
          ),
      () => TestAtention(
            key: _globalKey,
          ),
      () => TestSpaceOrient(
            key: _globalKey,
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
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
                                nextTest(i: i);
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
