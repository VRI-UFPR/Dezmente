import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dezmente/services/models/signup_data_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<void> setSignupData(SignUpData data) {
  Map<String, dynamic> sendData = data.toFirestore();
  sendData.addAll({"register": true});
  DocumentReference testRef = FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser!.uid);
  return testRef
      .set(sendData, SetOptions(merge: true))
      .then((value) => print("Submit completed"))
      .catchError((error) => print("Failed to submit: $error"));
}

setTcle() {
  DocumentReference testRef = FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser!.uid);

  testRef.set({"tcle": true}, SetOptions(merge: true));
}
