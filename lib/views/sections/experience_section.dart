import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mansi_lathiya_portfolio/models/portfolio_model.dart';
import 'package:mansi_lathiya_portfolio/utils/app_colors.dart';
import 'package:mansi_lathiya_portfolio/utils/app_constants.dart';
import 'package:mansi_lathiya_portfolio/utils/portfolio_data.dart';
import 'package:mansi_lathiya_portfolio/utils/responsive_helper.dart';
import 'package:mansi_lathiya_portfolio/widgets/common_widgets.dart';

class ExperienceSection extends StatelessWidget {
  const ExperienceSection({super.key});

  @override
  Widget build(BuildContext context) {
    final responsive = context.responsive;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isDesktop = responsive.isDesktop;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: responsive.hPad,
        vertical: responsive.sectionV,
      ),
      color: isDark
          ? AppColors.darkSurface.withValues(alpha: 0.5)
          : AppColors.lightCard.withValues(alpha: 0.5),
      child: Column(
        spacing: 60,
        children: [
          FadeInDown(
            child: const SectionTitle(
              title: "Work Experience",
              subtitle: "MY JOURNEY",
              description: "My professional journey in mobile development",
            ),
          ),
          isDesktop
              ? _DesktopTimeline(isDark: isDark)
              : _MobileTimeline(isDark: isDark),
        ],
      ),
    );
  }
}

// Desktop: alternating left / right cards
class _DesktopTimeline extends StatelessWidget {
  final bool isDark;
  const _DesktopTimeline({required this.isDark});

  @override
  Widget build(BuildContext context) {
    final currentObject = PortfolioData.experiencesList;
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 1200),
      child: Stack(
        children: [
          // Centre spine
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            bottom: 0,
            child: Center(
              child: Container(
                width: 2,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      AppColors.primary,
                      AppColors.accent,
                      AppColors.primary.withValues(alpha: 0.1),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Column(
            children: List.generate(currentObject.length, (index) {
              final isLeft = index.isEven;
              return FadeInUp(
                delay: Duration(milliseconds: index * 120),
                child: _DesktopRow(
                  exp: currentObject[index],
                  index: index,
                  isLeft: isLeft,
                  isDark: isDark,
                  isLast: index == currentObject.length - 1,
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}

class _DesktopRow extends StatelessWidget {
  final ExperienceModel exp;
  final int index;
  final bool isLeft;
  final bool isDark;
  final bool isLast;

  const _DesktopRow({
    required this.exp,
    required this.index,
    required this.isLeft,
    required this.isDark,
    required this.isLast,
  });

  @override
  Widget build(BuildContext context) {
    final card = _CardContent(experience: exp, isDark: isDark, isLeft: isLeft);
    final empty = const SizedBox();

    return Padding(
      padding: EdgeInsets.only(bottom: isLast ? 0 : 40),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Left side
          Expanded(child: isLeft ? card : empty),
          // Centre dot
          _CenterDot(index: index),
          // Right side
          Expanded(child: isLeft ? empty : card),
        ],
      ),
    );
  }
}

class _CenterDot extends StatelessWidget {
  final int index;
  const _CenterDot({required this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 48,
      height: 48,
      margin: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: const LinearGradient(
          colors: [AppColors.primary, AppColors.accent],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.4),
            blurRadius: 14,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Center(
        child: Text(
          "${index + 1}",
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontWeight: FontWeight.w800,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}

// Mobile: straight left-aligned timeline
class _MobileTimeline extends StatelessWidget {
  final bool isDark;
  const _MobileTimeline({required this.isDark});

  @override
  Widget build(BuildContext context) {
    final currentObject = PortfolioData.experiencesList;
    return Column(
      children: List.generate(currentObject.length, (index) {
        return FadeInUp(
          delay: Duration(milliseconds: index * 100),
          child: _MobileRow(
            experience: currentObject[index],
            index: index,
            isDark: isDark,
            isLast: index == currentObject.length - 1,
          ),
        );
      }),
    );
  }
}

class _MobileRow extends StatelessWidget {
  final ExperienceModel experience;
  final int index;
  final bool isDark;
  final bool isLast;

  const _MobileRow({
    required this.experience,
    required this.index,
    required this.isDark,
    required this.isLast,
  });

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        spacing: 16,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Dot + line
          SizedBox(
            width: 36,
            child: Column(
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: AppColors.primaryGradient,
                  ),
                  child: Center(
                    child: Text(
                      "${index + 1}",
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                        fontSize: 13,
                      ),
                    ),
                  ),
                ),
                if (!isLast)
                  Expanded(
                    child: Container(
                      width: 2,
                      margin: const EdgeInsets.symmetric(vertical: 4),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            AppColors.primary.withValues(alpha: 0.6),
                            AppColors.accent.withValues(alpha: 0.2),
                          ],
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: isLast ? 0 : 28),
              child: _CardContent(
                experience: experience,
                isDark: isDark,
                isLeft: true,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Shared card content
class _CardContent extends StatefulWidget {
  final ExperienceModel experience;
  final bool isDark;
  final bool isLeft;

  const _CardContent({
    required this.experience,
    required this.isDark,
    required this.isLeft,
  });

  @override
  State<_CardContent> createState() => _CardContentState();
}

class _CardContentState extends State<_CardContent> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final isDark = widget.isDark;
    final currentObject = widget.experience;

    return MouseRegion(
      cursor: SystemMouseCursors.basic,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: AppConstants.duration250,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: isDark ? AppColors.darkCard : AppColors.lightSurface,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: _hovered
                ? AppColors.primary.withValues(alpha: 0.5)
                : AppColors.primary.withValues(alpha: 0.12),
            width: _hovered ? 1.5 : 1,
          ),
          boxShadow: _hovered
              ? [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.15),
                    blurRadius: 30,
                    offset: const Offset(0, 10),
                  ),
                ]
              : [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.06),
                    blurRadius: 16,
                    offset: const Offset(0, 4),
                  ),
                ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header row: role badge + duration chip
            Wrap(
              spacing: 10,
              runSpacing: 8,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                if (currentObject.role?.isNotEmpty == true)
                  _Badge(
                    text: currentObject.role.toString(),
                    gradient: AppColors.primaryGradient,
                    textColor: Colors.white,
                  ),
                _Badge(
                  text: currentObject.duration,
                  color: AppColors.primary.withValues(alpha: 0.1),
                  textColor: AppColors.primary,
                  icon: Icons.calendar_today_rounded,
                ),
              ],
            ),
            const SizedBox(height: 14),
            // Company name
            Text(
              currentObject.company,
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: isDark ? AppColors.darkText : AppColors.lightText,
                letterSpacing: -0.3,
              ),
            ),
            const SizedBox(height: 6),
            // Location
            Row(
              spacing: 4,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.location_on_rounded,
                  size: 14,
                  color: AppColors.accent,
                ),
                Text(
                  currentObject.location,
                  style: GoogleFonts.poppins(
                    fontSize: 12.5,
                    color: isDark
                        ? AppColors.darkSubText
                        : AppColors.lightSubText,
                  ),
                ),
              ],
            ),
            if (currentObject.responsibilitiesList?.isNotEmpty == true) ...[
              const SizedBox(height: 14),
              Container(
                height: 1,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppColors.primary.withValues(alpha: 0.3),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 14),
              ...currentObject.responsibilitiesList?.map(
                    (responsibility) => Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Row(
                        spacing: 10,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 5),
                            child: Container(
                              width: 6,
                              height: 6,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: LinearGradient(
                                  colors: [AppColors.primary, AppColors.accent],
                                ),
                              ),
                            ),
                          ),

                          Expanded(
                            child: Text(
                              responsibility,
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                // height: 1.55,
                                color: isDark
                                    ? AppColors.darkSubText
                                    : AppColors.lightSubText,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ) ??
                  [],
            ],
          ],
        ),
      ),
    );
  }
}

class _Badge extends StatelessWidget {
  final String text;
  final Gradient? gradient;
  final Color? color;
  final Color textColor;
  final IconData? icon;

  const _Badge({
    required this.text,
    this.gradient,
    this.color,
    required this.textColor,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      decoration: BoxDecoration(
        gradient: gradient,
        color: color,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        spacing: 4,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[Icon(icon, size: 11, color: textColor)],
          Text(
            text,
            style: GoogleFonts.poppins(
              color: textColor,
              fontWeight: FontWeight.w600,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
