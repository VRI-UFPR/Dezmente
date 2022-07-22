import 'package:dezmente/pages/common/super.dart';
import 'package:dezmente/services/results.dart';
import 'package:dezmente/widgets/debug_select_test.dart';
import 'package:dezmente/widgets/help.dart';
import 'package:flutter/cupertino.dart';
import 'package:dezmente/widgets/test/testes_imports.dart';

class TestCtrl {
  static TestCtrl? _testCtrl;
  late SuperTest? _currentTest;
  late List<SuperTest> _testList;

  int index = 0;
  final GlobalObjectKey<SuperTestState> _globalKey =
      const GlobalObjectKey("key");
  final _results = <TestResults>[];

  String get description => _currentTest!.description;
  bool get needErase => _currentTest!.needErase;
  List<SuperTest> get testList => _testList;

  set currentTest(SuperTest c) {
    _currentTest = c;
  }

  void debugMode() {
    _currentTest = DebugSelectTest(
      testList: _testList,
      onTestSelected: (i) {
        TestCtrl.instance.nextTest(i: i);
      },
    );
  }

  init() => _globalKey.currentState?.init();

  erase() => _globalKey.currentState?.erase();

  TestCtrl() {
    _testList = [
      TestClock2(
        key: _globalKey,
      ),
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
    _currentTest = _testList.first;
  }

  void nextTest({int i = -1}) async {
    TestResults? testResults = _globalKey.currentState?.getData();
    if (testResults?.code == Code.next || i != -1) {
      if (i != -1 || index < _testList.length - 1) {
        testResults != null ? _results.add(testResults) : null;

        i == -1 ? index++ : index = i;
        currentTest = _testList[index];

        await Navigator.of(_globalKey.currentContext!).push(
          PageRouteBuilder(
            opaque: false,
            pageBuilder: (context, animation, secondaryAnimation) =>
                HelpTemplateButton(
              callback: () {
                Navigator.pop(context);
              },
              title: "",
              description: _currentTest!.description,
              buttonText: "Começar",
            ),
          ),
        );
        _globalKey.currentState?.init();
      }
    }
  }

  Widget build() {
    return _currentTest ??
        const Center(
          child: Text("Something Wrong Happened"),
        );
  }

  static TestCtrl get instance {
    _testCtrl ??= TestCtrl();
    return _testCtrl!;
  }
}
