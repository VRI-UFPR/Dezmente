import 'package:dezmente/pages/common/super.dart';
import 'package:dezmente/services/results.dart';
import 'package:dezmente/widgets/debug_select_test.dart';
import 'package:dezmente/widgets/help.dart';
import 'package:flutter/cupertino.dart';
import 'package:dezmente/widgets/test/testes_imports.dart';

class TestCtrl {
  int currentTestIndex = 0;
  static TestCtrl? _testCtrl;
  late SuperTest? _currentTest;
  late List<SuperTest> _testList;
  late VoidCallback _setState;

  final TestResults _testResults = TestResults();

  final GlobalObjectKey<SuperTestState> _globalKey =
      const GlobalObjectKey("key");

  String get description => _currentTest!.description;
  bool get needErase => _currentTest!.needErase;
  SuperTestState<SuperTest>? get state => _globalKey.currentState;
  List<SuperTest> get testList => _testList;

  set setCallback(VoidCallback c) {
    _setState = c;
  }

  set currentTest(SuperTest c) {
    _currentTest = c;
    _setState();
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
    //Por causa que isso é no construtor existe um erro usando set currentTest que usa a função _setState que pode n estar estanciada mesmo lendo late oq cria um erro
    //Por motivos a falta do setState aqui não causa o app ficar com a tela errada porem seria bom o uso do setState, porem vc teria que garantir o late do _setState
    _currentTest = _testList.first;
  }

  void debugMode() {
    currentTest = DebugSelectTest(
      key: _globalKey,
      testList: _testList,
      onTestSelected: (i) {
        TestCtrl.instance.nextTestDebug(i);
      },
    );
  }

  pushTestHelpPage() async {
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
  }

  void nextTestDebug(int i) async {
    currentTestIndex = i;
    currentTest = _testList[i];
    await pushTestHelpPage();
    init();
  }

  void nextTest() async {
    //Recebe os resultados do teste
    Result? testResults = state?.getData();

    //Se o codigo do teste for next(no caso onde o teste ja "acabou") ou se chamada for feita pelo debugMode
    if (testResults?.code == Code.next) {
      if (testResults != null) {
        _testResults.addResult(testResults);
      }
      //Se possui ainda outro teste para ser feito
      if (currentTestIndex < _testList.length - 1) {
        currentTestIndex++;
        currentTest = _testList[currentTestIndex];

        //Da push da tela de help do inicio do teste e apos o user der começar/a tela fechar ele inicia o teste
        await pushTestHelpPage();
        init();
      } else {
        // Caso os testes tenham acabado
        _testResults.submit();
      }
    }
  }

  Widget build() {
    return _currentTest ??
        const Center(
          child: Text("Error 589"),
        );
  }

  static TestCtrl get instance {
    _testCtrl ??= TestCtrl();
    return _testCtrl!;
  }
}
