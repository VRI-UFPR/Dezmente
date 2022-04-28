import 'package:dezmente/pages/home.dart';
import 'package:dezmente/services/auth.dart';
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
          home: const Home(),
        ),
      );
}
