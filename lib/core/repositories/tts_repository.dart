abstract class TTSRepository {
  Future<void> speak(String text);

  Future<void> fetchVoices(String languageCode);
}
