import 'package:dezmente/services/results.dart';
import 'package:dezmente/services/super.dart';
import 'package:dezmente/widgets/debug_select_test.dart';
import 'package:dezmente/widgets/test/testes_imports.dart';
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
  final _results = <TestResults>[];
  late SuperTest currentTest;
  int index = 0;

  void nextTest({int i = -1}) async {
    TestResults? testResults = _globalKey.currentState?.getData();
    if (testResults?.code == Code.next || i != -1) {
      if (i != -1 || index < _testes.length - 1) {
        testResults != null ? _results.add(testResults) : null;

        setState(() {
          i == -1 ? index++ : index = i;
          currentTest = _testes[index];
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

  late final List<SuperTest> _testes;

  @override
  void initState() {
    super.initState();

    _testes = [
      TestConection(
        key: _globalKey,
      ),
      TestCube(
        key: _globalKey,
      ),
      TestAnimals(
        key: _globalKey,
      ),
      TestMemory(
        key: _globalKey,
        editMode: 0,
      ),
      TestMemory(
        key: _globalKey,
        editMode: 1,
      ),
      TestMemoryText(
        key: _globalKey,
      ),
      TestMemoryQuestions(
        key: _globalKey,
      ),
      TestVigilance(
        key: _globalKey,
        completeOnFinalChar: () {
          nextTest();
        },
      ),
      TestClock(
        key: _globalKey,
      ),
      TestAbstraction(
        key: _globalKey,
      ),
      TestSimilarity(
        key: _globalKey,
      ),
      TestAbstraction2(
        key: _globalKey,
      ),
      TestMemory(
        key: _globalKey,
        editMode: 2,
      ),
      TestAtention(
        key: _globalKey,
      ),
      TestSpaceOrient(
        key: _globalKey,
      ),
    ];

    currentTest = _testes.first;

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
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.bottom]);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 17),
        child: currentTest,
      ),
      backgroundColor: const Color(0xffffffff),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.fromLTRB(17, 0, 17, 12),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            color: const Color(0xff569DB3)),
        child: Row(
          children: [
            _buildBottomBarButton(Icons.question_mark_outlined, "Informações",
                () {
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
            }, null),
            if (currentTest.needErase)
              _buildBottomBarButton(Icons.backspace, "Apagar", () {
                setState(
                  () {
                    _globalKey.currentState?.erase();
                  },
                );
              }, null),
            _buildBottomBarButton(
              Icons.check_circle_outline,
              "Concluir",
              () {
                nextTest();
              },
              !debugMode
                  ? null
                  : () {
                      setState(
                        () {
                          currentTest = DebugSelectTest(
                            testList: _testes,
                            onTestSelected: (i) {
                              setState(() {
                                nextTest(i: i);
                              });
                            },
                          );
                        },
                      );
                    },
            )
          ],
        ),
      ),
    );
  }

  Widget _buildBottomBarButton(IconData icon, String label, dynamic onPressed,
          dynamic onLongPress) =>
      Expanded(
        child: TextButton(
          onPressed: onPressed,
          onLongPress: onLongPress,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 6),
            decoration: BoxDecoration(
                color: const Color(0xffB7D5DF),
                borderRadius: BorderRadius.circular(6)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Icon(icon, color: const Color(0xff060607)),
                Text(
                  label,
                  style: const TextStyle(color: Color(0xff060607)),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      );
}
