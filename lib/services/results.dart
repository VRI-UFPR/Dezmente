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
    _results.clear();
    //Pega os testes do usuario, ordenado pela data
    var snapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("testes")
        .orderBy("timestamp", descending: true)
        .get();

    //Pega o primeiro(ultimo teste que a pessoa fez) e da get nos results
    snapshot = await snapshot.docs.first.reference.collection("results").get();

    //Passa por todos results da snapshot e cria e insere os dados no _results dessa classe
    for (var element in snapshot.docs) {
      addResult(Result.fromFirestore(element));
    }
  }

  Map<TestTag, int> getScores() {
    Map<TestTag, int> scores = {};

    for (var t in TestTag.values) {
      scores[t] = 0;
    }

    for (var r in _results) {
      int score = (r.getScore == null) ? 0 : r.getScore!.toInt();
      scores[r.getTag] = scores[r.getTag]! + score;
    }
    return scores;
  }
}
