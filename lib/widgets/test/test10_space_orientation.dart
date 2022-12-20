import 'package:dezmente/common/super.dart';
import 'package:dezmente/services/models/result_model.dart';
import 'package:dezmente/utils/fields.dart';
import 'package:flutter/material.dart';

class TestSpaceOrient extends SuperTest {
  @override
  get description => "Responda as perguntas:";

  @override
  get audioFile => "teste-10a.mp3";

  @override
  get title => "Teste 10: Orientação Espacial";

  const TestSpaceOrient({Key? key}) : super(key: key);

  @override
  TestSpaceOrientState createState() => TestSpaceOrientState();
}

class TestSpaceOrientState extends SuperTestState {
  @override
  erase() {}

  final _dayPeriods = ["Manhã", "Tarde", "Noite"];
  final _weekDays = [
    "Segunda",
    "Terça",
    "Quarta",
    "Quinta",
    "Sexta",
    "Sábado",
    "Domingo",
  ];
  final _monthList = [
    "Janeiro",
    "Fevereiro",
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

  final TextEditingController _city = TextEditingController();
  final TextEditingController _day = TextEditingController();
  final TextEditingController _year = TextEditingController();
  final Map<String, String> _dpfResults = {};

  @override
  Result getData() {
    data.testId = 10;

    data.responses = {
      "city": _city.text,
      "period": _dpfResults["period"],
      "day": _day.text,
      "month": _dpfResults["month"],
      "year": _year.text,
      "weekDay": _dpfResults["week"],
    };

    data.score = _calculateScore();

    return super.getData();
  }

  int _calculateScore() {
    int score = 0;
    DateTime now = DateTime.now();
    String period = "";

    if (now.day == int.parse(_day.text)) {
      score++;
    }
    if (_monthList[now.month - 1] == _dpfResults["Em que mês estamos?"]) {
      score++;
    }
    if ("${now.year}" == _year.text) {
      score++;
    }

    if (now.hour < 12) {
      period = "Manhã";
    } else if (now.hour > 18) {
      period = "Noite";
    } else {
      period = "Tarde";
    }

    if (_dpfResults["Em que período do dia estamos?"] == period) {
      score++;
    }

    if (_weekDays[now.weekday - 1] ==
        _dpfResults["Em que dia da semana estamos?"]) {
      score++;
    }

    // falta a cidade

    return score;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(top: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomTextInputField(
                kbType: TextInputType.text,
                text: "Em que cidade você está?",
                maxLength: 20,
                controller: _city,
              ),
              CustomDropdownField(
                itemList: _dayPeriods,
                text: "Em que período do dia estamos?",
                finalValue: _dpfResults,
              ),
              CustomTextInputField(
                kbType: TextInputType.number,
                text: "Que dia do mês é hoje?",
                maxLength: 4,
                controller: _day,
              ),
              CustomDropdownField(
                itemList: _monthList,
                text: "Em que mês estamos?",
                finalValue: _dpfResults,
              ),
              CustomTextInputField(
                kbType: TextInputType.number,
                text: "Em que ano nós estamos?",
                maxLength: 4,
                controller: _year,
              ),
              CustomDropdownField(
                itemList: _weekDays,
                text: "Em que dia da semana estamos?",
                finalValue: _dpfResults,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
