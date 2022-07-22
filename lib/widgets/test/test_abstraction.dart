import 'package:flutter/material.dart';
import 'package:dezmente/pages/common/super.dart';

class TestAbstraction extends SuperTest {
  @override
  get description => "Clique na imagem que não pertence ao grupo";

  @override
  get title => "Test 9: Abstração";

  const TestAbstraction({Key? key}) : super(key: key);

  @override
  _TestAbstractionState createState() => _TestAbstractionState();
}

enum Group { maca, banana, cafe }

class _TestAbstractionState extends SuperTestState {
  Group? _belongs;

  @override
  erase() {
    setState(() {
      _belongs = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.fromLTRB(10, 30, 10, 10),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _sizedRadioListTile(Group.maca, "assets/images/maca.jpg"),
              _sizedRadioListTile(Group.banana, "assets/images/bana.jpg"),
              _sizedRadioListTile(Group.cafe, "assets/images/cafe.jpg"),
            ],
          ),
        ),
      ),
    );
  }

  Widget _sizedRadioListTile(Group value, asset) {
    final double scrHfactor = MediaQuery.of(context).size.height / 640;
    final double scrWfactor = MediaQuery.of(context).size.width / 360;

    return SizedBox(
      height: 130 * scrHfactor,
      width: 500 * scrWfactor,
      child: RadioListTile(
        value: value,
        groupValue: _belongs,
        title: Image.asset(
          asset,
          filterQuality: FilterQuality.high,
          fit: BoxFit.fill,
        ),
        dense: true,
        onChanged: (Group? value) {
          setState(() {
            _belongs = value;
          });
        },
      ),
    );
  }
}
