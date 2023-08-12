import 'package:dezmente/services/models/result_model.dart';
import 'package:dezmente/services/results.dart';
import 'package:flutter/material.dart';

abstract class SuperTest extends StatefulWidget {
  @override
  const SuperTest({Key? key}) : super(key: key);

  final title = "";
  final description = "";
  final needErase = true;
  final needInfo = true;
  final audioFile = "";
  final continueButtonText = "Concluir";
}

abstract class SuperTestState<T extends SuperTest> extends State<T> {
  Result data = Result(timeSpent: 0, testType: TestTag.none);

  @mustCallSuper
  Result getData() {
    if (data.code == Code.next) {
      data.testTitle = widget.title;
      data.timeSpent = DateTime.now().millisecondsSinceEpoch - data.timeSpent!;
    }
    return data;
  }

  @mustCallSuper
  init() {
    data.testTitle = widget.title;
    data.timeSpent = DateTime.now().millisecondsSinceEpoch;
  }

  @factory
  erase();

  // @override
  // void initState() {
  //   init();
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
