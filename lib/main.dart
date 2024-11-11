import 'dart:async';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const AudioJet(),
    );
  }
}

class AudioJet extends StatefulWidget {
  const AudioJet({super.key});

  @override
  State<AudioJet> createState() => _AudioJetState();
}

class _AudioJetState extends State<AudioJet> {
  final AudioPlayer audioPlayer = AudioPlayer();
  Duration? duration;
  Timer? timer;

  @override
  void initState() {
    audioPlayer.setAsset('assets/music.mp3').then((value) {
      duration = value;
      audioPlayer.play();
      audioPlayer.setLoopMode(LoopMode.all);
      audioPlayer.setVolume(1);
      timer = Timer.periodic(const Duration(milliseconds: 200), (timer) {
        setState(() {});
      });
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: ExactAssetImage(
                    'assets/lara_c.jpeg',
                  ),
                ),
              ),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                child: Container(
                  color: Colors.black.withOpacity(0.8),
                ),
              ),
            ),
          ),
          Positioned.fill(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 36, 0, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 24, right: 16),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: Image.asset(
                            'assets/lara_p.jpeg',
                            width: 70,
                          ),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        const Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Lara Fabian',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                '@larafabian',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 12),
                              )
                            ],
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            CupertinoIcons.heart,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 12, bottom: 0, left: 24, right: 24),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(24),
                      child: Image.asset(
                        'assets/lara_c.jpeg',
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(24, 8, 0, 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Lara Fabian',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'You Are Not From Here',
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                  if (duration != null)
                    Slider(
                      max: duration!.inMilliseconds.toDouble(),
                      value: audioPlayer.position.inMilliseconds.toDouble(),
                      onChangeStart: (value) {
                        audioPlayer.pause();
                      },
                      onChangeEnd: (value) {
                        audioPlayer.play();
                      },
                      onChanged: (value) {
                        audioPlayer.seek(Duration(milliseconds: value.toInt()));
                      },
                      inactiveColor: Colors.white.withOpacity(0.3),
                      activeColor: const Color.fromARGB(255, 38, 168, 59),
                      thumbColor: const Color.fromARGB(255, 57, 248, 89),
                    ),
                  Padding(
                    padding: const EdgeInsets.only(left: 24, right: 24),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          audioPlayer.position.toMinutesSeconds(),
                          style: const TextStyle(
                              color: Colors.white, fontSize: 12),
                        ),
                        Text(
                          duration!.toMinutesSeconds(),
                          style: const TextStyle(
                              color: Colors.white, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            CupertinoIcons.backward_fill,
                            color: Colors.white,
                          )),
                      const SizedBox(
                        width: 16,
                      ),
                      GestureDetector(
                        onTap: () {
                          if (audioPlayer.playing) {
                            audioPlayer.pause();
                          } else {
                            audioPlayer.play();
                          }
                        },
                        child: Container(
                            width: 56,
                            height: 56,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: LinearGradient(
                                  colors: [
                                    Color.fromARGB(255, 66, 255, 167),
                                    Color.fromARGB(255, 57, 248, 89)
                                  ],
                                  begin: Alignment.center,
                                  end: Alignment.bottomCenter),
                            ),
                            child: audioPlayer.playing
                                ? const Icon(
                                    CupertinoIcons.pause_fill,
                                    size: 32,
                                    color: Colors.white,
                                  )
                                : const Padding(
                                    padding: EdgeInsets.only(left: 4),
                                    child: Icon(
                                      CupertinoIcons.play_fill,
                                      size: 32,
                                      color: Colors.white,
                                    ),
                                  )),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            CupertinoIcons.forward_fill,
                            color: Colors.white,
                          )),
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

extension DurationExtensions on Duration {
// Convert the duration in to a readable string*
// 05 : 15*
  String toHoursMinutes() {
    String twoDigitMinutes = _toTwoDigits(inMinutes.remainder(60));
    return ' ${_toTwoDigits(inHours)} : $twoDigitMinutes ';
  }

// Convert the duration in to a readable string*
// 05 : 15 : 35*
  String toHoursMinutesSeconds() {
    String twoDigitMinutes = _toTwoDigits(inMinutes.remainder(60));
    String twoDigitSeconds = _toTwoDigits(inSeconds.remainder(60));
    return '${_toTwoDigits(inHours)} : $twoDigitMinutes : $twoDigitSeconds ';
  }

  String toMinutesSeconds() {
    String twoDigitMinutes = _toTwoDigits(inMinutes.remainder(60));
    String twoDigitSeconds = _toTwoDigits(inSeconds.remainder(60));
    return '$twoDigitMinutes:$twoDigitSeconds';
  }

  String _toTwoDigits(int n) {
    if (n >= 10) return '$n';
    return '0$n';
  }
}
