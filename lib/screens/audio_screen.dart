import 'package:animated_music_indicator/animated_music_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:lumios/providers/audio_provider.dart';
import 'package:lumios/widgets/hold_button.dart';

class AudioScreen extends ConsumerStatefulWidget {
  const AudioScreen({super.key});

  @override
  ConsumerState<AudioScreen> createState() => _AudioScreenState();
}

class _AudioScreenState extends ConsumerState<AudioScreen> {
  bool _isPlaying = false;

@override
  Widget build(BuildContext context) {
    final audio = ref.watch(audioControllerProvider);
    const backgroundColor = Color.fromARGB(255, 20, 20, 20);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      backgroundColor: backgroundColor,
      body: audio.when(
        data: (audio) => Center(
          child: AnimatedMusicIndicator(
            animate: _isPlaying,
            numberOfBars: 7,
            barStyle: BarStyle.dash,
            roundBars: false,
            colors: const [
              Color.fromARGB(255, 70, 76, 160),
              Color.fromARGB(255, 255, 219, 61),
              Color.fromARGB(255, 255, 219, 61),
              Color.fromARGB(255, 70, 76, 160),
              Color.fromARGB(255, 255, 219, 61),
              Color.fromARGB(255, 255, 219, 61),
              Color.fromARGB(255, 70, 76, 160),
            ],
          ),
        ),
        error: (error, stack) => Center(
          child: Text('Error $error'),
        ),
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
      ),
      floatingActionButton: audio.when(
        data: (audio) => Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          verticalDirection: VerticalDirection.down,
          children: [
            FloatingActionButton(
              onPressed: () {
                setState(() {
                  _isPlaying = true;
                });
                audio.player.startPlayer(
                  fromURI: 'tempAudio.webm',
                  whenFinished: () => setState(() {
                    _isPlaying = false;
                  }),
                );
              },
              shape: const StadiumBorder(),
              backgroundColor: Theme.of(context).primaryColorDark,
              child: Icon(Icons.replay, color: Theme.of(context).primaryColorLight,),
            ),
            const SizedBox(width: 24,),
            HoldButton(
              onStarted: () => audio.recorder.startRecorder(codec: Codec.opusWebM, toFile: 'tempAudio.webm'), 
              onStopped: () => audio.recorder.stopRecorder(), 
              icon: Icons.mic
            ),
          ],
        ),
        error: (error, stack) => Container(),
        loading: () => Container(),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,    
    );
  }
}
