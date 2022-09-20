//import 'package:dezmente/widgets/play_audio.dart';
import 'package:dezmente/widgets/play_audio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_6.dart';

class HelpTemplateButton extends StatelessWidget {
  final String titleText;
  final String buttonText;
  final String description;
  final String audioFile;
  final VoidCallback callback;

  const HelpTemplateButton({
    required this.callback,
    Key? key,
    this.titleText = "Title",
    this.description = "Description",
    this.buttonText = "Subtitle",
    required this.audioFile,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double screenHeightFactor = MediaQuery.of(context).size.height / 640;
    final double screenWidthFactor = MediaQuery.of(context).size.width / 360;
    return Scaffold(
      appBar: AppBar(
        title: Text(titleText),
        backgroundColor: const Color(0xffe984b8),
        automaticallyImplyLeading: false,
      ),
      backgroundColor: const Color.fromARGB(235, 255, 255, 255),
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        //PlayAudio(audioFile: audioFile, iconSize: 65),
        SizedBox(height: screenHeightFactor * 50),
        ChatBubble(
          clipper: ChatBubbleClipper6(
            radius: 40,
            nipSize: 10,
          ),
          elevation: 0,
          alignment: Alignment.center,
          backGroundColor: const Color(0xff8FDEE3),
          margin: EdgeInsets.fromLTRB(screenWidthFactor * 125, 10, 25, 10),
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
        Padding(
          padding: EdgeInsets.fromLTRB(0, 0, screenWidthFactor * 120, 0),
          child: Image.asset(
            'assets/images/zunokansei.png',
            height: 100 * screenHeightFactor,
          ),
        ),
        SizedBox(height: screenHeightFactor * 50),
        ElevatedButton(
          onPressed: callback,
          style: ElevatedButton.styleFrom(
            primary: const Color(0xffe984b8),
            elevation: 3.0,
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
      ]),
    );
  }
}
