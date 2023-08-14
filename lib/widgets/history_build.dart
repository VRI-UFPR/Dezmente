import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_6.dart';

class HistoryBuilder extends StatefulWidget {
  final String history;
  final Color bgColor;

  const HistoryBuilder({
    Key? key,
    this.history = "",
    this.bgColor = const Color(0xFFB4EADF),
  }) : super(key: key);

  @override
  State<HistoryBuilder> createState() => _HistoryBuilderState();
}

class _HistoryBuilderState extends State<HistoryBuilder> {
  @override
  Widget build(BuildContext context) {
    final double scrHfactor = MediaQuery.of(context).size.height / 640;

    return Scaffold(
      body: Container(
        color: widget.bgColor,
        child: Column(
          children: [
            Container(
              height: 300 * scrHfactor,
              padding: const EdgeInsets.fromLTRB(10, 30, 10, 10),
              margin: const EdgeInsets.only(bottom: 20),
              color: Colors.white,
              child: Center(
                child: Text(
                  widget.history,
                  style: const TextStyle(
                    fontFamily: "Montserrat",
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            ChatBubble(
              clipper: ChatBubbleClipper6(
                radius: 40,
                nipSize: 10,
              ),
              elevation: 0,
              alignment: Alignment.center,
              backGroundColor: const Color(0xff8FDEE3),
              margin: const EdgeInsets.all(10.0),
              child: const Text(
                "Agora responda as perguntas:",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'montserrat',
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                  fontStyle: FontStyle.normal,
                  color: Colors.black,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 15),
              child: Align(
                alignment: Alignment.topLeft,
                child: Image.asset(
                  'assets/images/zunokansei.png',
                  height: 100 * scrHfactor,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(0, 20, 20, 0),
              child: Align(
                alignment: Alignment.topRight,
                child: OutlinedButton(
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
                        const Color(0xff569DB3)),
                  ),
                  onPressed: () {},
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "AVANÇAR",
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: "montserrat",
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        width: 70,
                      ),
                      Icon(
                        Icons.arrow_right_alt_outlined,
                        color: Colors.black,
                        size: 30,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
