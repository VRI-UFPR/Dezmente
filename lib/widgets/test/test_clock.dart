import 'package:circular_widgets/circular_widgets.dart';
import 'package:flutter/material.dart';
import 'package:dezmente/super/supertest.dart';

class TesteClock extends SuperTest {
  @override
  final description =
      "Coloque os números no lugar apropriado no relógio e indique o horário 14:50 com os ponteiros:";

  const TesteClock({Key? key}) : super(key: key);

  @override
  TesteClockState createState() => TesteClockState();
}

class TesteClockState extends SuperTestState {
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
                    return Draggable<String>(
                      feedback: Container(
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
                      ),
                      child: Container(
                        height: 20,
                        width: 20,
                        child: Center(
                          child: Text(
                            pointer,
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
                      ),
                      childWhenDragging: Container(
                        color: Colors.white,
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
                          // Can be any widget, preferably a circle
                          return _buildDragTarget();
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

  Widget _buildDragTarget() {
    return DragTarget<String>(
      builder: (context, List<String?> incoming, List accepted) {
        if (score.containsKey(context.hashCode)) {
          return Container(
            height: 20,
            width: 20,
            child: const Center(
              child: Text(
                "s",
                style: TextStyle(
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
      onWillAccept: (data) => data == data,
      onAccept: (data) {
        print(score);
        setState(() {
          score[context.hashCode] = data;
        });
      },
      onLeave: (data) => {},
    );
  }
}
