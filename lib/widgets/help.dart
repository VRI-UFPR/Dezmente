import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_6.dart';

class HelpTemplateButton extends StatelessWidget {
  final String title;
  final String buttonText;
  final String description;
  final VoidCallback callback;

  const HelpTemplateButton({
    required this.callback,
    Key? key,
    this.title = "Title",
    this.description = "Description",
    this.buttonText = "Subtitle",
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double screenHeightFactor = MediaQuery.of(context).size.height / 640;
    //final double screenWidthFactor = MediaQuery.of(context).size.width / 360;
    return Scaffold(
      backgroundColor: Colors.white70,
      body: Container(
        margin: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ChatBubble(
              clipper: ChatBubbleClipper6(
                radius: 40,
                nipSize: 10,
              ),
              elevation: 0,
              alignment: Alignment.center,
              backGroundColor: const Color(0xff8FDEE3),
              margin: const EdgeInsets.all(10.0),
              child: Text(
                description,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontFamily: 'montserrat',
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                  fontStyle: FontStyle.normal,
                  color: Colors.black,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/zunokansei.png',
                  height: 100 * screenHeightFactor,
                ),
                const Spacer(),
                ElevatedButton(
                  onPressed: callback,
                  style: ElevatedButton.styleFrom(
                    primary: const Color(0xffe984b8),
                    elevation: 5.0,
                  ),
                  child: Text(
                    buttonText,
                    style: const TextStyle(
                      fontFamily: 'montserrat',
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      fontStyle: FontStyle.normal,
                      color: Colors.black,
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
