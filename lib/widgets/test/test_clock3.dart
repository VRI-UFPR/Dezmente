import 'dart:ffi';
import 'dart:ui' as ui;
import 'dart:math';

import 'package:circular_widgets/circular_widgets.dart';
import 'package:flutter/material.dart';
import 'package:dezmente/super/super.dart';

class TestClock3 extends SuperTest {
  @override
  get description =>
      "Coloque os números no lugar apropriado no relógio e indique o horário 14:50 com os ponteiros:";

  @override
  get title => "Test 8.2: Relogio";

  const TestClock3({Key? key}) : super(key: key);

  @override
  _TestClock3State createState() => _TestClock3State();
}

class _TestClock3State extends SuperTestState {
  @override
  erase() {
    setState(() {});
  }

  final List<TextEditingController> _textControllerPointers =
      List.generate(12, (i) => TextEditingController());

  @override
  Widget build(BuildContext context) {
    final double scrHfactor = MediaQuery.of(context).size.height / 640;
    final double scrWfactor = MediaQuery.of(context).size.width / 360;

    int _length = 12;

    return Scaffold(
      body: Container(
        padding: const EdgeInsets.fromLTRB(10, 15, 10, 0),
        height: 400 * scrHfactor,
        width: 400 * scrWfactor,
        child: Stack(
          children: [
            Center(
              child: Container(
                width: 380 * scrWfactor,
                height: 380 * scrHfactor,
                decoration: const BoxDecoration(
                  color: Colors.black,
                  shape: BoxShape.circle,
                ),
              ),
            ),
            LayoutBuilder(
              builder: (context, constraints) {
                return CircularWidgets(
                  itemsLength: _length,
                  itemBuilder: (context, index) {
                    return _buildPointer(_textControllerPointers[index]);
                  },
                  innerSpacing: 75 * scrHfactor,
                  radiusOfItem: 40 * scrHfactor,
                );
              },
            ),
            _buildClockHands(),
          ],
        ),
      ),
    );
  }

  Widget _buildPointer(_textControllerPointer) {
    final double scrHfactor = MediaQuery.of(context).size.height / 640;
    final double scrWfactor = MediaQuery.of(context).size.width / 360;
    //bool _color = false;

    return Container(
      width: 20 * scrWfactor,
      height: 20 * scrHfactor,
      decoration: const BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
      ),
      child: TextField(
        controller: _textControllerPointer,
        cursorColor: Colors.transparent,
        style: const TextStyle(
          fontFamily: "montserrat",
          fontSize: 15,
          fontWeight: FontWeight.w600,
          color: Colors.black,
        ),
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(6, 15, 0, 0),
          border: InputBorder.none,
          counterStyle: TextStyle(color: Colors.transparent),
        ),
        keyboardType: TextInputType.number,
        autocorrect: false,
        maxLength: 2,
        onSubmitted: (input) {
          setState(() {});
        },
      ),
    );
  }

  double angleHour = 0.0;
  double angleMinute = 1.0;

  Widget _buildClockHands() {
    //final double scrHfactor = MediaQuery.of(context).size.height / 640;
    final double scrWfactor = MediaQuery.of(context).size.width / 360;

    return Stack(
      children: [
        GestureDetector(
          onPanUpdate: (details) {
            setState(() {
              angleMinute = _panHandler(details);
            });
          },
          child: _clockHand(angleMinute, 115 * scrWfactor),
        ),
        GestureDetector(
          onPanUpdate: (details) {
            setState(() {
              angleHour = _panHandler(details);
            });
          },
          child: _clockHand(angleHour, 60 * scrWfactor),
        ),
      ],
    );
  }

  Widget _clockHand(double angle, double size) {
    return RotatedBox(
      quarterTurns: 2,
      child: Transform.rotate(
        angle: angle,
        child: Transform.translate(
          offset: Offset(0, size / 2),
          child: Center(
            child: Container(
              height: size,
              width: 4,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(32),
              ),
            ),
          ),
        ),
      ),
    );
  }

  double _panHandler(DragUpdateDetails d) {
    double x = 150 * MediaQuery.of(context).size.width / 360;

    return atan2((d.localPosition.dx - x), (x - d.localPosition.dy));
  }
}
