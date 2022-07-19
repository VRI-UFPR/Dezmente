import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_6.dart';

class HelpTemplateButton extends StatefulWidget {
  final String title;
  final String buttonText;
  final String description;
  final String audioFile;
  final VoidCallback callback;

  const HelpTemplateButton({
    required this.callback,
    Key? key,
    this.title = "Title",
    this.description = "Description",
    this.buttonText = "Subtitle",
    this.audioFile = "",
  }) : super(key: key);

  @override
  State<HelpTemplateButton> createState() => _HelpTemplateButtonState();
}

class _HelpTemplateButtonState extends State<HelpTemplateButton> {
  bool _playing = false;

  late final AudioPlayer _player;

  late final AudioCache _audioCache;

  Future play() async {
    await _audioCache.play("audiodezmente-38.mp3");
  }

  Future stop() async {
    await _player.stop();
  }

  @override
  void initState() {
    super.initState();
    _player = AudioPlayer();
    _audioCache = AudioCache(fixedPlayer: _player, prefix: "assets/audio/");
    _player.onPlayerStateChanged.listen(
        (event) => setState(() => _playing = event == PlayerState.PLAYING));
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeightFactor = MediaQuery.of(context).size.height / 640;
    //final double screenWidthFactor = MediaQuery.of(context).size.width / 360;
    return Scaffold(
      backgroundColor: const Color.fromARGB(200, 255, 255, 255),
      body: Stack(children: [
        Positioned(
          top: 10,
          right: 10,
          child: IconButton(
              icon: Icon(
                _playing == true ? Icons.stop_circle : Icons.play_circle,
              ),
              iconSize: 45,
              padding: const EdgeInsets.all(10),
              onPressed: _playing ? stop : play),
        ),
        Container(
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
                  widget.description,
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
                    onPressed: widget.callback,
                    style: ElevatedButton.styleFrom(
                      primary: const Color(0xffe984b8),
                      elevation: 5.0,
                    ),
                    child: Text(
                      widget.buttonText,
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
      ]),
    );
  }
}
