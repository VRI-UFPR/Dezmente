import 'package:dezmente/services/models/result_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ResultPage extends StatefulWidget {
  final int percentege;

  const ResultPage({
    this.percentege = 0,
    Key? key,
  }) : super(key: key);

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  @override
  Widget build(BuildContext context) {
    double scrHfactor = MediaQuery.of(context).size.height / 640;

    return Scaffold(
      appBar: AppBar(
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
                  fontSize: 32,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              Text(
                "${widget.percentege}%",
                style: TextStyle(
                  color: _percentageColor(),
                  fontFamily: "montserrat",
                  fontWeight: FontWeight.w700,
                  fontSize: 32,
                ),
              ),
            ],
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildResultField("VISUESPACIAL:  3/3"),
            _buildResultField("NOMEAÇÃO:  3/3"),
            _buildResultField("MEMÓRIA:  3/3"),
            _buildResultField("VIGILÂNCIA:  3/3"),
            _buildResultField("ABSTRAÇÃO:  3/3"),
            _buildResultField("ARITMÉTICA:  3/3"),
            _buildResultField("ORIENTAÇÃO:  3/3"),
            _buildResultField("EVOCAÇÃO TARDIA:  3/3"),
            Container(
              margin: const EdgeInsets.only(top: 40),
              child: Center(
                child: TextButton(
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
                  onPressed: () {},
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Color _percentageColor() {
    if (widget.percentege >= 90) {
      return const Color(0xFF22DE8F);
    } else if (widget.percentege >= 45) {
      return const Color(0xFFFED546);
    } else {
      return const Color(0xFFFE4646);
    }
  }

  Widget _buildResultField(String text) {
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
        text,
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
