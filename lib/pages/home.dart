import 'package:dezmente/pages/teste.dart';
import 'package:dezmente/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:confirm_dialog/confirm_dialog.dart';

class HomeWidget extends StatelessWidget {
  const HomeWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xfff72585),
        title: const Text("Dezmente", textAlign: TextAlign.center),
        actions: <Widget>[
          IconButton(
            onPressed: () async {
              if (await confirm(
                context,
                title: const Text("Desconectar"),
                content: const Text("Tem certeza que deseja se desconectar?"),
                textOK: const Text("Sim"),
                textCancel: const Text("Não"),
              )) {
                // fazer o logout
                AuthService().logOut();
              }
            },
            icon: const Icon(
              Icons.logout,
            ),
          ),
        ],
      ),
      body: Container(
        alignment: Alignment.center,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(primary: const Color(0xfff72585)),
          child: const Text("Começar Teste"),
          onPressed: () {
            Navigator.of(context).pushReplacement(PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) =>
                  const Teste(),
            ));
          },
        ),
      ),
    );
  }
}
