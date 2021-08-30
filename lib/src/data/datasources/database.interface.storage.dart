abstract class IDatabaseStorage {
  Future<void> init();

  Future close();
}
