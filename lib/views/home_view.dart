import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mansi_lathiya_portfolio/controllers/portfolio_controller.dart';
import 'package:mansi_lathiya_portfolio/utils/app_colors.dart';
import 'package:mansi_lathiya_portfolio/utils/app_constants.dart';
import 'package:mansi_lathiya_portfolio/utils/portfolio_data.dart';
import 'package:mansi_lathiya_portfolio/views/sections/about_section.dart';
import 'package:mansi_lathiya_portfolio/views/sections/contact_section.dart';
import 'package:mansi_lathiya_portfolio/views/sections/experience_section.dart';
import 'package:mansi_lathiya_portfolio/views/sections/hero_section.dart';
import 'package:mansi_lathiya_portfolio/views/sections/projects_section.dart';
import 'package:mansi_lathiya_portfolio/views/sections/skills_section.dart';
import 'package:mansi_lathiya_portfolio/widgets/footer.dart';
import 'package:mansi_lathiya_portfolio/widgets/navbar.dart';

class HomeView extends GetView<PortfolioController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            // Scrollable content
            SingleChildScrollView(
              controller: controller.scrollController,
              child: Column(
                children: [
                  const SizedBox(height: 68),
                  KeyedSubtree(
                    key: controller.sectionKeys[0],
                    child: HeroSection(
                      onViewProjects: () => controller.navigateTo(3),
                    ),
                  ),
                  KeyedSubtree(
                    key: controller.sectionKeys[1],
                    child: const AboutSection(),
                  ),
                  KeyedSubtree(
                    key: controller.sectionKeys[2],
                    child: const SkillsSection(),
                  ),
                  KeyedSubtree(
                    key: controller.sectionKeys[3],
                    child: const ProjectsSection(),
                  ),
                  KeyedSubtree(
                    key: controller.sectionKeys[4],
                    child: const ExperienceSection(),
                  ),
                  KeyedSubtree(
                    key: controller.sectionKeys[5],
                    child: const ContactSection(),
                  ),
                  const Footer(),
                ],
              ),
            ),
            // Fixed NavBar
            const Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: RepaintBoundary(child: NavBar()),
            ),
            // Mobile drawer
            Obx(() {
              if (!controller.isMenuOpen.value) return const SizedBox.shrink();
              return _MobileDrawer(onClose: controller.closeMenu);
            }),
          ],
        ),
        // Back-to-top FAB
        floatingActionButton: RepaintBoundary(
          child: Obx(
            () => AnimatedScale(
              scale: controller.showScrollTop.value ? 1.0 : 0.0,
              duration: AppConstants.duration220,
              child: FloatingActionButton.small(
                backgroundColor: AppColors.primary,
                onPressed: controller.scrollToTop,
                child: const Icon(
                  Icons.keyboard_arrow_up_rounded,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// Mobile drawer
class _MobileDrawer extends GetView<PortfolioController> {
  final VoidCallback onClose;
  const _MobileDrawer({required this.onClose});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: onClose,
      child: Container(
        color: Colors.black54,
        alignment: Alignment.topRight,
        child: Container(
          width: 260,
          height: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 60),
          color: isDark ? AppColors.darkSurface : AppColors.lightSurface,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ShaderMask(
                shaderCallback: (b) =>
                    AppColors.primaryGradient.createShader(b),
                child: Text(
                  'Menu',
                  style: GoogleFonts.poppins(
                    fontSize: 22,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 32),
              ...List.generate(
                PortfolioData.navItems.length,
                (index) => ListTile(
                  contentPadding: EdgeInsets.zero,
                  dense: true,
                  leading: Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      PortfolioData.navItems[index].$1,
                      size: 16,
                      color: AppColors.primary,
                    ),
                  ),
                  title: Text(
                    PortfolioData.navItems[index].$2,
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                    ),
                  ),
                  onTap: () {
                    onClose();
                    Future.delayed(
                      AppConstants.duration250,
                      () => controller.navigateTo(index),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
