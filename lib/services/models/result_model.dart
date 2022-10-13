import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dezmente/services/results.dart';

class Result {
  Result({
    required this.timeSpent,
    this.code = Code.next,
    this.score = 0,
    this.testId = -1,
    this.responses,
    this.testTitle,
  });

  String? testTitle;
  int? testId;
  int? score;
  int? timeSpent;
  Map<String, dynamic>? responses;

  Code code;

  Map<String, dynamic> toFirestore() {
    return {
      if (testTitle != null) "testTitle": testTitle,
      "testId": testId,
      "timeSpent": timeSpent,
      "score": score,
      if (responses != null) "responses": responses,
    };
  }

  factory Result.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
  ) {
    final data = snapshot.data();
    return Result(
      testTitle: data?['testTitle'],
      timeSpent: data?['timeSpent'],
      testId: data?['testId'],
      score: data?['score'],
      responses: data?['responses'],
    );
  }
}
