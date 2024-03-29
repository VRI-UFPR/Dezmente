import 'package:dezmente/services/models/result_model.dart';
import 'package:dezmente/common/super.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class TestAbstraction2 extends SuperTest {
  @override
  get description => "Selecione a imagem que completa a figura";

  @override
  get audioFile => "teste-09.mp3";

  @override
  get title => "Teste 9: Abstração";

  @override
  get needErase => false;

  const TestAbstraction2({Key? key}) : super(key: key);

  @override
  TestAbstraction2State createState() => TestAbstraction2State();
}

class TestAbstraction2State extends SuperTestState<TestAbstraction2> {
  @override
  erase() {}

  @override
  Result getData() {
    data.testId = 9;
    data.score = selected == 2 ? 1 : 0;
    data.responses = {"slice": selected};
    data.testType = TestTag.vse;
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
            Container(
              padding: const EdgeInsets.all(20),
              margin: const EdgeInsets.only(bottom: 75),
              height: height * 0.3,
              width: width * 0.8,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black,
                  width: 5,
                ),
              ),
              child: SvgPicture.asset('assets/images/slices_new/target.svg',
                  width: width * 0.2, height: height * 0.2),
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
          padding: selected == index ? const EdgeInsets.all(15) : const EdgeInsets.all(10),
          decoration: index == selected
              ? BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  border: Border.all(color: const Color(0xffF72585), width: 4),
                )
              : BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                ),
          child: SvgPicture.asset('assets/images/slices_new/slice$index.svg'),
        ),
      );
}
