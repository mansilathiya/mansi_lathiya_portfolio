import 'package:get/get.dart';
import 'package:mansi_lathiya_portfolio/controllers/portfolio_controller.dart';
import 'package:mansi_lathiya_portfolio/services/theme_service.dart';
import 'package:mansi_lathiya_portfolio/services/url_service.dart';

/// Registers dependencies in strict order:
class AppBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<UrlService>(UrlService(), permanent: true);
    Get.put<PortfolioController>(
      PortfolioController(savedIsDark: Get.find<ThemeService>().isDark),
      permanent: true,
    );
  }
}
