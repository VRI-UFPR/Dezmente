import 'package:flutter/cupertino.dart';

abstract class SuperTest extends StatefulWidget {
  @override
  const SuperTest({Key? key}) : super(key: key);

  final description = "";
}

abstract class SuperTestState<T extends StatefulWidget> extends State<T> {
  @factory
  erase();

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
