import 'package:dezmente/super/super.dart';
import 'package:flutter/material.dart';

class DebugSelectTest extends SuperTest {
  final List<String> testList;
  final ValueSetter<int> onTestSelected;

  const DebugSelectTest(
      {Key? key, required this.testList, required this.onTestSelected})
      : super(key: key);

  @override
  SuperTestState createState() => DebugSelectTestState();
}

class DebugSelectTestState extends SuperTestState<DebugSelectTest> {
  @override
  erase() {}

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: widget.testList.length,
        itemBuilder: (_, int index) {
          return ListTile(
              onTap: () => widget.onTestSelected(index),
              trailing: const SizedBox.shrink(),
              title: Text(widget.testList[index]));
        });
  }
}
