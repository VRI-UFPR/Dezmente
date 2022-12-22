import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dezmente/pages/home.dart';
import 'package:dezmente/pages/instructions.dart';
import 'package:dezmente/pages/result_page.dart';
import 'package:dezmente/pages/tcle.dart';
import 'package:dezmente/services/auth.dart';
import 'package:dezmente/pages/login.dart';
import 'package:dezmente/services/signupdata.dart';
import 'package:dezmente/widgets/dialog.dart';
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

  bool tcleCheck(
      AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> snapshotTcle) {
    if (snapshotTcle.data != null) {
      if (snapshotTcle.data!.data() != null) {
        final data = snapshotTcle.data!.data() as Map<String, dynamic>;
        return data['tcle'] ?? false;
      }
    }
    return false;
  }

  bool registerCheck(
      AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> snapshotTcle) {
    if (snapshotTcle.data != null) {
      if (snapshotTcle.data!.data() != null) {
        final data = snapshotTcle.data!.data() as Map<String, dynamic>;
        return data['register'] ?? false;
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    final Stream<DocumentSnapshot<Map<String, dynamic>>> usersStream =
        FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .snapshots();
    return ChangeNotifierProvider(
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
              return StreamBuilder(
                stream: usersStream,
                builder: (
                  context,
                  AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>>
                      snapshotUser,
                ) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasData) {
                    if (snapshotUser.connectionState ==
                        ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (!tcleCheck(snapshotUser)) {
                      return const Tcle();
                    } else if (!registerCheck(snapshotUser)) {
                      return const Instructions();
                    }
                    return const HomePage();
                    //return const ResultPage();
                  } else if (snapshot.hasError) {
                    return Text(snapshot.error.toString());
                  } else {
                    return const LoginPage();
                  }
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
