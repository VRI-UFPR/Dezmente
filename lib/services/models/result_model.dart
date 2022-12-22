import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dezmente/services/results.dart';

enum TestTag { none, vse, naming, imMem, evMem, attention, abst, arth, orient }

class Result {
  Result({
    required this.timeSpent,
    this.code = Code.next,
    this.score = 0,
    this.testId = -1,
    this.responses,
    this.testTitle,
    required this.testType,
  });

  String? testTitle;
  int? testId;
  int? score;
  int? timeSpent;
  Map<String, dynamic>? responses;
  TestTag testType;

  Code code;

  Map<String, dynamic> toFirestore() {
    return {
      if (testTitle != null) "testTitle": testTitle,
      "testId": testId,
      "timeSpent": timeSpent,
      "score": score,
      "testType": testType.index,
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
      testType: TestTag.values[data?['testType']],
      responses: data?['responses'],
    );
  }

  int? get getScore {
    return score;
  }

  TestTag get getTag {
    return testType;
  }
}
