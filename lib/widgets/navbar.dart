import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mansi_lathiya_portfolio/controllers/portfolio_controller.dart';
import 'package:mansi_lathiya_portfolio/utils/app_colors.dart';
import 'package:mansi_lathiya_portfolio/utils/app_constants.dart';
import 'package:mansi_lathiya_portfolio/utils/responsive_helper.dart';

class NavBar extends GetView<PortfolioController> {
  const NavBar({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDark;
    final isWide = context.responsive.isWide;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
      decoration: BoxDecoration(
        color: isDark
            ? AppColors.darkSurface.withValues(alpha: 0.95)
            : AppColors.lightSurface.withValues(alpha: 0.95),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.08),
            blurRadius: 20,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Logo
          MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: () => controller.navigateTo(0),
              child: ShaderMask(
                shaderCallback: (b) =>
                    AppColors.primaryGradient.createShader(b),
                child: Text(
                  "Mansi.",
                  style: GoogleFonts.poppins(
                    fontSize: 22,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                    letterSpacing: 1,
                  ),
                ),
              ),
            ),
          ),
          const Spacer(),
          // Desktop nav links
          if (isWide)
            Obx(
              () => Row(
                children: List.generate(controller.sections.length, (index) {
                  final isActive = controller.currentSection.value == index;
                  return TextButton(
                    onPressed: () => controller.navigateTo(index),
                    child: Text(
                      controller.sections[index],
                      style: GoogleFonts.poppins(
                        color: isActive
                            ? AppColors.primary
                            : (isDark
                                  ? AppColors.darkSubText
                                  : AppColors.lightSubText),
                        fontWeight: isActive
                            ? FontWeight.w700
                            : FontWeight.w500,
                        fontSize: 14,
                      ),
                    ),
                  );
                }),
              ),
            ),

          if (isWide) const SizedBox(width: 16),
          // Theme toggle
          Obx(() {
            final dark = controller.isDark.value;
            return MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: controller.toggleTheme,
                child: AnimatedContainer(
                  duration: AppConstants.duration300,
                  width: 56,
                  height: 28,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    gradient: LinearGradient(
                      colors: dark
                          ? [AppColors.primary, AppColors.primaryLight]
                          : [Colors.grey.shade300, Colors.grey.shade400],
                    ),
                  ),
                  child: AnimatedAlign(
                    duration: AppConstants.duration300,
                    alignment: dark
                        ? Alignment.centerRight
                        : Alignment.centerLeft,
                    child: Container(
                      margin: const EdgeInsets.all(3),
                      width: 22,
                      height: 22,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.2),
                            blurRadius: 4,
                          ),
                        ],
                      ),
                      child: Icon(
                        dark
                            ? Icons.dark_mode_rounded
                            : Icons.light_mode_rounded,
                        size: 14,
                        color: dark
                            ? AppColors.primary
                            : Colors.orange.shade400,
                      ),
                    ),
                  ),
                ),
              ),
            );
          }),
          // Mobile hamburger
          if (!isWide) ...[
            const SizedBox(width: 12),
            Obx(
              () => IconButton(
                icon: Icon(
                  controller.isMenuOpen.value
                      ? Icons.close_rounded
                      : Icons.menu_rounded,
                  color: isDark ? AppColors.darkText : AppColors.lightText,
                ),
                onPressed: controller.toggleMenu,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
