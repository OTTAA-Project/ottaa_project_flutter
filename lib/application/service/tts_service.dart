import 'package:flutter_tts/flutter_tts.dart';
import 'package:injectable/injectable.dart';
import 'package:ottaa_project_flutter/application/common/i18n.dart';
import 'package:ottaa_project_flutter/core/models/voices_model.dart';
import 'package:ottaa_project_flutter/core/repositories/tts_repository.dart';

@Singleton(as: TTSRepository)
class TTSService extends TTSRepository {
  FlutterTts _tts = FlutterTts();

  @override
  FlutterTts get tts => _tts;

  @override
  set tts(value) => _tts = value;

  final I18N _i18n;
  String language = 'es_AR';
  List<dynamic> availableTTS = [];
  String voice = '';
  String name = '';
  String locale = '';

  bool customTTSEnable = false;

  double speechRate = .8;
  double pitch = 1.0;
  List<Voices> voices = [];

  TTSService(this._i18n) {
    initTTS();
  }

  @override
  Future<void> speak(String text) async {
    if (text.isNotEmpty) {
      // tts.cancelHandler?.call();
      if (customTTSEnable) {
        await tts.setVoice({"name": name, "locale": locale});
        language = _i18n.currentLocale.toString();
        await tts.setLanguage(language);
        await tts.setVolume(1.0);
        await tts.setSpeechRate(speechRate);
        await tts.setPitch(pitch);
      }
      await tts.setVoice({"name": name, "locale": locale});
      await tts.speak(text);
      // await tts.awaitSpeakCompletion(false);
    }
  }

  Future<void> initTTS() async {
    language = _i18n.currentLocale.toString();
    voices = await fetchVoices();
    await tts.setPitch(pitch);
    await tts.setSpeechRate(speechRate);
    await tts.setVolume(1.0);
    await tts.setLanguage(language);
    await tts.awaitSpeakCompletion(true);
    availableTTS = await tts.getLanguages;
  }

  @override
  Future<void> changeVoiceSpeed(double speed) async {
    speechRate = speed;
  }

  @override
  Future<List<Voices>> fetchVoices() async {
    final voices = await tts.getVoices;

    return voices.map<Voices>((e) => Voices.fromJson(Map.from(e))).toList();
  }

  @override
  Future<void> changeCustomTTs(bool value) async {
    customTTSEnable = value;
  }

  @override
  Future<void> changeTTSVoice(String voice) async {
    for (var element in voices) {
      if (element.name == voice) {
        locale = element.locale;
        name = element.name;
        print("here: ${element.name} == $voice");
      }
    }
  }

  Future<void> pause() async {
    await tts.pause();
  }

  @override
  Future<void> ttsStop() async {
    await tts.stop();
  }
}
