import 'package:dezmente/services/super.dart';
import 'package:flutter/material.dart';

class TestSpaceOrient extends SuperTest {
  @override
  get description => "Responda as perguntas:";

  @override
  get title => "Test 13: Orientação Espacial";

  const TestSpaceOrient({Key? key}) : super(key: key);

  @override
  TestSpaceOrientState createState() => TestSpaceOrientState();
}

class TestSpaceOrientState extends SuperTestState {
  @override
  erase() {}

  final _cityController = TextEditingController();
  final _yearController = TextEditingController();
  final _monthController = TextEditingController();
  final _dayPeriods = ["Manhã", "Tarde", "Noite"];
  String? _dayPeriod;
  final _weekDays = [
    "Domingo",
    "Segunda",
    "Terça",
    "Quarta",
    "Quinta",
    "Sexta",
    "Sábado"
  ];
  String? _weekDay;
  final _monthList = [
    "Janeiro",
    "Feveiro",
    "Março",
    "Abril",
    "Maio",
    "Junho",
    "Julho",
    "Agosto",
    "Setembro",
    "Outubro",
    "Novembro",
    "Dezembro"
  ];
  String? _month;

  @override
  Widget build(BuildContext context) {
    final double scrHfactor = MediaQuery.of(context).size.height / 640;
    final double scrWfactor = MediaQuery.of(context).size.width / 360;

    return Center(
      child: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(top: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 16),
                width: 320 * scrWfactor,
                height: 80 * scrHfactor,
                child: TextField(
                  controller: _monthController,
                  cursorColor: Colors.transparent,
                  style: const TextStyle(
                    fontFamily: "montserrat",
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                  ),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    counterStyle: TextStyle(color: Colors.transparent),
                    fillColor: Color(0xff4cc9f0),
                    filled: true,
                    hintText: "Em que dia dos mês nós estamos?",
                    hintStyle: TextStyle(
                      fontFamily: "montserrat",
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  keyboardType: TextInputType.number,
                  autocorrect: false,
                  maxLength: 3,
                  onSubmitted: (input) {},
                ),
              ),
              SizedBox(
                width: 320 * scrWfactor,
                height: 80 * scrHfactor,
                child: TextField(
                  controller: _yearController,
                  cursorColor: Colors.transparent,
                  style: const TextStyle(
                    fontFamily: "montserrat",
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                  ),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    counterStyle: TextStyle(color: Colors.transparent),
                    fillColor: Color(0xff4cc9f0),
                    filled: true,
                    hintText: "Em que ano estamos?",
                    hintStyle: TextStyle(
                      fontFamily: "montserrat",
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  keyboardType: TextInputType.number,
                  autocorrect: false,
                  maxLength: 5,
                  onSubmitted: (input) {},
                ),
              ),
              SizedBox(
                width: 320 * scrWfactor,
                height: 80 * scrHfactor,
                child: TextField(
                  controller: _cityController,
                  cursorColor: Colors.transparent,
                  style: const TextStyle(
                    fontFamily: "montserrat",
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                  ),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    counterStyle: TextStyle(color: Colors.transparent),
                    fillColor: Color(0xff4cc9f0),
                    filled: true,
                    hintText: "Em que cidade você está?",
                    hintStyle: TextStyle(
                      fontFamily: "montserrat",
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  keyboardType: TextInputType.name,
                  autocorrect: false,
                  maxLength: 17,
                  onSubmitted: (input) {},
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 16),
                color: const Color(0xff4cc9f0),
                width: 320 * scrWfactor,
                height: 60 * scrHfactor,
                padding: const EdgeInsets.only(left: 10),
                child: DropdownButton<String>(
                  dropdownColor: const Color(0xff4cc9f0),
                  value: _month,
                  icon: const Icon(Icons.arrow_downward),
                  hint: const Text(
                    "Em que mês estamos?",
                    style: TextStyle(
                      fontFamily: "montserrat",
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  underline: const SizedBox(),
                  items: _monthList.map(buildMenuItem).toList(),
                  onChanged: (value) => setState(() {
                    _month = value;
                  }),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 16),
                color: const Color(0xff4cc9f0),
                width: 320 * scrWfactor,
                height: 60 * scrHfactor,
                padding: const EdgeInsets.only(left: 10),
                child: DropdownButton<String>(
                  dropdownColor: const Color(0xff4cc9f0),
                  value: _weekDay,
                  icon: const Icon(Icons.arrow_downward),
                  hint: const Text(
                    "Em dia da semana nós estamos?",
                    style: TextStyle(
                      fontFamily: "montserrat",
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  underline: const SizedBox(),
                  items: _weekDays.map(buildMenuItem).toList(),
                  onChanged: (value) => setState(() {
                    _weekDay = value;
                  }),
                ),
              ),
              Container(
                color: const Color(0xff4cc9f0),
                width: 320 * scrWfactor,
                height: 60 * scrHfactor,
                padding: const EdgeInsets.only(left: 10),
                child: DropdownButton<String>(
                  dropdownColor: const Color(0xff4cc9f0),
                  value: _dayPeriod,
                  icon: const Icon(Icons.arrow_downward),
                  hint: const Text(
                    "Em que período do dia nós estamos?",
                    style: TextStyle(
                      fontFamily: "montserrat",
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  underline: const SizedBox(),
                  items: _dayPeriods.map(buildMenuItem).toList(),
                  onChanged: (value) => setState(() {
                    _dayPeriod = value;
                  }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
        value: item,
        child: Text(
          item,
          style: const TextStyle(
            fontFamily: "montserrat",
            fontSize: 22,
            fontWeight: FontWeight.w600,
          ),
        ),
      );
}
