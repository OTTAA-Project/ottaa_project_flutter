abstract class Database {
  Future<void> init();
  Future<void> close();
}
