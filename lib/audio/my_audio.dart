import 'package:just_audio/just_audio.dart';

class AudioModel {
  final AudioPlayer player = AudioPlayer();

  Future<void> setAudioSource(String url) async {
    await player.setFilePath(url);
  }

  Future<void> play() async {
    await player.play();
  }

  Future<void> pause() async {
    await player.pause();
  }
}
