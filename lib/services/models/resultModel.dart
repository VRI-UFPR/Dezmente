import 'package:dezmente/services/results.dart';

class Result {
  Result(
      {required this.timeSpent,
      this.code = Code.next,
      this.score = 0,
      this.weight = 1,
      this.testId = -1,
      this.responses,
      this.testName});

  String? testName;
  int testId;
  int score;
  int weight;
  int timeSpent;
  Map<String, dynamic>? responses;

  Code code;

  Map<String, dynamic> toFirestore() {
    return {
      if (testName != null) "testTitle": testName,
      "testId": testId,
      "timeSpent": timeSpent,
      "score": score,
      "scoreWeight": weight,
      if (responses != null) "responses": responses,
    };
  }
}
