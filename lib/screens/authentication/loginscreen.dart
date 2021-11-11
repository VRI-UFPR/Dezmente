import 'package:dezmente/screens/testes/home.dart';
import 'package:flutter/material.dart';

// pagina inicial do app para login usando firebase auth
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
                child: FloatingActionButton.extended(
                  onPressed: () {   // fazer o sistema de login antes de redirecionar pra home
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Home())
                    );
                  },
                  icon: Image.asset(
                    'assets/images/google_logo.png',
                    height: 32,
                    width: 32,
                  ),
                  label: const Text('Entrar com o google'),
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}