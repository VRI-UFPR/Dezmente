import 'dart:developer';
import 'package:dezmente/screens/authentication/loginscreen.dart';
import 'package:flutter/material.dart';
import 'package:confirm_dialog/confirm_dialog.dart';

// home temporaria
class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xfff72585),
        title: const Text(
          "Dezmente",
          textAlign: TextAlign.center
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () async {
              if (await confirm(
                context,
                title: const Text("Desconectar"),
                content: const Text("Tem certeza que deseja se desconectar?"),
                textOK: const Text("Sim"),
                textCancel: const Text("Não"),
              )) { // fazer o logout
                Navigator.push( 
                  context, 
                  MaterialPageRoute(builder: (context) => const LoginScreen())                
                ); 
              }
              return log('pressed cancel'); //
            },
            icon: const Icon(
              Icons.logout,
            ),
          ),
        ],
      ),
      body: Container(
        
      ),
    );
  }
}
