import 'dart:async';
import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:ottaa_project_flutter/app/global_controllers/data_controller.dart';
import 'package:ottaa_project_flutter/app/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum TTSState { playing, stopped, paused, continued }

class TTSController extends GetxController {
  late FlutterTts _flutterTTS;
  late String _language;
  final _dataController = Get.find<DataController>();

  String get languaje => this._language;

  set languaje(value) {
    this._language = value;
  }

  bool _isCustomTTSEnable = false;

  bool get isCustomTTSEnable => this._isCustomTTSEnable;

  set isCustomTTSEnable(value) {
    this._isCustomTTSEnable = value;
  }

  bool _isCustomSubtitle = false;

  bool get isCustomSubtitle => this._isCustomSubtitle;

  set isCustomSubtitle(value) {
    this._isCustomSubtitle = value;
  }

  bool _isSubtitleUppercase = false;

  bool get isSubtitleUppercase => this._isSubtitleUppercase;

  set isSubtitleUppercase(value) {
    this._isSubtitleUppercase = value;
  }

  // ignore: unused_field
  String? _engine;

  double _volume = 0.8;

  double get volume => this._volume;

  int _subtitleSize = 2;

  int get subtitleSize => this._subtitleSize;

  set setVolume(value) {
    this._volume = value;
  }

  set subtitleSize(value) {
    this._subtitleSize = value;
  }

  double _pitch = 1.0;

  double get pitch => this._pitch;

  set pitch(value) {
    this._pitch = value;
  }

  double _rate = 0.4;

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
    final instance = await SharedPreferences.getInstance();
    final String languageKey = instance.getString('Language_KEY') ?? 'Spanish';
    _language = Constants.LANGUAGE_CODES[languageKey]!;
    print('the language is given here $_language');
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
      // TODO CREATE DEFAULT VALUES
      if (this.isCustomTTSEnable) {
        await this._flutterTTS.setSpeechRate(this._rate);
        await this._flutterTTS.setPitch(this._pitch);
      } else {
        await this._flutterTTS.setSpeechRate(0.4);
        await this._flutterTTS.setPitch(1.0);
      }
      await this._flutterTTS.awaitSpeakCompletion(true);
      await this._flutterTTS.setLanguage(this._language);

      // TODO The flutter_tts plugin for web doesn't implement the method 'getVoices'
      // var voice = await this._flutterTTS.getVoices;
      // print(voice.where((element) => element["locale"] == "es-US"));
      // await this
      //     ._flutterTTS
      //     .setVoice({"name": "es-US-language", "locale": "es-US"});
      await this._flutterTTS.speak(voiceText);
    }
  }

  Future speakPhrase(String voiceText) async {
    if (voiceText.isNotEmpty) {
      await this._flutterTTS.setVolume(this._volume);
      // TODO CREATE DEFAULT VALUES
      if (this.isCustomTTSEnable) {
        await this._flutterTTS.setSpeechRate(this._rate);
        await this._flutterTTS.setPitch(this._pitch);
      } else {
        await this._flutterTTS.setSpeechRate(0.4);
        await this._flutterTTS.setPitch(1.0);
      }
      await this._flutterTTS.awaitSpeakCompletion(true);
      await this._flutterTTS.setLanguage(this._language);
      // await FirebaseAnalytics.instance.logEvent(name: "Talk");
      _dataController.logFirebaseAnalyticsEvent(eventName: 'Talk');
      // TODO The flutter_tts plugin for web doesn't implement the method 'getVoices'
      // var voice = await this._flutterTTS.getVoices;
      // print(voice.where((element) => element["locale"] == "es-US"));
      // await this
      //     ._flutterTTS
      //     .setVoice({"name": "es-US-language", "locale": "es-US"});
      print(voiceText);
      await this._flutterTTS.speak(voiceText);
    }
  }
}
