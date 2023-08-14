import 'package:dezmente/pages/teste.dart';
import 'package:dezmente/services/models/signup_data_model.dart';
import 'package:dezmente/services/signupdata.dart';
import 'package:dezmente/utils/buttons.dart';
import 'package:dezmente/utils/fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WithMonitorSignUp extends StatefulWidget {
  const WithMonitorSignUp({Key? key}) : super(key: key);

  @override
  State<WithMonitorSignUp> createState() => _WithMonitorSignUpState();
}

class _WithMonitorSignUpState extends State<WithMonitorSignUp> {
  final _formKey = GlobalKey<FormState>();
  int pageNumber = 0;
  final TextEditingController _helperAge = TextEditingController();
  final TextEditingController _age = TextEditingController();
  final TextEditingController _gender = TextEditingController();
  final TextEditingController _city = TextEditingController();
  final TextEditingController _school = TextEditingController();
  final TextEditingController _exh = TextEditingController();
  final Map<String, String> _dpf = {};
  final Map<String, bool> _treatments = {};

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.bottom]);

    return Scaffold(
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
            Form(
              key: _formKey,
              child: _buildPages(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPages() {
    switch (pageNumber) {
      case 0:
        return _firstPage();
      case 1:
        return _secondPage();
      case 2:
        return _thirdPage();
      default:
        return _firstPage();
    }
  }

  Widget _firstPage() {
    final double scrHfactor = MediaQuery.of(context).size.height / 640;
    final double scrWfactor = MediaQuery.of(context).size.width / 360;

    return Container(
      margin: const EdgeInsets.only(top: 15),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 10),
              child: Center(
                child: _buildTitle("Ajudante"),
              ),
            ),
            CustomTextInputField(
              text: "Idade do Ajudante",
              kbType: TextInputType.number,
              maxLength: 3,
              controller: _helperAge,
            ),
            Center(
              child: Container(
                margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                padding: const EdgeInsets.all(20),
                height: 100 * scrHfactor,
                width: 260 * scrWfactor,
                decoration: const BoxDecoration(
                  color: Color(0xADFDC6E3),
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                child: const Text(
                  "Seu auxílio será apenas no uso do celular. NÃO ajude nas respostas dos exercícios. NÃO explique os testes.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: "montserrat",
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
              child: Center(
                child: _buildTitle("Usuário"),
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
            _nextPageButton(() {
              setState(() {
                pageNumber++;
              });
            })
          ],
        ),
      ),
    );
  }

  Widget _secondPage() {
    return Container(
      margin: const EdgeInsets.only(top: 15),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 10),
              child: Center(
                child: _buildTitle("Usuário"),
              ),
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
            _nextPageButton(() {
              setState(() {
                pageNumber++;
              });
            })
          ],
        ),
      ),
    );
  }

  Widget _thirdPage() {
    return Container(
      margin: const EdgeInsets.only(top: 15),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomCheckBoxField(
              text: "Tratamento de ansiedade",
              finalValue: _treatments,
            ),
            CustomCheckBoxField(
              text: "Tratamento de eplepsia",
              finalValue: _treatments,
            ),
            CustomCheckBoxField(
              text: "Tratamento de insônia",
              finalValue: _treatments,
            ),
            CustomCheckBoxField(
              text: "Tratamento de Alzheimer",
              finalValue: _treatments,
            ),
            CustomCheckBoxField(
              text: "Doença da tireoide",
              finalValue: _treatments,
            ),
            CustomCheckBoxField(
              text: "Tratamento de depressão",
              finalValue: _treatments,
            ),
            CustomCheckBoxField(
              text: "Tratamento para incontinência\nurinária",
              finalValue: _treatments,
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
                    hasMonitor: true,
                    monAge:
                        _helperAge.text != "" ? int.parse(_helperAge.text) : 0,
                    treatments: _treatments,
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

  Widget _buildTitle(title) {
    return Text(
      title,
      textAlign: TextAlign.center,
      style: const TextStyle(
        fontFamily: "PassionOne",
        fontWeight: FontWeight.w700,
        fontSize: 32,
        color: Colors.black,
        fontStyle: FontStyle.normal,
      ),
    );
  }

  Widget _nextPageButton(callback) {
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 20, 20, 0),
      child: Align(
        alignment: Alignment.topRight,
        child: OutlinedButton(
          style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(7))),
            ),
            alignment: Alignment.center,
            padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
              const EdgeInsets.all(13),
            ),
            backgroundColor:
                MaterialStateProperty.all<Color>(const Color(0xff569DB3)),
          ),
          onPressed: callback,
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Próxima Página",
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: "montserrat",
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                width: 70,
              ),
              Icon(
                Icons.arrow_right_alt_outlined,
                color: Colors.black,
                size: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
