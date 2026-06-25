import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mansi_lathiya_portfolio/bindings/app_binding.dart';
import 'package:mansi_lathiya_portfolio/services/storage_service.dart';
import 'package:mansi_lathiya_portfolio/services/theme_service.dart';
import 'package:mansi_lathiya_portfolio/utils/app_scroll_behavior.dart';
import 'package:mansi_lathiya_portfolio/utils/app_theme.dart';
import 'package:mansi_lathiya_portfolio/views/home_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _bootstrap();
  runApp(const PortfolioApp());
}

Future<void> _bootstrap() async {
  final (storage, _) = await (StorageService.init(), _lockOrientation()).wait;
  // Register in dependency order.
  Get.put<StorageService>(storage, permanent: true);
  Get.put<ThemeService>(ThemeService(storage), permanent: true);
  // UrlService + PortfolioController wired via binding.
  AppBinding().dependencies();
}

Future<void> _lockOrientation() async {
  if (kIsWeb) {
    return;
  }
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);
}

// Root widget
class PortfolioApp extends StatelessWidget {
  const PortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Get.find<ThemeService>().isDark;
    return GetMaterialApp(
      title: "Mansi Lathiya | Flutter Developer",
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: isDark ? ThemeMode.dark : ThemeMode.light,
      scrollBehavior: const AppScrollBehavior(),
      builder: (context, child) => MediaQuery(
        data: MediaQuery.of(context).copyWith(textScaler: TextScaler.noScaling),
        child: child!,
      ),
      home: const HomeView(),
    );
  }
}
