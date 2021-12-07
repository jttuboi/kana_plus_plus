import 'dart:developer';

import 'package:kwriting/domain/domain.dart';
import 'package:url_launcher/url_launcher.dart';

class UrlLauncher implements IUrlLauncher {
  @override
  Future<void> openUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      // do nothing
      log('Could not launch $url');
    }
  }

  @override
  Future<void> sendEmail() async {
    final emailLaunchUri = Uri(
      scheme: 'mailto',
      path: Developer.contact,
      query: _encodeQueryParameters({'subject': Default.contactSubject}),
    );
    await launch(emailLaunchUri.toString());
  }

  String? _encodeQueryParameters(Map<String, String> params) {
    return params.entries.map((entry) => '${Uri.encodeComponent(entry.key)}=${Uri.encodeComponent(entry.value)}').join('&');
  }
}
