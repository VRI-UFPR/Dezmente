import 'package:dezmente/pages/teste.dart';
import 'package:dezmente/services/models/signup_data_model.dart';
import 'package:dezmente/services/signupdata.dart';
import 'package:dezmente/utils/buttons.dart';
import 'package:dezmente/utils/fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NoMonitorSignUp extends StatefulWidget {
  const NoMonitorSignUp({Key? key}) : super(key: key);

  @override
  State<NoMonitorSignUp> createState() => _NoMonitorSignUpState();
}

class _NoMonitorSignUpState extends State<NoMonitorSignUp> {
  final TextEditingController _age = TextEditingController();
  final TextEditingController _gender = TextEditingController();
  final TextEditingController _city = TextEditingController();
  final TextEditingController _school = TextEditingController();
  final TextEditingController _exh = TextEditingController();
  final Map<String, String> _dpf = {};

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.bottom]);

    return WillPopScope(
      onWillPop: () => Future(() => false),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: SvgPicture.asset(
                  "assets/images/topbar.svg",
                  fit: BoxFit.fill,
                  width: MediaQuery.of(context).size.width,
                ),
              ),
              _firstPage(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _firstPage() {
    return Container(
      margin: const EdgeInsets.only(top: 0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 10),
              child: const Center(
                child: Text(
                  "Usuário",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: "PassionOne",
                    fontWeight: FontWeight.w700,
                    fontSize: 32,
                    color: Colors.black,
                    fontStyle: FontStyle.normal,
                  ),
                ),
              ),
            ),
            CustomTextInputField(
              text: "Idade",
              kbType: TextInputType.number,
              maxLength: 3,
              controller: _age,
            ),
            CustomTextInputField(
              text: "Gênero",
              kbType: TextInputType.name,
              maxLength: 20,
              controller: _gender,
            ),
            CustomTextInputField(
              text: "Cidade",
              kbType: TextInputType.name,
              maxLength: 20,
              controller: _city,
            ),
            CustomTextInputField(
              text: "Escolaridade",
              kbType: TextInputType.name,
              maxLength: 20,
              controller: _school,
            ),
            CustomDropdownField(
              itemList: const ["Trabalhando", "Aposentado"],
              text: "Status de atividade",
              finalValue: _dpf,
            ),
            CustomDropdownField(
              itemList: const ["Sim", "Não"],
              text: "Possui alguma doença?",
              finalValue: _dpf,
            ),
            CustomDropdownField(
              itemList: const ["Sim", "Não"],
              text: "Utiliza alguma medicação?",
              finalValue: _dpf,
            ),
            CustomTextInputField(
              text: "Horas de exercício físico p/s",
              kbType: TextInputType.number,
              maxLength: 3,
              controller: _exh,
            ),
            FinishButtom(
              callback: () {
                setSignupData(
                  SignUpData(
                    age: _age.text != "" ? int.parse(_age.text) : 0,
                    gender: _gender.text,
                    city: _city.text,
                    school: _school.text,
                    active: _dpf["Status de Atividade"] == "Trabalhando",
                    healthIssue: _dpf["Possui alguma doença?"] == "Sim",
                    medic: _dpf["Utiliza alguma medicação?"] == "Sim",
                    physHours: _exh.text != "" ? int.parse(_exh.text) : 0,
                    hasMonitor: false,
                    treatments: {},
                  ),
                );
                Navigator.of(context).pushAndRemoveUntil(
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        const Teste(),
                  ),
                  (route) => false,
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
