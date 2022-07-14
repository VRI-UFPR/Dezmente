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
    final double scrHfactor = MediaQuery.of(context).size.height / 640;
    final double scrWfactor = MediaQuery.of(context).size.width / 360;

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.bottom]);

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Column(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Stack(
              children: [
                SvgPicture.asset(
                  "assets/images/topbar.svg",
                  fit: BoxFit.fitWidth,
                ),
                Center(
                  child: Container(
                    margin: EdgeInsets.only(top: 100 * scrHfactor),
                    child: const Text(
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
              ],
            ),
          ),
          SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: _firstPage(),
            ),
          ),
        ],
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
                  onPressed: () {},
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
