import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dezmente/services/models/signupdataModel.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<void> setSignupData(SignUpData data) {
  DocumentReference testRef = FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser!.uid);
  return testRef
      .set(data.toFirestore())
      .then((value) => print("Submit completed"))
      .catchError((error) => print("Failed to submit: $error"));
}
