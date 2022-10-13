import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dezmente/services/models/result_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

enum Code { next, stay, notInclude }

class TestResults {
  final List<Result> _results = <Result>[];

  addResult(Result r) {
    if (r.code != Code.notInclude) {
      _results.add(r);
    }
  }

  Future<void> submit() {
    WriteBatch batch = FirebaseFirestore.instance.batch();
    DocumentReference docRef;
    DocumentReference testRef = FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('testes')
        .doc();
    batch.set(testRef, {"timestamp": FieldValue.serverTimestamp()});

    for (Result element in _results) {
      docRef = testRef.collection('results').doc();
      batch.set(docRef, element.toFirestore());
    }

    return batch
        .commit()
        .then((value) => print("Submit completed"))
        .catchError((error) => print("Failed to submit: $error"));
  }

  getResult() async {
    var test = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("testes")
        .orderBy("timestamp", descending: true)
        .get();

    test = await test.docs.first.reference.collection("results").get();
    for (var element in test.docs) {
      addResult(Result.fromFirestore(element));
    }
  }
}
