import 'package:dezmente/common/super.dart';
import 'package:dezmente/utils/fields.dart';
import 'package:flutter/material.dart';

class TestSpaceOrient extends SuperTest {
  @override
  get description => "Responda as perguntas:";

  @override
  get audioFile => "teste-10a.mp3";

  @override
  get title => "Test 10: Orientação Espacial";

  const TestSpaceOrient({Key? key}) : super(key: key);

  @override
  TestSpaceOrientState createState() => TestSpaceOrientState();
}

class TestSpaceOrientState extends SuperTestState {
  @override
  erase() {}

  final _dayPeriods = ["Manhã", "Tarde", "Noite"];
  final _weekDays = [
    "Domingo",
    "Segunda",
    "Terça",
    "Quarta",
    "Quinta",
    "Sexta",
    "Sábado"
  ];
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

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Container(
            margin: const EdgeInsets.only(top: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const CustomTextInputField(
                  kbType: TextInputType.text,
                  text: "Em que cidade você está?",
                  maxLength: 20,
                ),
                CustomDropdownField(
                  itemList: _dayPeriods,
                  text: "Em que período do dia estamos?",
                ),
                const CustomTextInputField(
                  kbType: TextInputType.number,
                  text: "Que dia do mês é hoje?",
                  maxLength: 4,
                ),
                CustomDropdownField(
                  itemList: _monthList,
                  text: "Em que mês estamos?",
                ),
                const CustomTextInputField(
                  kbType: TextInputType.number,
                  text: "Em que ano nós estamos?",
                  maxLength: 4,
                ),
                CustomDropdownField(
                  itemList: _weekDays,
                  text: "Em que dia da semana estamos?",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
