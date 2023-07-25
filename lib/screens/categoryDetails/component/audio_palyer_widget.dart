import 'dart:async';

import 'package:baby_care/screens/categoryDetails/component/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

import '../../../constant/Dimensions/domensions.dart';
import '../../../constant/colors/colors.dart';
import '../../../model/audio_player.dart';

class AudioPlayerWidget extends StatefulWidget {
  const AudioPlayerWidget({Key? key}) : super(key: key);

  @override
  State<AudioPlayerWidget> createState() => _AudioPlayerWidgetState();
}

class _AudioPlayerWidgetState extends State<AudioPlayerWidget> {
  final player = AudioPlayMusic("audios/Twinkle.mp3");
  late final StreamSubscription progressSubscription;
  late final StreamSubscription stateSubscription;
  double progress = 0.0;
  PlayerState state = PlayerState.STOPPED;
  late final Future initFuture;
  @override
  void initState() {
    initFuture = player.init().then((_) {
      progressSubscription = player.progressStream.listen((event) {
        setState(() {
          progress = event;
        });
      });
      stateSubscription = player.stateStream.listen((event) {
        setState(() {
          state = event;
        });
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  bool isplay = true;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder<void>(
          future: initFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return Text("loading");
            }
            return GestureDetector(
              onTap: () {
                setState(() {
                  //player.play();
                  isplay = !isplay;
                });
                if (isplay == true) {
                  player.play();
                } else {
                  player.reset();
                }
              },
              child: Container(
                height: Dimensions.height45,
                width: Dimensions.screenWidth / 4,
                decoration: BoxDecoration(
                    color: AppColors.mainColor,
                    // border: Border.all(
                    //     width: 1, color: AppColors.mainBlackColor),
                    borderRadius: BorderRadius.circular(Dimensions.raduis15)),
                child: Center(
                  child: TextWidget(
                    text: isplay == true ? "play music" : "reset music",
                  ),
                ),
              ),
            );
          }),
    );
  }
}
