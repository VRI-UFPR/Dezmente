import 'package:circular_widgets/circular_widgets.dart';
import 'package:flutter/material.dart';
import 'package:dezmente/super/super.dart';

class TestClock extends SuperTest {
  @override
  final description =
      "Coloque os números no lugar apropriado no relógio e indique o horário 14:50 com os ponteiros:";

  const TestClock({Key? key}) : super(key: key);

  @override
  TestClockState createState() => TestClockState();
}

class TestClockState extends SuperTestState {
  Map<int, int> score = {};

  @override
  erase() {
    print(score);
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
                child: GridView.count(
                  primary: true,
                  shrinkWrap: true,
                  childAspectRatio: 1.3,
                  crossAxisSpacing: 7,
                  crossAxisCount: 6,
                  mainAxisSpacing: 9,
                  children: <Widget>[
                    for (var i = 1; i <= _length; i++)
                      IgnorePointer(
                        ignoring: score.containsValue(i),
                        child: Opacity(
                          opacity: score.containsValue(i) ? 0 : 1,
                          child: Draggable<int>(
                            data: i,
                            feedback: _buildPointer(i),
                            child: _buildPointer(i),
                            childWhenDragging: const Opacity(
                              opacity: 0,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
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
}
