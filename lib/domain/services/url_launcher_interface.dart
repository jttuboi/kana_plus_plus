abstract class IUrlLauncher {
  Future<void> openUrl(String url);
  Future<void> sendEmail();
}
