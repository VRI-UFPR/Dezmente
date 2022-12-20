import 'package:dezmente/pages/home.dart';
import 'package:dezmente/pages/tcle.dart';
import 'package:dezmente/services/auth.dart';
import 'package:dezmente/pages/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
        create: (context) => AuthService(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Dezmente',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: Scaffold(
            body: StreamBuilder(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasData) {
                  return const Tcle();
                  // return const ResultPage(
                  //   percentege: 95,
                  // );
                } else if (snapshot.hasError) {
                  return Text(snapshot.error.toString());
                } else {
                  return const LoginPage();
                }
              },
            ),
          ),
        ),
      );
}
