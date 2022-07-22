import 'package:dezmente/pages/common/super.dart';
import 'package:flutter/cupertino.dart';

class TestCtrl extends State {
  static TestCtrl? _testCtrl;
  SuperTest? currentTest;

  TestCtrl();

  @override
  Widget build(BuildContext context) {
    return currentTest ??
        const Center(
          child: Text("Something Wrong Happened"),
        );
  }

  static TestCtrl getInstace() {
    _testCtrl ??= TestCtrl();

    return _testCtrl!;
  }
}
