import 'package:dezmente/pages/common/super.dart';
import 'package:dezmente/services/results.dart';
import 'package:dezmente/widgets/help.dart';
import 'package:flutter/cupertino.dart';
import 'package:dezmente/widgets/test/testes_imports.dart';

class TestCtrl {
  static TestCtrl? _testCtrl;
  late SuperTest? _currentTest;
  late List<SuperTest> _testList;
  late BuildContext _context;
  int index = 0;
  GlobalObjectKey<SuperTestState> _globalKey = const GlobalObjectKey("key");
  final _results = <TestResults>[];

  get description => _currentTest!.description;
  get needErase => _currentTest!.needErase;
  get testList => _testList;

  set currentTest(SuperTest c) {
    _currentTest = c;
  }

  set globalkey(GlobalObjectKey<SuperTestState> _globalKey) {
    this._globalKey = _globalKey;
  }

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
          nextTest(_context);
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

  void nextTest(BuildContext context, {int i = -1}) async {
    TestResults? testResults = _globalKey.currentState?.getData();
    if (testResults?.code == Code.next || i != -1) {
      if (i != -1 || index < _testList.length - 1) {
        testResults != null ? _results.add(testResults) : null;

        i == -1 ? index++ : index = i;
        currentTest = _testList[index];

        await Navigator.of(context).push(
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

  Widget build(BuildContext context) {
    _context = context;
    return _currentTest ??
        const Center(
          child: Text("Something Wrong Happened"),
        );
  }

  static TestCtrl getInstace() {
    _testCtrl ??= TestCtrl();
    return _testCtrl!;
  }
}
