import 'package:dezmente/services/results.dart';
import 'package:dezmente/services/super.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class TestAbstraction2 extends SuperTest {
  @override
  get description => "Selecione a imagem que completa a figura";

  @override
  get audioFile => "teste-09.mp3";

  @override
  get title => "Test 9: Abstração 2";

  const TestAbstraction2({Key? key}) : super(key: key);

  @override
  TestAbstraction2State createState() => TestAbstraction2State();
}

class TestAbstraction2State extends SuperTestState<TestAbstraction2> {
  @override
  erase() {}

  @override
  TestResults getData() {
    if (selected == 4) {
      print("Acertou");
    } else {
      print("Errou");
    }
    return super.getData();
  }

  int selected = -1;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Container(
        margin: EdgeInsets.fromLTRB(10, height * 0.1, 10, 10),
        child: Center(
          child: Column(children: [
            _buildUnselected(width * 0.2, height * 0.2),
            SizedBox(
              height: height * 0.1,
            ),
            Expanded(
              child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3),
                itemCount: 6,
                itemBuilder: _buildSelectable,
              ),
            )
          ]),
        ));
  }

  Widget _buildUnselected(double width, double height) =>
      Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
        SvgPicture.asset('assets/images/slices/complete.svg',
            width: width, height: height),
        SvgPicture.asset('assets/images/slices/target.svg',
            width: width, height: height),
      ]);

  Widget _buildSelectable(_, int index) => InkWell(
        onTap: () {
          setState(() {
            selected = index;
          });
        },
        splashFactory: NoSplash.splashFactory,
        highlightColor: Colors.transparent,
        child: Container(
          margin: const EdgeInsets.all(5),
          padding: index == selected
              ? const EdgeInsets.all(14)
              : const EdgeInsets.all(10),
          decoration: index == selected
              ? BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  border: Border.all(color: Colors.amber, width: 4),
                )
              : BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                ),
          child: SvgPicture.asset('assets/images/slices/slice$index.svg'),
        ),
      );
}
