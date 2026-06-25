import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:mansi_lathiya_portfolio/utils/portfolio_data.dart';
import 'package:url_launcher/url_launcher.dart';

/// Handles every external URL launch and the resume download.
class UrlService extends GetxService {
  Future<void> launch(String url) async {
    if (url.isEmpty) return;
    final uri = Uri.tryParse(url);
    if (uri == null) return;
    try {
      await launchUrl(
        uri,
        mode: url.startsWith("mailto:") || url.startsWith("tel:")
            ? LaunchMode.platformDefault
            : LaunchMode.externalApplication,
      );
    } catch (_) {}
  }

  Future<void> downloadResume() async {
    var url = PortfolioData.resumeUrl;
    if (kIsWeb && !url.startsWith("http")) url = '${Uri.base.origin}/$url';
    await launch(url);
  }
}
