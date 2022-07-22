enum Code { next, stay }

class TestResults {
  TestResults({required this.timeStamp, this.code = Code.next, this.score = 0});

  int score;
  int timeStamp;

  Code code;
}
