import 'package:dezmente/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/rectangle2.png'),
              fit: BoxFit.fitWidth,
              alignment: Alignment.bottomCenter),
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
                  height: 250,
                ),
              ),
              Align(
                alignment: const Alignment(0.0, 0.6),
                child: FloatingActionButton.extended(
                  onPressed: () {
                    final provider =
                        Provider.of<AuthService>(context, listen: false);
                    provider.googleLogin();
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
      );
}
