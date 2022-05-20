import 'dart:ui' as ui;
import 'dart:math';

import 'package:circular_widgets/circular_widgets.dart';
import 'package:flutter/material.dart';
import 'package:dezmente/super/super.dart';

class TestClock extends SuperTest {
  @override
  final description =
      "Coloque os números no lugar apropriado no relógio e indique o horário 14:50 com os ponteiros:";

  const TestClock({Key? key}) : super(key: key);

  @override
  _TestClockState createState() => _TestClockState();
}

class _TestClockState extends SuperTestState {
  Map<int, int> score = {};

  @override
  erase() {
    setState(() {
      score.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    final double scrHfactor = MediaQuery.of(context).size.height / 640;
    final double scrWfactor = MediaQuery.of(context).size.width / 360;

    int _length = 12;

    return Scaffold(
      body: Container(
        padding: const EdgeInsets.fromLTRB(10, 15, 10, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Center(
              child: SizedBox(
                height: 135 * scrHfactor,
                width: 400 * scrWfactor,
                child: GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _length,
                    primary: true,
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: 1.3,
                        crossAxisSpacing: 7,
                        crossAxisCount: _length ~/ 2,
                        mainAxisSpacing: 9),
                    itemBuilder: (_, i) {
                      return IgnorePointer(
                        ignoring: score.containsValue(i + 1),
                        child: Opacity(
                          opacity: score.containsValue(i + 1) ? 0 : 1,
                          child: Draggable<int>(
                            data: i + 1,
                            feedback: _buildPointer(i + 1),
                            child: _buildPointer(i + 1),
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
              height: 400 * scrHfactor,
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
                        itemsLength: _length,
                        itemBuilder: (context, index) {
                          return _buildDragTarget(index);
                        },
                        innerSpacing: 75 * scrWfactor,
                        radiusOfItem: 40 * scrHfactor,
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

        if (score.containsKey(index)) {
          return Container(
            height: 20 * scrHfactor,
            width: 20 * scrWfactor,
            child: Center(
              child: Text(
                "${score[index]}",
                style: const TextStyle(
                  fontSize: 18,
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
            width: 20 * scrWfactor,
            height: 20 * scrHfactor,
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
          score[index] = data;
        });
        print(score);
      },
      onLeave: (data) => {},
    );
  }

  Widget _buildPointer(pointer) {
    final double scrHfactor = MediaQuery.of(context).size.height / 640;
    final double scrWfactor = MediaQuery.of(context).size.width / 360;
    return Container(
      height: 40 * scrHfactor,
      width: 40 * scrWfactor,
      child: Center(
        child: Text(
          pointer.toString(),
          style: const TextStyle(
            decoration: TextDecoration.none,
            fontSize: 18,
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
              angleMinute += _panHandler(details);
            });
          },
          child: _clockHand(angleMinute, 115 * scrWfactor),
        ),
        GestureDetector(
          onPanUpdate: (details) {
            setState(() {
              angleHour += _panHandler(details);
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
    /// Pan location on the wheel
    bool onTop = d.localPosition.dy <= radius;
    bool onLeftSide = d.localPosition.dx <= radius;
    bool onRightSide = !onLeftSide;
    bool onBottom = !onTop;

    /// Pan movements
    bool panUp = d.delta.dy <= 0.0;
    bool panLeft = d.delta.dx <= 0.0;
    bool panRight = !panLeft;
    bool panDown = !panUp;

    /// Absoulte change on axis
    double yChange = d.delta.dy.abs();
    double xChange = d.delta.dx.abs();

    /// Directional change on wheel
    double verticalRotation = (onRightSide && panDown) || (onLeftSide && panUp)
        ? yChange
        : yChange * -1;

    double horizontalRotation =
        (onTop && panRight) || (onBottom && panLeft) ? xChange : xChange * -1;

    // Total computed change
    double rotationalChange =
        (verticalRotation + horizontalRotation) * (d.delta.distance);

    // Move the page view scroller
    return rotationalChange * 0.05;
  }
}

// class Arrow extends CustomPainter {
//   final double height;

//   const Arrow(
//     this.height,
//   );

//   @override
//   void paint(Canvas canvas, Size size) {
//     final paint = Paint()
//       ..color = Colors.white
//       ..strokeWidth = 5;

//     canvas.drawLine(
//       Offset(size.width * 1 / 2 - 7, size.height * 1 / 2 - 7),
//       Offset((size.width * 1 / 2) + height, (size.height * 1 / 2) + height),
//       paint,
//     );
//   }

//   @override
//   bool shouldRepaint(CustomPainter oldDelegate) => true;
// }

// class RPSCustomPainter extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//     Paint paint0 = Paint()
//       ..color = const Color.fromARGB(255, 33, 150, 243)
//       ..style = PaintingStyle.fill
//       ..strokeWidth = 1;
//     paint0.shader = ui.Gradient.linear(
//         Offset(size.width * 0.42, size.height * 0.46),
//         Offset(size.width * 0.91, size.height * 0.46),
//         [const Color(0xffffffff), const Color(0xffffffff)],
//         [0.00, 1.00]);

//     Path path0 = Path();
//     path0.moveTo(size.width * 0.4166667, size.height * 0.4166667);
//     path0.lineTo(size.width * 0.4166667, size.height * 0.4983333);
//     path0.lineTo(size.width * 0.8339083, size.height * 0.4990500);
//     path0.lineTo(size.width * 0.8333333, size.height * 0.5846333);
//     path0.lineTo(size.width * 0.9066667, size.height * 0.4583333);
//     path0.lineTo(size.width * 0.8333333, size.height * 0.3316667);
//     path0.lineTo(size.width * 0.8333333, size.height * 0.4159333);
//     path0.lineTo(size.width * 0.4166667, size.height * 0.4166667);
//     path0.close();

//     canvas.drawPath(path0, paint0);
//   }

//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) {
//     return true;
//   }
// }
