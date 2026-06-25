import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:mansi_lathiya_portfolio/services/theme_service.dart';
import 'package:mansi_lathiya_portfolio/services/url_service.dart';
import 'package:mansi_lathiya_portfolio/utils/app_constants.dart';
import 'package:mansi_lathiya_portfolio/utils/portfolio_data.dart';

class PortfolioController extends GetxController {
  PortfolioController({required this.savedIsDark});

  final bool savedIsDark;

  // Injected services
  final _theme = Get.find<ThemeService>();
  final _url = Get.find<UrlService>();

  // Reactive UI state
  late final RxBool isDark;
  final RxInt currentSection = 0.obs;
  final RxBool isMenuOpen = false.obs;
  final RxBool showScrollTop = false.obs;
  final RxString selectedFilter = "All".obs;

  // Static data (const refs — never allocated twice)
  final projects = PortfolioData.projectsList;
  final skills = PortfolioData.skillCategoriesList;
  final experiences = PortfolioData.experiencesList;
  final sections = PortfolioData.sectionsList;
  // final projectFilters = PortfolioData.projectFiltersList;

  // Scroll
  final scrollController = ScrollController();
  final List<GlobalKey> sectionKeys = List.generate(6, (_) => GlobalKey());
  double _lastScrollOffset = 0;
  bool _scrollCallbackPending = false;

  // // Derived
  // List<ProjectModel> get filteredProjects {
  //   final f = selectedFilter.value;
  //   if (f == "All") return projects;
  //   return projects.where((p) => _matchesFilter(p, f)).toList();
  // }

  // bool _matchesFilter(ProjectModel p, String f) => switch (f) {
  //   "iOS"            => p.platform.contains("iOS")     && !p.platform.contains("Android"),
  //   "Android"        => p.platform.contains("Android") && !p.platform.contains("iOS"),
  //   "Cross-Platform" => p.platform.contains("Android") &&  p.platform.contains("iOS"),
  //   "Web"            => p.platform.contains("Web"),
  //   _                => true,
  // };

  // Lifecycle
  @override
  void onInit() {
    super.onInit();
    isDark = savedIsDark.obs;
    scrollController.addListener(_onScroll);
  }

  @override
  void onClose() {
    scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.onClose();
  }

  // Theme
  Future<void> toggleTheme() async {
    isDark.value = !isDark.value;
    await _theme.saveTheme(isDark.value);
  }

  // Navigation
  void navigateTo(int index) {
    currentSection.value = index;
    isMenuOpen.value = false;
    _scrollToSection(index);
  }

  void toggleMenu() => isMenuOpen.value = !isMenuOpen.value;
  void closeMenu() => isMenuOpen.value = false;

  void scrollToTop() {
    if (!scrollController.hasClients) return;
    scrollController.animateTo(
      0,
      duration: AppConstants.duration600,
      curve: Curves.easeInOutCubic,
    );
  }

  // // Filter
  // void setFilter(String filter) => selectedFilter.value = filter;

  // URL / Resume
  Future<void> launchURL(String url) => _url.launch(url);
  Future<void> downloadResume() => _url.downloadResume();

  // Scroll internals
  void _scrollToSection(int index) {
    if (!scrollController.hasClients) return;
    final currentContext = sectionKeys[index].currentContext;
    if (currentContext == null) return;
    final box = currentContext.findRenderObject() as RenderBox?;
    if (box == null || !box.hasSize) {
      Scrollable.ensureVisible(
        currentContext,
        duration: AppConstants.duration600,
        curve: Curves.easeInOutCubic,
      );
      return;
    }
    final viewport = RenderAbstractViewport.maybeOf(box);
    if (viewport == null) {
      Scrollable.ensureVisible(
        currentContext,
        duration: AppConstants.duration600,
        curve: Curves.easeInOutCubic,
      );
      return;
    }
    final target = (viewport.getOffsetToReveal(box, 0.0).offset - 70).clamp(
      scrollController.position.minScrollExtent,
      scrollController.position.maxScrollExtent,
    );
    scrollController.animateTo(
      target,
      duration: AppConstants.duration600,
      curve: Curves.easeInOutCubic,
    );
  }

  void _onScroll() {
    if (!scrollController.hasClients) return;
    final offset = scrollController.offset;
    if ((offset - _lastScrollOffset).abs() < 4) return;
    _lastScrollOffset = offset;
    if (_scrollCallbackPending) return;
    _scrollCallbackPending = true;
    SchedulerBinding.instance.addPostFrameCallback((_) {
      _scrollCallbackPending = false;
      if (!scrollController.hasClients) return;
      showScrollTop.value = scrollController.offset > 400;
      _updateActiveSection();
    });
  }

  void _updateActiveSection() {
    for (var index = sectionKeys.length - 1; index >= 0; index--) {
      final currentContext = sectionKeys[index].currentContext;
      if (currentContext == null) continue;
      final box = currentContext.findRenderObject() as RenderBox?;
      if (box == null || !box.hasSize) continue;
      if (box.localToGlobal(Offset.zero).dy <= 120) {
        if (currentSection.value != index) currentSection.value = index;
        return;
      }
    }
  }
}
