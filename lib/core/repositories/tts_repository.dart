abstract class TTSRepository {
  Future<void> speak(String text);

  Future<void> fetchVoices(String languageCode);
  Future<void> changeVoiceSpeed(double speed);
  Future<void> changeCustomTTs(bool value);
}
