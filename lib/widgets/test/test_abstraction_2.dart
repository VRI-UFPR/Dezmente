import 'package:dezmente/super/super.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class TestAbstraction2 extends SuperTest {
  @override
  get description => "Selecione a imagem que completa a figura";

  @override
  get title => "Test 10: Abstração 2";

  const TestAbstraction2({Key? key}) : super(key: key);

  @override
  TestAbstraction2State createState() => TestAbstraction2State();
}

class TestAbstraction2State extends SuperTestState<TestAbstraction2> {
  @override
  erase() {}

  @override
  TestData getData() {
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

    return Container(
        margin: EdgeInsets.fromLTRB(10, height * 0.1, 10, 10),
        child: Center(
          child: Column(children: [
            _buildUnselected(),
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

  Widget _buildUnselected() =>
      Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
        SvgPicture.asset('assets/images/slices/sliceComplete.svg'),
        SvgPicture.asset('assets/images/slices/sliceTarget.svg'),
      ]);

  Widget _buildSelectable(_, int index) => InkWell(
        onTap: () {
          setState(() {
            selected = index;
          });
        },
        child: Container(
          margin: const EdgeInsets.all(5),
          padding: index == selected
              ? const EdgeInsets.all(12)
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
