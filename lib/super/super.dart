import 'package:flutter/material.dart';

abstract class SuperTest extends StatefulWidget {
  // final ValueGetter<TestData> getData;

  @override
  const SuperTest({Key? key}) : super(key: key);

  final description = "";
}

abstract class SuperTestState<T extends StatefulWidget> extends State<T> {
  TestData data = TestData(timeStamp: 0);

  TestData getData() {
    data.timeStamp = DateTime.now().millisecondsSinceEpoch - data.timeStamp;
    return data;
  }

  init() {
    data.timeStamp = DateTime.now().millisecondsSinceEpoch;
  }

  @factory
  erase();

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

enum Code { next, stay }

class TestData {
  TestData({required this.timeStamp, this.code = Code.next});
  int timeStamp;
  Code code;
}
