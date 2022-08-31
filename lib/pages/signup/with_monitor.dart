import 'package:dezmente/services/models/signupdataModel.dart';
import 'package:dezmente/services/signupdata.dart';
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

  @override
  Widget build(BuildContext context) {
    final double scrHfactor = MediaQuery.of(context).size.height / 640;
    final double scrWfactor = MediaQuery.of(context).size.width / 360;

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
                fit: BoxFit.none,
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
            const CustomTextInputField(
              text: "Idade do Ajudante",
              kbType: TextInputType.number,
              maxLength: 3,
            ),
            Center(
              child: Container(
                margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                padding: const EdgeInsets.all(20),
                height: 109 * scrHfactor,
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
                    fontSize: 15,
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
            const CustomTextInputField(
              text: "Idade",
              kbType: TextInputType.number,
              maxLength: 3,
            ),
            const CustomTextInputField(
              text: "Gênero",
              kbType: TextInputType.name,
              maxLength: 20,
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
                child: _buildTitle("Usuário"),
              ),
            ),
            const CustomTextInputField(
              text: "Cidade",
              kbType: TextInputType.name,
              maxLength: 20,
            ),
            const CustomTextInputField(
              text: "Escolaridade",
              kbType: TextInputType.name,
              maxLength: 20,
            ),
            const CustomTextInputField(
              text: "Status de atividade",
              kbType: TextInputType.name,
              maxLength: 20,
            ),
            const CustomDropdownField(
              itemList: ["Sim", "Não"],
              text: "Possui alguma doença?",
            ),
            const CustomDropdownField(
              itemList: ["Sim", "Não"],
              text: "Utiliza alguma medicação?",
            ),
            const CustomTextInputField(
              text: "Horas de exercício físico p/s",
              kbType: TextInputType.number,
              maxLength: 3,
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
    final double scrHfactor = MediaQuery.of(context).size.height / 640;
    final double scrWfactor = MediaQuery.of(context).size.width / 360;

    return Container(
      margin: const EdgeInsets.only(top: 15),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CustomCheckBoxField(
              text: "Tratamento de ansiedade",
            ),
            const CustomCheckBoxField(
              text: "Tratamento de eplepsia",
            ),
            const CustomCheckBoxField(
              text: "Tratamento de insônia",
            ),
            const CustomCheckBoxField(
              text: "Tratamento de Alzheimer",
            ),
            const CustomCheckBoxField(
              text: "Doença da tireoide",
            ),
            const CustomCheckBoxField(
              text: "Tratamento de depressão",
            ),
            const CustomCheckBoxField(
              text: "Tratamento para incontinência\nurinária",
            ),
            _finishButton(() {
              setSignupData(SignUpData());
            })
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
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: const [
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
        ),
      ),
    );
  }

  Widget _finishButton(callback) {
    return Container(
      margin: const EdgeInsets.only(top: 40),
      child: Center(
        child: TextButton(
          child: Container(
            margin: const EdgeInsets.fromLTRB(70, 0, 70, 0),
            child: const Text(
              "Terminar",
              style: TextStyle(
                color: Colors.black,
                fontFamily: "montserrat",
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
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
        ),
      ),
    );
  }
}
