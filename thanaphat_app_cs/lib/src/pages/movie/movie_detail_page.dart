import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:thanaphat_app_cs/src/model/upcoming_movie_model.dart';
import 'package:thanaphat_app_cs/src/pages/config/app_route.dart';

class MovieDetailPage extends StatefulWidget {
  const MovieDetailPage({super.key});

  @override
  State<MovieDetailPage> createState() => _MovieDetailPageState();
}

enum TtsState { playing, stopped, paused, continued }

class _MovieDetailPageState extends State<MovieDetailPage> {
  late FlutterTts flutterTts;
  Result? _movieModel;

  @override
  void initState() {
    _movieModel = Result();
    initTts();
    super.initState(); //
  }

  @override
  Widget build(BuildContext context) {
    Object? args = ModalRoute.of(context)?.settings.arguments;
    if (args is Result) {
      _movieModel = args;
    }
    return Scaffold(
      appBar: AppBar(title: Text(_movieModel?.title ?? '')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Card(
              margin: EdgeInsets.all(20),
              elevation: 10,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              child: Image.network(
                'https://image.tmdb.org/t/p/w500${_movieModel?.posterPath ?? ''}',
              ),
            ),
            Text('Popularity${_movieModel?.popularity?.toString() ?? ''}'),
            Card(
              color: Colors.indigoAccent.shade100,
              child: Column(
                children: [
                  Text(
                    '\nOverview',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    width: 200,
                    child: Divider(color: Colors.indigo, thickness: 2),
                  ),
                  Text(
                    _movieModel?.overview ?? '',
                    style: TextStyle(fontSize: 16, color: Colors.grey.shade50),
                  ),
                  OverflowBar(
                    alignment: MainAxisAlignment.start,
                    children: [
                      IconButton(
                        onPressed: () {
                          _speak(_movieModel?.overview ?? '');
                        },
                        icon: Icon(Icons.volume_down_alt, color: Colors.white),
                      ),
                      IconButton(
                        onPressed: () {
                          _pause();
                        },
                        icon: Icon(Icons.pause, color: Colors.white),
                      ),
                      IconButton(
                        onPressed: () {
                          _stop();
                        },
                        icon: Icon(Icons.volume_off, color: Colors.white),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.share, color: Colors.white),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(
            context,
            AppRoute.videoRoute,
            arguments: _movieModel?.id,
          );
        },
        backgroundColor: Colors.orange,
        child: Icon(Icons.video_library_outlined),
      ),
    );
  }

  double volume = 0.8;
  double pitch = 1.0;
  double rate = 0.5;
  String? _newVoiceText;
  TtsState ttsState = TtsState.stopped;

  bool get isPlaying => ttsState == TtsState.playing;

  bool get isStopped => ttsState == TtsState.stopped;

  bool get isPaused => ttsState == TtsState.paused;

  bool get isContinued => ttsState == TtsState.continued;

  void initTts() {
    flutterTts = FlutterTts();

    _setAwaitOptions();

    flutterTts.setStartHandler(() {
      setState(() {
        print("Playing");
        ttsState = TtsState.playing;
      });
    });

    flutterTts.setCompletionHandler(() {
      setState(() {
        print("stopped");
        ttsState = TtsState.stopped;
      });
    });

    flutterTts.setCancelHandler(() {
      setState(() {
        print("cancel");
        ttsState = TtsState.stopped;
      });
    });

    flutterTts.setPauseHandler(() {
      setState(() {
        print("Paused");
        ttsState = TtsState.paused;
      });
    });

    flutterTts.setContinueHandler(() {
      setState(() {
        print("Continued");
        ttsState = TtsState.continued;
      });
    });

    flutterTts.setErrorHandler((msg) {
      setState(() {
        print("Continued");
        ttsState = TtsState.stopped;
      });
    });
  }

  Future<void> _speak(String text) async {
    _newVoiceText = text;
    await flutterTts.setVolume(volume);
    await flutterTts.setSpeechRate(rate);
    await flutterTts.setPitch(pitch);

    if (_newVoiceText != null) {
      if (_newVoiceText!.isNotEmpty) {
        await flutterTts.speak(_newVoiceText!);
      }
    }
  }

  Future<void> _setAwaitOptions() async {
    await flutterTts.awaitSpeakCompletion(true);
  }

  Future<void> _stop() async {
    var result = await flutterTts.stop();
    if (result == 1) setState(() => ttsState = TtsState.stopped);
  }

  Future<void> _pause() async {
    var result = await flutterTts.pause();
    if (result == 1) setState(() => ttsState = TtsState.paused);
  }

  @override
  void dispose() {
    super.dispose();
    flutterTts.stop();
  }
}
