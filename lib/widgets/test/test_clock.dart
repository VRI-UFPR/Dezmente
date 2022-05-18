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
  List pointers = [
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '10',
    '11',
    '12'
  ];

  Map<int, String> score = {};

  @override
  erase() {
    print(score);
    setState(() {
      score.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeightFactor = MediaQuery.of(context).size.height / 640;
    final double screenWidthFactor = MediaQuery.of(context).size.width / 360;

    int length = 12;

    return Scaffold(
      body: Container(
        padding: const EdgeInsets.fromLTRB(10, 15, 10, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Center(
              child: SizedBox(
                height: 135 * screenHeightFactor,
                width: 400 * screenWidthFactor,
                child: GridView.count(
                  primary: true,
                  shrinkWrap: true,
                  childAspectRatio: 1.3,
                  crossAxisSpacing: 7,
                  crossAxisCount: 6,
                  mainAxisSpacing: 9,
                  children: pointers.map<Widget>((pointer) {
                    return IgnorePointer(
                      ignoring: score.containsValue(pointer),
                      child: Opacity(
                        opacity: score.containsValue(pointer) ? 0 : 1,
                        child: Draggable<String>(
                          data: pointer,
                          feedback: _buildPointer(pointer),
                          child: _buildPointer(pointer),
                          childWhenDragging: const Opacity(
                            opacity: 0,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
            SizedBox(
              height: 400 * screenHeightFactor,
              width: 400 * screenWidthFactor,
              child: Stack(
                children: [
                  Center(
                    child: Container(
                      width: 390 * screenWidthFactor,
                      height: 390 * screenHeightFactor,
                      decoration: const BoxDecoration(
                        color: Colors.black,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  LayoutBuilder(
                    builder: (context, constraints) {
                      return CircularWidgets(
                        itemsLength: length,
                        itemBuilder: (context, index) {
                          return _buildDragTarget(index);
                        },
                        innerSpacing: 75 * screenWidthFactor,
                        radiusOfItem: 40 * screenHeightFactor,
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
    return DragTarget<String>(
      builder: (context, incoming, accepted) {
        if (score.containsKey(index)) {
          return Container(
            height: 20,
            width: 20,
            child: Center(
              child: Text(
                score[index] ?? " ",
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
            width: 20,
            height: 20,
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
    return Container(
      height: 32,
      width: 32,
      child: Center(
        child: Text(
          pointer,
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
