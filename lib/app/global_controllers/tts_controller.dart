import 'dart:async';
import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:ottaa_project_flutter/app/global_controllers/data_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum TTSState { playing, stopped, paused, continued }

class TTSController extends GetxController {
  late FlutterTts _flutterTTS;
  String _language = Get.locale!.languageCode;
  final _dataController = Get.find<DataController>();

  String get languaje => _language;

  set languaje(value) {
    _language = value;
  }

  late bool _isEnglish;

  bool get isEnglish => _isEnglish;

  set isEnglish(value) {
    _isEnglish = value;
  }

  bool _isCustomTTSEnable = false;

  bool get isCustomTTSEnable => _isCustomTTSEnable;

  set isCustomTTSEnable(value) {
    _isCustomTTSEnable = value;
  }

  bool _isCustomSubtitle = false;

  bool get isCustomSubtitle => _isCustomSubtitle;

  set isCustomSubtitle(value) {
    _isCustomSubtitle = value;
  }

  bool _isSubtitleUppercase = false;

  bool get isSubtitleUppercase => _isSubtitleUppercase;

  set isSubtitleUppercase(value) {
    _isSubtitleUppercase = value;
  }

  // ignore: unused_field
  String? _engine;

  double _volume = 0.8;

  double get volume => _volume;

  int _subtitleSize = 2;

  int get subtitleSize => _subtitleSize;

  set setVolume(value) {
    _volume = value;
  }

  set subtitleSize(value) {
    _subtitleSize = value;
  }

  double _pitch = 1.0;

  double get pitch => _pitch;

  set pitch(value) {
    _pitch = value;
  }

  double _rate = 0.4;

  double get rate => _rate;

  set rate(value) {
    _rate = value;
  }

  // bool isCurrentLanguageInstalled = false;

  TTSState _ttsState = TTSState.stopped;

  get isPlaying => _ttsState == TTSState.playing;

  get isStopped => _ttsState == TTSState.stopped;

  get isPaused => _ttsState == TTSState.paused;

  get isContinued => _ttsState == TTSState.continued;

  bool get isIOS => !kIsWeb && Platform.isIOS;

  bool get isAndroid => !kIsWeb && Platform.isAndroid;

  bool get isWeb => kIsWeb;

  @override
  void onInit() async {
    _initTTS();
    final instance = await SharedPreferences.getInstance();
    _isEnglish = instance.getBool('Language_KEY') ?? false;
    super.onInit();
  }

  @override
  void onClose() {
    _flutterTTS.stop();
    super.onClose();
  }

  _initTTS() {
    _flutterTTS = FlutterTts();

    if (isAndroid) {
      _getDefaultEngine();
    }

    _flutterTTS.setStartHandler(() {
      print("Playing");
      _ttsState = TTSState.playing;
    });

    _flutterTTS.setCompletionHandler(() {
      print("Complete");
      _ttsState = TTSState.stopped;
    });

    _flutterTTS.setCancelHandler(() {
      print("Cancel");
      _ttsState = TTSState.stopped;
    });

    if (isWeb || isIOS) {
      _flutterTTS.setPauseHandler(() {
        print("Paused");
        _ttsState = TTSState.paused;
      });

      _flutterTTS.setContinueHandler(() {
        print("Continued");
        _ttsState = TTSState.continued;
      });
    }

    _flutterTTS.setErrorHandler((msg) {
      print("error: $msg");
      _ttsState = TTSState.stopped;
    });
  }

  // Future<dynamic> _getLanguages() => flutterTts.getLanguages;

  // Future<dynamic> _getEngines() => flutterTts.getEngines;

  Future _getDefaultEngine() async {
    _engine = await _flutterTTS.getDefaultEngine;
  }

  Future speak(String voiceText) async {
    if (voiceText.isNotEmpty) {
      await _flutterTTS.setVolume(_volume);
      // TODO CREATE DEFAULT VALUES
      if (isCustomTTSEnable) {
        await _flutterTTS.setSpeechRate(_rate);
        await _flutterTTS.setPitch(_pitch);
      } else {
        await _flutterTTS.setSpeechRate(0.4);
        await _flutterTTS.setPitch(1.0);
      }
      await _flutterTTS.awaitSpeakCompletion(true);
      await _flutterTTS.setLanguage(_language);

      // TODO The flutter_tts plugin for web doesn't implement the method 'getVoices'
      // var voice = await this._flutterTTS.getVoices;
      // print(voice.where((element) => element["locale"] == "es-US"));
      // await this
      //     ._flutterTTS
      //     .setVoice({"name": "es-US-language", "locale": "es-US"});
      await _flutterTTS.speak(voiceText);
    }
  }

  Future speakPhrase(String voiceText) async {
    if (voiceText.isNotEmpty) {
      await _flutterTTS.setVolume(_volume);
      // TODO CREATE DEFAULT VALUES
      if (isCustomTTSEnable) {
        await _flutterTTS.setSpeechRate(_rate);
        await _flutterTTS.setPitch(_pitch);
      } else {
        await _flutterTTS.setSpeechRate(0.4);
        await _flutterTTS.setPitch(1.0);
      }
      await _flutterTTS.awaitSpeakCompletion(true);
      await _flutterTTS.setLanguage(_language);
      // await FirebaseAnalytics.instance.logEvent(name: "Talk");
      _dataController.logFirebaseAnalyticsEvent(eventName: 'Talk');
      // TODO The flutter_tts plugin for web doesn't implement the method 'getVoices'
      // var voice = await this._flutterTTS.getVoices;
      // print(voice.where((element) => element["locale"] == "es-US"));
      // await this
      //     ._flutterTTS
      //     .setVoice({"name": "es-US-language", "locale": "es-US"});
      await _flutterTTS.speak(voiceText);
    }
  }
}
