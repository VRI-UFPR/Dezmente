import 'package:flutter/material.dart';

abstract class SuperTest extends StatefulWidget {
  @override
  const SuperTest({Key? key}) : super(key: key);

  final description = "";
}

abstract class SuperTestState<T extends StatefulWidget> extends State<T> {
  TestData _data = TestData(timeStamp: 0);

  TestData getData() {
    _data.timeStamp = DateTime.now().millisecondsSinceEpoch - _data.timeStamp;
    return _data;
  }

  init() {
    _data.timeStamp = DateTime.now().millisecondsSinceEpoch;
  }

  @factory
  erase();

  @override
  void initState() {
    init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

enum Code { next, stay }

class TestData {
  TestData({required this.timeStamp, this.code = Code.stay});
  int timeStamp;
  Code code;
}
