import 'dart:math';
import 'package:circular_widgets/circular_widgets.dart';
import 'package:dezmente/common/super.dart';
import 'package:dezmente/services/models/result_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class TestClock2 extends SuperTest {
  @override
  get description =>
      "Coloque os números no lugar apropriado no relógio e indique o horário 14:50 com os ponteiros:";

  @override
  get audioFile => "teste-03.mp3";

  @override
  get title => "Teste 3: Relógio";

  const TestClock2({Key? key}) : super(key: key);

  @override
  _TestClock2State createState() => _TestClock2State();
}

class _TestClock2State extends SuperTestState {
  final Map<int, int> _score = {};
  final List<int> _pointers = [1, 9, 50, 12, 4, 45, 30, 3, 6];

  final _minuteHand = 83;
  final _hourHand = 55;
  final _dragTargetRadius = 55;
  final _innerClockSpacing = 40;

  double _angleHour = 0.0;
  double _angleMinute = 1.0;

  @override
  Result getData() {
    data.testId = 3;
    data.score = mapEquals(_score, {0: 12, 1: 3, 2: 6, 3: 9}) ? 1 : 0;

    int h = _radToHour(_angleHour);
    int m = _radToMinute(_angleMinute);

    if ((h == 2) && (m <= 55) && (m >= 45)) {
      data.score += 1;
    }

    data.responses = {
      "sequence": _score.toString(),
      "hour": h,
      "minute": m,
    };

    print("${h} ${m}");

    return super.getData();
  }

  int _radToHour(double _rad) {
    if ((_rad >= 0) && (_rad <= pi)) {
      return (_rad * 6 / pi).floor();
    } else if ((_rad < 0) && (_rad >= -pi)) {
      return (_rad * 6 / pi).floor() + 12;
    }

    return 0;
  }

  int _radToMinute(double _rad) {
    if ((_rad >= 0) && (_rad <= pi)) {
      return (_rad * 30 / pi).floor();
    } else if ((_rad < 0) && (_rad >= -pi)) {
      return (_rad * 30 / pi).floor() + 60;
    }

    return 0;
  }

  @override
  erase() {
    setState(() {
      _score.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    final double scrHfactor = MediaQuery.of(context).size.height / 640;
    final double scrWfactor = MediaQuery.of(context).size.width / 360;

    int _length = _pointers.length;

    return Scaffold(
      body: Container(
        padding: const EdgeInsets.fromLTRB(10, 15, 10, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Center(
              child: SizedBox(
                child: GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _length,
                    primary: true,
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 2,
                      crossAxisSpacing: 3,
                      crossAxisCount: _length ~/ 3,
                      mainAxisSpacing: 5,
                    ),
                    itemBuilder: (_, i) {
                      return IgnorePointer(
                        ignoring: _score.containsValue(_pointers[i]),
                        child: Opacity(
                          opacity: _score.containsValue(_pointers[i]) ? 0 : 1,
                          child: Draggable<int>(
                            feedbackOffset: Offset.fromDirection(-2.0),
                            data: _pointers[i],
                            feedback: _buildPointer(_pointers[i]),
                            child: _buildPointer(_pointers[i]),
                            childWhenDragging: const Opacity(
                              opacity: 0,
                            ),
                          ),
                        ),
                      );
                    }),
              ),
            ),
            SizedBox(
              height: 300 * scrHfactor,
              width: 400 * scrWfactor,
              child: Stack(
                children: [
                  Center(
                    child: Container(
                      width: 390 * scrWfactor,
                      height: 390 * scrHfactor,
                      decoration: const BoxDecoration(
                        color: Colors.black,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  LayoutBuilder(
                    builder: (context, constraints) {
                      return CircularWidgets(
                        itemsLength: 4,
                        itemBuilder: (context, index) {
                          return _buildDragTarget(index);
                        },
                        innerSpacing: _innerClockSpacing * scrHfactor,
                        radiusOfItem: _dragTargetRadius * scrHfactor,
                      );
                    },
                  ),
                  _buildClockHands(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDragTarget(index) {
    return DragTarget<int>(
      builder: (context, incoming, accepted) {
        final double scrHfactor = MediaQuery.of(context).size.height / 640;
        final double scrWfactor = MediaQuery.of(context).size.width / 360;

        if (_score.containsKey(index)) {
          return Container(
            height: 30 * scrHfactor,
            width: 30 * scrWfactor,
            child: Center(
              child: Text(
                "${_score[index]}",
                style: const TextStyle(
                  fontSize: 22,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            decoration: const BoxDecoration(
              color: Colors.brown,
              shape: BoxShape.circle,
            ),
          );
        } else {
          return Container(
            width: 30 * scrWfactor,
            height: 30 * scrHfactor,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
          );
        }
      },
      onWillAccept: (data) => true,
      onAccept: (data) {
        setState(() {
          _score[index] = data;
        });
      },
      onLeave: (data) => {},
    );
  }

  Widget _buildPointer(pointer) {
    final double scrHfactor = MediaQuery.of(context).size.height / 640;
    final double scrWfactor = MediaQuery.of(context).size.width / 360;
    return Container(
      height: 55 * scrHfactor,
      width: 55 * scrWfactor,
      child: Center(
        child: Text(
          pointer.toString(),
          style: const TextStyle(
            decoration: TextDecoration.none,
            fontSize: 22,
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      decoration: const BoxDecoration(
        color: Colors.brown,
        shape: BoxShape.circle,
      ),
    );
  }

  Widget _buildClockHands() {
    //final double scrHfactor = MediaQuery.of(context).size.height / 640;
    final double scrWfactor = MediaQuery.of(context).size.width / 360;

    return Stack(
      children: [
        GestureDetector(
          onPanUpdate: (details) {
            setState(() {
              _angleMinute = _panHandler(details);
            });
          },
          child: _clockHand(_angleMinute, _minuteHand * scrWfactor),
        ),
        GestureDetector(
          onPanUpdate: (details) {
            setState(() {
              _angleHour = _panHandler(details);
            });
          },
          child: _clockHand(_angleHour, _hourHand * scrWfactor),
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
              color: Colors.transparent,
              height: size,
              width: 35,
              child: Center(
                child: Container(
                  height: size,
                  width: 10,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(32),
                  ),
                ),
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
