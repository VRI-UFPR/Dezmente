import 'package:dezmente/services/models/result_model.dart';
import 'package:flutter/material.dart';

class ResultPage extends StatefulWidget {
  final Map<TestTag, int> scores;

  const ResultPage({
    required this.scores,
    Key? key,
  }) : super(key: key);

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  @override
  Widget build(BuildContext context) {
    double scrHfactor = MediaQuery.of(context).size.height / 640;

    int totalScore = _calculateTotalScore(widget.scores);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xFFF72585),
        shadowColor: Colors.transparent,
        toolbarHeight: 150 * scrHfactor,
        title: Center(
          child: Column(
            children: [
              const Text(
                "VOCÊ ACERTOU",
                style: TextStyle(
                  fontFamily: "montserrat",
                  fontWeight: FontWeight.w700,
                  fontSize: 42,
                  color: Colors.white,
                  shadows: <Shadow>[
                    Shadow(
                      offset: Offset(4.0, 4.0),
                      blurRadius: 3.0,
                      color: Color.fromARGB(63, 0, 0, 0),
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
              Text(
                "$totalScore/30",
                style: TextStyle(
                  color: _totalScoreColor(totalScore),
                  fontFamily: "montserrat",
                  fontWeight: FontWeight.w700,
                  fontSize: 42,
                  shadows: const <Shadow>[
                    Shadow(
                      offset: Offset(4.0, 4.0),
                      blurRadius: 3.0,
                      color: Color.fromARGB(63, 0, 0, 0),
                    ),
                  ],
                ),
              ),
              // Text(
              //   (totalScore >= 26)
              //       ? "COGNIÇÃO NORMAL"
              //       : "CHANCE DE DECLÍNIO COGNITIVO",
              //   style: TextStyle(
              //     color: _totalScoreColor(totalScore),
              //     fontFamily: "montserrat",
              //     fontWeight: FontWeight.w700,
              //     fontSize: 20,
              //     shadows: const <Shadow>[
              //       Shadow(
              //         offset: Offset(4.0, 4.0),
              //         blurRadius: 3.0,
              //         color: Color.fromARGB(63, 0, 0, 0),
              //       ),
              //     ],
              //   ),
              // ),
            ],
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildResultField("FUNÇÃO VISUESPACIAL/EXECUTIVA",
                widget.scores[TestTag.vse] ?? 0, 5),
            _buildResultField(
                "FUNÇÃO DE NOMEAÇÃO", widget.scores[TestTag.naming] ?? 0, 3),
            _buildResultField("FUNÇÃO DE MEMÓRIA IMEDIATA",
                widget.scores[TestTag.imMem] ?? 0, 2),
            _buildResultField("FUNÇÃO DE MEMÓRIA EVOCADA",
                widget.scores[TestTag.evMem] ?? 0, 5),
            _buildResultField(
                "FUNÇÃO DE ATENÇÃO", widget.scores[TestTag.attention] ?? 0, 2),
            _buildResultField(
                "FUNÇÃO DE ABSTRAÇÃO", widget.scores[TestTag.abst] ?? 0, 2),
            _buildResultField(
                "FUNÇÃO DE ATENÇÃO 100-7", widget.scores[TestTag.arth] ?? 0, 5),
            _buildResultField(
                "FUNÇÃO DE ORIENTAÇÃO", widget.scores[TestTag.orient] ?? 0, 6),
            Container(
              margin: const EdgeInsets.only(top: 20),
              child: Center(
                child: TextButton(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(7))),
                    ),
                    alignment: Alignment.center,
                    padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                      const EdgeInsets.all(13),
                    ),
                    backgroundColor: MaterialStateProperty.all<Color>(
                        const Color(0xff78DAC6)),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    margin: const EdgeInsets.fromLTRB(70, 0, 70, 0),
                    child: const Text(
                      "Terminar",
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: "montserrat",
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  int _calculateTotalScore(Map<TestTag, int> scores) {
    int percent = 0;

    scores.forEach((key, value) {
      percent += value;
    });

    return percent;
  }

  Color _totalScoreColor(int percent) {
    if (percent >= 26) {
      return const Color(0xFF22DE8F);
    } else {
      return const Color(0xFFFED546);
    }
  }

  Widget _buildResultField(String text, int score, int max) {
    double scrHfactor = MediaQuery.of(context).size.height / 640;
    double scrWfactor = MediaQuery.of(context).size.width / 360;

    return Container(
      padding: const EdgeInsets.fromLTRB(19, 9, 0, 0),
      margin: const EdgeInsets.only(bottom: 12),
      height: 33 * scrHfactor,
      width: 331 * scrWfactor,
      decoration: BoxDecoration(
        color: const Color(0xFF78DAC6),
        border: Border.all(
          color: Colors.transparent,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(6)),
      ),
      child: Text(
        "$text: $score/$max",
        style: const TextStyle(
          fontFamily: "montserrat",
          fontWeight: FontWeight.w700,
          fontSize: 15,
          color: Colors.black,
        ),
      ),
    );
  }
}
