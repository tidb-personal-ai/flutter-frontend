import 'package:animated_music_indicator/animated_music_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:lumios/providers/audio_provider.dart';
import 'package:lumios/providers/audio_screen_state_provider.dart';
import 'package:lumios/providers/audio_state_provider.dart';
import 'package:lumios/widgets/hold_button.dart';

class AudioScreen extends ConsumerWidget {
  const AudioScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(audioMessageStateProvider, (previous, next) async {
      startPlayback(ref);
    });
    const backgroundColor = Color.fromARGB(255, 20, 20, 20);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      backgroundColor: backgroundColor,
      body: Center(
        child: Consumer(builder: (context, ref, child) {
            final state = ref.watch(audioScreenStateProvider);
            switch (state) {
              case AudioScreenState.loading:
                return const CircularProgressIndicator();
              case AudioScreenState.error:
                return const Text('Error');
              default:
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AnimatedMusicIndicator(
                      animate: ref.watch(audioIsPlayingProvider),
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
                    const SizedBox(height: 20),
                    Text(ref.watch(audioScreenStateProvider).name, style: const TextStyle(color: Colors.white, fontSize: 20),),
                  ],
                );
            }
          },
        ),
      ),
      floatingActionButton: Consumer(builder: (context, ref, child) {
          final state = ref.watch(audioScreenStateProvider);
          switch (state) {
            case AudioScreenState.loading:
            case AudioScreenState.error:
              return Container();
            default:
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  FloatingActionButton(
                    onPressed: 
                      ref.watch(audioMessageAvailableProvider) && 
                      ref.watch(audioIsIdleProvider) 
                        ? () => startPlayback(ref) 
                        : null,
                    shape: const StadiumBorder(),
                    backgroundColor: 
                      ref.watch(audioMessageAvailableProvider) && 
                      ref.watch(audioIsIdleProvider) 
                        ? Theme.of(context).primaryColorDark 
                        : Theme.of(context).disabledColor,
                    child: Icon(Icons.replay, color: Theme.of(context).primaryColorLight,),
                  ),
                  const SizedBox(width: 24,),
                  HoldButton(
                    onStarted: () => startRecording(ref), 
                    onStopped: () => stopRecording(ref),
                    backgroundColor: 
                      ref.watch(audioIsIdleOrRecordingProvider)
                        ? Theme.of(context).primaryColorDark 
                        : Theme.of(context).disabledColor,
                    enabled: ref.watch(audioIsIdleOrRecordingProvider),
                    child: Icon(Icons.mic, color: Theme.of(context).primaryColorLight,),
                  ),
                ],
              );
          }
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,    
    );
  }
  
  Future<void> startRecording(WidgetRef ref) async {
    final audio = await ref.read(audioControllerProvider.future);
    await audio.startRecorder();
    ref.read(audioScreenStateProvider.notifier).state = AudioScreenState.recording;
  }

  Future<void> stopRecording(WidgetRef ref) async {
    final audio = await ref.read(audioControllerProvider.future);
    final recorderKey = await audio.stopRecorder();
    ref.read(audioScreenStateProvider.notifier).state = AudioScreenState.sending;
    await ref.read(audioMessageStateProvider.notifier).sendMessage(recorderKey);
    ref.read(audioScreenStateProvider.notifier).state = AudioScreenState.waitingForResponse;
  }

  Future<void> startPlayback(WidgetRef ref) async {
    final latestMessage = ref.read(audioMessageStateProvider);
    if (latestMessage != null) {
      final audio = await ref.read(audioControllerProvider.future);
      ref.read(audioScreenStateProvider.notifier).state = AudioScreenState.playing;

      var codec = Codec.aacADTS;
      switch (latestMessage.mimeType) {
        case 'audio/ogg; codecs=opus':
          codec = Codec.opusOGG;
          break;
        case 'audio/ogg':
          codec = Codec.vorbisOGG;
          break;
        case 'audio/mp3':
          codec = Codec.mp3;
          break;
        default:
          throw Exception('Unknown mime type ${latestMessage.mimeType}');
      }

      audio.startPlayer(
        fromDataBuffer: latestMessage.data,
        whenFinished: () => ref.read(audioScreenStateProvider.notifier).state = AudioScreenState.idle,
        codec: codec,
      );
    }
  }
}


