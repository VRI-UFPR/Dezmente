import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/rectangle2.png'),
            fit: BoxFit.fitWidth,
            alignment: Alignment.bottomCenter
          ),
        ),
        child: Container(
          margin: const EdgeInsets.all(10.0),
          child: Stack(
            children: <Widget>[
              Align(
                alignment: const Alignment(0.0, -0.8),
                child: SizedBox(
                  child: Image.asset('assets/images/logo.png'),
                  width: double.infinity,
                  height: 400,
                ),
              ),
              Align(
                alignment: const Alignment(0.0, 0.6),
                child: SizedBox(
                  child: SignInButton(
                    Buttons.Google,
                    text: "Entrar com o google",
                    onPressed: () {},
                  ),
                  height: 50,
                  width: 200,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}