import 'package:dezmente/utils/fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

class UserSignUp extends StatefulWidget {
  const UserSignUp({Key? key}) : super(key: key);

  @override
  State<UserSignUp> createState() => _UserSignUpState();
}

class _UserSignUpState extends State<UserSignUp> {
  @override
  Widget build(BuildContext context) {
    final double scrHfactor = MediaQuery.of(context).size.height / 640;
    final double scrWfactor = MediaQuery.of(context).size.width / 360;

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.bottom]);

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        toolbarHeight: 150 * scrHfactor,
        title: Stack(
          children: [
            SvgPicture.asset(
              "assets/images/topbar.svg",
              fit: BoxFit.fitWidth,
            ),
            _title("Usuário"),
          ],
        ),
        titleSpacing: 0,
      ),
      body: SingleChildScrollView(child: _buildUsuario()),
    );
  }

  Widget _buildUsuario() {
    final TextEditingController _ageController = TextEditingController();
    final TextEditingController _cityController = TextEditingController();
    final TextEditingController _genderController = TextEditingController();
    final TextEditingController _schoolController = TextEditingController();
    final TextEditingController _statusController = TextEditingController();
    final TextEditingController _exercController = TextEditingController();
    // final String? _healthIssue;
    // final String? _medicine;

    return Container(
      margin: const EdgeInsets.only(top: 15),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomTextInputField(
              text: "Idade",
              kbType: TextInputType.number,
              maxLength: 3,
              controller: _ageController,
            ),
            CustomTextInputField(
              text: "Gênero",
              kbType: TextInputType.name,
              maxLength: 20,
              controller: _genderController,
            ),
            CustomTextInputField(
              text: "Cidade",
              kbType: TextInputType.name,
              maxLength: 20,
              controller: _cityController,
            ),
            CustomTextInputField(
              text: "Escolaridade",
              kbType: TextInputType.name,
              maxLength: 20,
              controller: _schoolController,
            ),
            CustomTextInputField(
              text: "Status de atividade",
              kbType: TextInputType.name,
              maxLength: 20,
              controller: _statusController,
            ),
            const CustomDropdownField(
              itemList: ["Sim", "Não"],
              text: "Possui alguma doença?",
            ),
            const CustomDropdownField(
              itemList: ["Sim", "Não"],
              text: "Utiliza alguma medicação?",
            ),
            CustomTextInputField(
              text: "Horas de exercício físico p/s",
              kbType: TextInputType.number,
              maxLength: 3,
              controller: _exercController,
            ),
            OutlinedButton.icon(
              icon: const Icon(
                Icons.arrow_right_alt,
                color: Colors.black,
              ),
              label: const Text(
                "Próxima Página",
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: "montserrat",
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
              style: ButtonStyle(
                side: MaterialStateProperty.all(
                  const BorderSide(
                    width: 1.0,
                    style: BorderStyle.solid,
                  ),
                ),
                backgroundColor:
                    MaterialStateProperty.all<Color>(const Color(0xff4cc9f0)),
              ),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }

  Widget _title(String text) {
    return Center(
      child: Container(
        margin: const EdgeInsets.only(top: 100),
        padding: const EdgeInsets.only(
          bottom: 4,
        ),
        width: 100,
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Color(0xff736306),
              width: 1.0,
            ),
          ),
        ),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontFamily: "montserrat",
            fontWeight: FontWeight.bold,
            fontSize: 15,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
