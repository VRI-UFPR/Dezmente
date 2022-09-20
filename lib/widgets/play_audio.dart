// import 'package:flutter/material.dart';
// import 'package:audioplayers/audioplayers.dart';

// class PlayAudio extends StatefulWidget {
//   final String audioFile;
//   final double iconSize;
//   const PlayAudio({Key? key, required this.audioFile, this.iconSize = 45})
//       : super(key: key);

//   @override
//   State<PlayAudio> createState() => _PlayAudioState();
// }

// class _PlayAudioState extends State<PlayAudio> {
//   bool _playing = false;

//   late final AudioPlayer _player;

//   late final AudioCache _audioCache;

//   Future play() async {
//     await _audioCache.play(widget.audioFile, volume: 2.0);
//   }

//   Future stop() async {
//     await _player.stop();
//   }

//   @override
//   void initState() {
//     super.initState();
//     _player = AudioPlayer();
//     _audioCache = AudioCache(fixedPlayer: _player, prefix: "assets/audio/");
//     _player.onPlayerStateChanged.listen(
//         (event) => setState(() => _playing = event == PlayerState.PLAYING));
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//         padding: const EdgeInsets.symmetric(vertical: 10),
//         width: widget.iconSize, // you can adjust the width as you need
//         child: IconButton(
//             icon: Icon(
//               _playing == true ? Icons.stop_circle : Icons.play_circle,
//               color: const Color(0xFF569DB3),
//             ),
//             iconSize: widget.iconSize,
//             padding: EdgeInsets.zero,
//             constraints: const BoxConstraints(),
//             onPressed: _playing ? stop : play));
//   }
// }
