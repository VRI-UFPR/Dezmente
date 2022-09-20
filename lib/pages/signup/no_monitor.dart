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
  final _formKey = GlobalKey<FormState>();

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
                fit: BoxFit.none,
                width: MediaQuery.of(context).size.width,
              ),
            ),
            Form(
              key: _formKey,
              child: _firstPage(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _firstPage() {
    return Container(
      margin: const EdgeInsets.only(top: 15),
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
            const CustomDropdownField(
              itemList: ["Trabalhando", "Aposentado"],
              text: "Status de atividade",
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
            Container(
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
                    backgroundColor: MaterialStateProperty.all<Color>(
                        const Color(0xff569DB3)),
                  ),
                  onPressed: () {
                    _formKey.currentState?.save();
                    print(_formKey.currentWidget);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
