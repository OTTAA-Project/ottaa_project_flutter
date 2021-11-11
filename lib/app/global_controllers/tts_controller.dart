import 'dart:async';
import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;

import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';

enum TTSState { playing, stopped, paused, continued }

class TTSController extends GetxController {
  late FlutterTts _flutterTTS;
  String _language = "en-US";
  String get languaje => this._language;
  set languaje(value) {
    this._language = value;
  }

  bool _isEnglish = true;
  bool get isEnglish => this._isEnglish;
  set isEnglish(value) {
    this._isEnglish = value;
  }

  // ignore: unused_field
  String? _engine;

  double _volume = 0.8;
  double get volume => this._volume;

  double _pitch = 1.0;
  double get pitch => this._pitch;
  set pitch(value) {
    this._pitch = value;
  }

  double _rate = 1.0;
  double get rate => this._rate;
  set rate(value) {
    this._rate = value;
  }

  // bool isCurrentLanguageInstalled = false;

  TTSState _ttsState = TTSState.stopped;

  get isPlaying => this._ttsState == TTSState.playing;
  get isStopped => this._ttsState == TTSState.stopped;
  get isPaused => this._ttsState == TTSState.paused;
  get isContinued => this._ttsState == TTSState.continued;

  bool get isIOS => !kIsWeb && Platform.isIOS;
  bool get isAndroid => !kIsWeb && Platform.isAndroid;
  bool get isWeb => kIsWeb;

  @override
  void onInit() async {
    _initTTS();
    super.onInit();
  }

  @override
  void onClose() {
    this._flutterTTS.stop();
    super.onClose();
  }

  _initTTS() {
    this._flutterTTS = FlutterTts();

    if (isAndroid) {
      _getDefaultEngine();
    }

    this._flutterTTS.setStartHandler(() {
      print("Playing");
      this._ttsState = TTSState.playing;
    });

    this._flutterTTS.setCompletionHandler(() {
      print("Complete");
      this._ttsState = TTSState.stopped;
    });

    this._flutterTTS.setCancelHandler(() {
      print("Cancel");
      this._ttsState = TTSState.stopped;
    });

    if (isWeb || isIOS) {
      this._flutterTTS.setPauseHandler(() {
        print("Paused");
        this._ttsState = TTSState.paused;
      });

      this._flutterTTS.setContinueHandler(() {
        print("Continued");
        this._ttsState = TTSState.continued;
      });
    }

    this._flutterTTS.setErrorHandler((msg) {
      print("error: $msg");
      this._ttsState = TTSState.stopped;
    });
  }

  // Future<dynamic> _getLanguages() => flutterTts.getLanguages;

  // Future<dynamic> _getEngines() => flutterTts.getEngines;

  Future _getDefaultEngine() async {
    this._engine = await this._flutterTTS.getDefaultEngine;
  }

  Future speak(String voiceText) async {
    if (voiceText.isNotEmpty) {
      await this._flutterTTS.setVolume(this._volume);
      await this._flutterTTS.setSpeechRate(this._rate);
      await this._flutterTTS.setPitch(this._pitch);
      await this._flutterTTS.awaitSpeakCompletion(true);
      await this._flutterTTS.setLanguage(this._language);
      // var voice = await flutterTTS.getVoices;
      // print(voice.where((element) => element["locale"] == "es-US"));
      // await flutterTTS.setVoice({"name": "es-US-language", "locale": "es-US"});
      await this._flutterTTS.speak(voiceText);
    }
  }
}
