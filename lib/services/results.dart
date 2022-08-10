import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

enum Code { next, stay }

class TestResults {
  final _results = <Result>[];

  addResult(Result r) {
    _results.add(r);
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
}

class Result {
  Result(
      {required this.timeSpent,
      this.code = Code.next,
      this.score = 0,
      this.testId = -1,
      this.testName});

  String? testName;
  int testId;
  int score;
  int timeSpent;

  Code code;

  Map<String, dynamic> toFirestore() {
    return {
      if (testName != null) "testTitle": testName,
      "testId": testId,
      "timeSpent": timeSpent,
      "score": score,
    };
  }
}
