import 'dart:async';

import 'package:audioplayers/audioplayers.dart';

class AudioPlayMusic {
  final String fileName;
  final _progressStreamController = StreamController<double>();
  late final AudioPlayer _audioPlayer;
  late final StreamSubscription _progressSubscription;
  late int _audioDurationMs;
  AudioPlayMusic(this.fileName);
  Stream<double> get progressStream => _progressStreamController.stream;
  Stream<PlayerState> get stateStream => _audioPlayer.onPlayerStateChanged;
  Future<void> init() async {
    _audioPlayer = await AudioCache().play(fileName);
    await Future.delayed(Duration(milliseconds: 200));
    _audioDurationMs = await _audioPlayer.getDuration();
    await _audioPlayer.stop();
    _progressStreamController.add(0.0);
    _progressSubscription =
        _audioPlayer.onAudioPositionChanged.listen((duration) {
      _progressStreamController.add(duration.inMilliseconds / _audioDurationMs);
    });
  }

  Future<void> dispose() => Future.wait([
        _audioPlayer.dispose(),
        _progressSubscription.cancel(),
        _progressStreamController.close()
      ]);
  Future<void> play() => _audioPlayer.resume();
  Future<void> pause() => _audioPlayer.pause();
  Future<void> reset() async {
    _audioPlayer.stop();
    _progressStreamController.add(0.0);
  }
}
