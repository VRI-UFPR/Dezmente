import 'package:dezmente/pages/signup/no_monitor.dart';
import 'package:dezmente/pages/signup/with_monitor.dart';
import 'package:dezmente/utils/buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Instructions extends StatefulWidget {
  const Instructions({Key? key}) : super(key: key);

  @override
  State<Instructions> createState() => _InstructionsState();
}

class _InstructionsState extends State<Instructions> {
  @override
  Widget build(BuildContext context) {
    final double scrWfactor = MediaQuery.of(context).size.width / 640;
    final double scrHfactor = MediaQuery.of(context).size.height / 640;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: SvgPicture.asset(
                "assets/images/topbar_green.svg",
                fit: BoxFit.fill,
                width: MediaQuery.of(context).size.width,
              ),
            ),
            SizedBox(
              height: 50 * scrHfactor,
            ),
            Container(
              width: 300 * scrHfactor,
              margin: const EdgeInsets.all(20),
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                color: Color(0xFFA5E6D9),
              ),
              child: const Text(
                "Se você tem mais de 70 anos ou usa pouco o celular, chame alguém para te ajudar. Você tem alguém para te ajudar?",
                style: TextStyle(
                  fontFamily: "montserrat",
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: 150 * scrHfactor,
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(20, 50, 20, 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CustomTextButtom(
                    text: "Sim",
                    sizes: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                    bgColor: const Color.fromARGB(63, 247, 37, 133),
                    callback: () {
                      Navigator.of(context).push(PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            const WithMonitorSignUp(),
                      ));
                    },
                  ),
                  CustomTextButtom(
                    text: "Não",
                    sizes: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                    bgColor: const Color.fromARGB(63, 247, 37, 133),
                    callback: () {
                      Navigator.of(context).push(PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            const NoMonitorSignUp(),
                      ));
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
