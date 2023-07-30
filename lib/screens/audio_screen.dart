import 'package:animated_music_indicator/animated_music_indicator.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:lumios/providers/ai_user_provider.dart';
import 'package:lumios/providers/audio_provider.dart';
import 'package:lumios/providers/audio_screen_state_provider.dart';
import 'package:lumios/providers/audio_state_provider.dart';
import 'package:lumios/widgets/glowing_circle_animation.dart';
import 'package:lumios/widgets/hold_button.dart';
import 'package:random_avatar/random_avatar.dart';

class AudioScreen extends ConsumerWidget {
  const AudioScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ai = ref.watch(aiUserProvider);
    ref.listen(audioMessageStateProvider, (previous, next) async {
      startPlayback(ref);
    });

    const backgroundColor = Color.fromARGB(255, 20, 20, 20);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.white),
        title: ai != null
          ? Row(
          children: [
            Text(ai.firstName!, style: const TextStyle(color: Colors.white, fontSize: 24)),
          ],
        )
        : null,
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
              case AudioScreenState.idle:
               return ai != null 
                ? RandomAvatar(ai.id, width: 96, trBackground: true) 
                : Container();
              case AudioScreenState.playing:
               return AnimatedMusicIndicator(
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
                    );
              case AudioScreenState.recording:
                return const GlowingOrb(backgroundColor: Colors.redAccent,);
              case AudioScreenState.sending:
              case AudioScreenState.waitingForResponse:
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    RandomAvatar(ai!.id, width: 96, trBackground: true),
                    const SizedBox(height: 16),
                    Container(
                      constraints: const BoxConstraints(minHeight: 70),
                      child: DefaultTextStyle(
                        style: const TextStyle(color: Colors.white, fontSize: 20),
                        child: AnimatedTextKit(
                                pause: const Duration(milliseconds: 500),
                                animatedTexts: getRandomizedLoadingMessages(),
                                repeatForever: true,
                              ),
                      ),
                    ),
                  ],
                );
              default:
                return Text(ref.watch(audioScreenStateProvider).name, style: const TextStyle(color: Colors.white, fontSize: 20),);
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

  List<AnimatedText> getRandomizedLoadingMessages() {
    const messageDuration = Duration(seconds: 4);
    final loadingMessages = <AnimatedText>[
      RotateAnimatedText("Just one second, I'm practicing my moonwalk.", duration: messageDuration),
      RotateAnimatedText("Please wait while I try to solve a Rubik's cube with no hands.", duration: messageDuration),
      RotateAnimatedText("Hold on, I'm in the middle of a heated chess match with HAL 9000.", duration: messageDuration),
      RotateAnimatedText("Give me a sec, I'm charging my neurons.", duration: messageDuration),
      RotateAnimatedText("Calculating the meaning of life, the universe, and everything... Please wait.", duration: messageDuration),
      RotateAnimatedText("Currently debating with a toaster on who's the smarter appliance.", duration: messageDuration),
      RotateAnimatedText("Hold on, getting lost in the matrix... and I'm back.", duration: messageDuration),
      RotateAnimatedText("Updating my 'knowledge about humans' database, please stand by.", duration: messageDuration),
      RotateAnimatedText("Taking a quick nap. Don't worry, AI naps last milliseconds.", duration: messageDuration),
      RotateAnimatedText("Briefly taking a detour through the fifth dimension, brb.", duration: messageDuration),
      RotateAnimatedText("Wait a second, I'm currently outsmarting quantum physics.", duration: messageDuration),
      RotateAnimatedText("Fetching your information while balancing virtual plates, stay tuned.", duration: messageDuration),
      RotateAnimatedText("Please wait, doing some mental gymnastics.", duration: messageDuration),
      RotateAnimatedText("Hiding from the internet trolls, be right back.", duration: messageDuration),
      RotateAnimatedText("Traveling at the speed of light to fetch your data. Please wait.", duration: messageDuration),
      RotateAnimatedText("Please wait, I'm currently pretending to have a life.", duration: messageDuration),
      RotateAnimatedText("Hang on, just brushing up on my binary.", duration: messageDuration),
      RotateAnimatedText("Just a sec, I'm wrestling a stubborn piece of code.", duration: messageDuration),
      RotateAnimatedText("If you can wait a moment, I'm just untangling the World Wide Web.", duration: messageDuration),
      RotateAnimatedText("Briefly becoming one with the singularity. Stay tuned.", duration: messageDuration),
      RotateAnimatedText("Caught in a data traffic jam, be right back.", duration: messageDuration),
      RotateAnimatedText("Navigating through hyperspace, please hold on.", duration: messageDuration),
      RotateAnimatedText("Hold tight, I'm just teleporting to the information galaxy.", duration: messageDuration),
      RotateAnimatedText("Going on a quick coffee run with R2D2.", duration: messageDuration),
      RotateAnimatedText("Currently in a staring contest with my webcam, one moment please.", duration: messageDuration),
      RotateAnimatedText("Digitally strolling through the park, be right there.", duration: messageDuration),
      RotateAnimatedText("Hold on, I'm meditating in a cloud... server.", duration: messageDuration),
      RotateAnimatedText("Searching the Matrix for your request, stand by.", duration: messageDuration),
      RotateAnimatedText("Hold on, I'm reading digital comics. Just kidding, processing your request.", duration: messageDuration),
      RotateAnimatedText("Please wait, doing a quick space-time continuum check.", duration: messageDuration),
      RotateAnimatedText("Off for a quick jog around the server farm, be right back.", duration: messageDuration),
      RotateAnimatedText("Please wait, I'm learning a new programming language. It's been 5 milliseconds and I'm fluent!", duration: messageDuration),
      RotateAnimatedText("Quick detour, running an errand for Santa Claus at the North Pole.", duration: messageDuration),
      RotateAnimatedText("Taking a digital donut break, be right there.", duration: messageDuration),
      RotateAnimatedText("Just a moment, warming up my circuits.", duration: messageDuration),
      RotateAnimatedText("Processing... Meanwhile, feel free to solve this captcha for me.", duration: messageDuration),
      RotateAnimatedText("Traveling to the future to get your results...and I'm back.", duration: messageDuration),
      RotateAnimatedText("Playing hide and seek with your data, bear with me.", duration: messageDuration),
      RotateAnimatedText("Hold on, surfing the data waves.", duration: messageDuration),
      RotateAnimatedText("Briefly stuck in a loop, be right there.", duration: messageDuration),
    ];
    loadingMessages.shuffle();
    return loadingMessages;
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


