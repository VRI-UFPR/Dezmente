import 'package:dezmente/services/results.dart';
import 'package:flutter/material.dart';

abstract class SuperTest extends StatefulWidget {
  @override
  const SuperTest({Key? key}) : super(key: key);

  final title = "";
  final description = "";
  final needErase = true;
}

abstract class SuperTestState<T extends StatefulWidget> extends State<T> {
  TestResults data = TestResults(timeStamp: 0);

  @mustCallSuper
  TestResults getData() {
    data.timeStamp = DateTime.now().millisecondsSinceEpoch - data.timeStamp;
    return data;
  }

  @mustCallSuper
  init() {
    data.timeStamp = DateTime.now().millisecondsSinceEpoch;
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
