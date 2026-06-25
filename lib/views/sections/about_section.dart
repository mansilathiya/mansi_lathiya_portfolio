import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mansi_lathiya_portfolio/utils/app_colors.dart';
import 'package:mansi_lathiya_portfolio/utils/app_constants.dart';
import 'package:mansi_lathiya_portfolio/utils/portfolio_data.dart';
import 'package:mansi_lathiya_portfolio/utils/responsive_helper.dart';
import 'package:mansi_lathiya_portfolio/widgets/common_widgets.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    final responsive = context.responsive;
    final isDesktop = responsive.isDesktop;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: responsive.hPad,
        vertical: responsive.sectionV,
      ),
      color: isDark ? AppColors.darkBg : AppColors.lightBg,
      child: Column(
        spacing: 50,
        children: [
          const SectionTitle(
            title: "About Me",
            subtitle: "WHO I AM",
            description:
                "Passionate Flutter developer with a love for clean code & beautiful UI",
          ),
          isDesktop
              ? Row(
                  spacing: 40,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(flex: 5, child: _LeftPanel(isDark: isDark)),
                    Expanded(flex: 6, child: _RightPanel(isDark: isDark)),
                  ],
                )
              : Column(
                  spacing: 30,
                  children: [
                    _LeftPanel(isDark: isDark),
                    _RightPanel(isDark: isDark),
                  ],
                ),
        ],
      ),
    );
  }
}

// Left Panel
class _LeftPanel extends StatelessWidget {
  final bool isDark;
  const _LeftPanel({required this.isDark});

  @override
  Widget build(BuildContext context) {
    return FadeInLeft(
      duration: AppConstants.duration700,
      child: Column(
        spacing: 20,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _ProfileCard(isDark: isDark),
          _TraitGrid(isDark: isDark),
        ],
      ),
    );
  }
}

// Profile Card
class _ProfileCard extends StatelessWidget {
  final bool isDark;
  const _ProfileCard({required this.isDark});

  @override
  Widget build(BuildContext context) {
    return _GlassCard(
      isDark: isDark,
      child: Row(
        spacing: 18,
        children: [
          Container(
            width: 72,
            height: 72,
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
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Center(
              child: Text(
                "👩\u200d💻",
                style: GoogleFonts.poppins(fontSize: 24),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ShaderMask(
                  shaderCallback: (b) => const LinearGradient(
                    colors: [AppColors.primary, AppColors.accent],
                  ).createShader(b),
                  child: Text(
                    PortfolioData.name,
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  PortfolioData.tagline,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: isDark
                        ? AppColors.darkSubText
                        : AppColors.lightSubText,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 10),
                const AvailableWorkContainerView(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class AvailableWorkContainerView extends StatelessWidget {
  const AvailableWorkContainerView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.lightTeal.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.lightTeal.withValues(alpha: 0.4)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        spacing: 6,
        children: [
          Container(
            width: 7,
            height: 7,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.lightTeal,
            ),
          ),
          Flexible(
            child: Text(
              // 'Available for work',
              PortfolioData.availableWork,
              style: GoogleFonts.poppins(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: AppColors.lightTeal,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Trait Grid
class _TraitGrid extends StatelessWidget {
  final bool isDark;
  const _TraitGrid({required this.isDark});

  static const _gap = 12.0;
  static int _columns(double width) => width < 400 ? 1 : 2;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, constraints) {
        final cols = _columns(constraints.maxWidth);
        final tileWidth = (constraints.maxWidth - _gap * (cols - 1)) / cols;
        return Wrap(
          spacing: _gap,
          runSpacing: _gap,
          children: PortfolioData.traitsList
              .map(
                (t) => SizedBox(
                  width: tileWidth,
                  child: _TraitTile(
                    icon: t.$1,
                    title: t.$2,
                    desc: t.$3,
                    isDark: isDark,
                  ),
                ),
              )
              .toList(),
        );
      },
    );
  }
}

class _TraitTile extends StatefulWidget {
  final IconData icon;
  final String title;
  final String desc;
  final bool isDark;
  const _TraitTile({
    required this.icon,
    required this.title,
    required this.desc,
    required this.isDark,
  });

  @override
  State<_TraitTile> createState() => _TraitTileState();
}

class _TraitTileState extends State<_TraitTile> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: AppConstants.duration220,
        width: double.infinity,
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: widget.isDark ? AppColors.darkCard : AppColors.lightSurface,
          border: Border.all(
            color: _hovered
                ? AppColors.primary.withValues(alpha: 0.5)
                : AppColors.primary.withValues(alpha: 0.12),
            width: _hovered ? 1.5 : 1,
          ),
          boxShadow: _hovered
              ? [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.18),
                    blurRadius: 20,
                    offset: const Offset(0, 6),
                  ),
                ]
              : [],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedContainer(
              duration: AppConstants.duration220,
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                gradient: _hovered
                    ? AppColors.primaryGradient
                    : LinearGradient(
                        colors: [
                          AppColors.primary.withValues(alpha: 0.15),
                          AppColors.primary.withValues(alpha: 0.08),
                        ],
                      ),
              ),
              child: Icon(
                widget.icon,
                size: 20,
                color: _hovered ? Colors.white : AppColors.primary,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              widget.title,
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w700,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              widget.desc,
              style: GoogleFonts.poppins(
                fontSize: 14,
                height: 1.45,
                color: widget.isDark
                    ? AppColors.darkSubText
                    : AppColors.lightSubText,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Right Panel
class _RightPanel extends StatelessWidget {
  final bool isDark;
  const _RightPanel({required this.isDark});

  @override
  Widget build(BuildContext context) {
    return FadeInRight(
      duration: AppConstants.duration700,
      child: Column(
        spacing: 20,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _BioCard(isDark: isDark),
          _TechTagsCard(isDark: isDark),
        ],
      ),
    );
  }
}

// Bio Card
class _BioCard extends StatelessWidget {
  final bool isDark;
  const _BioCard({required this.isDark});

  @override
  Widget build(BuildContext context) {
    return _GlassCard(
      isDark: isDark,
      child: Column(
        spacing: 14,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _CardLabel(label: "My Story", isDark: isDark),
          RichText(
            text: TextSpan(
              style: GoogleFonts.poppins(
                fontSize: 16,
                height: 1.85,
                color: isDark ? AppColors.darkSubText : AppColors.lightSubText,
              ),
              children: [
                TextSpan(text: "I'm a passionate "),
                TextSpan(
                  text: "Flutter Developer",
                  style: GoogleFonts.poppins(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                  ),
                ),
                TextSpan(
                  text:
                      " with ${PortfolioData.totalExperience} of hands-on experience building "
                      "beautiful, high-performance cross-platform apps. I specialise in "
                      "scalable architecture, pixel-perfect UI, and smooth animations.\n\n"
                      "My daily toolkit spans ",
                ),
                TextSpan(
                  text: "GetX, Provider, Firebase, REST APIs",
                  style: GoogleFonts.poppins(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                  ),
                ),
                TextSpan(
                  text:
                      " and more. I thrive on turning complex problems into elegant, "
                      "maintainable solutions that users actually love.",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Tech Tags Card
class _TechTagsCard extends StatelessWidget {
  final bool isDark;
  const _TechTagsCard({required this.isDark});

  @override
  Widget build(BuildContext context) {
    return _GlassCard(
      isDark: isDark,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 14,
        children: [
          _CardLabel(label: "Tech Stack", isDark: isDark),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: PortfolioData.techTagsList
                .map((tag) => _TechTag(label: tag))
                .toList(),
          ),
        ],
      ),
    );
  }
}

class _TechTag extends StatefulWidget {
  final String label;
  const _TechTag({required this.label});

  @override
  State<_TechTag> createState() => _TechTagState();
}

class _TechTagState extends State<_TechTag> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: AppConstants.duration180,
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: _hovered
              ? const LinearGradient(
                  colors: [AppColors.primary, AppColors.accent],
                )
              : null,
          color: _hovered ? null : AppColors.primary.withValues(alpha: 0.08),
          border: Border.all(
            color: _hovered
                ? Colors.transparent
                : AppColors.primary.withValues(alpha: 0.25),
          ),
        ),
        child: Text(
          widget.label,
          style: GoogleFonts.poppins(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: _hovered ? Colors.white : AppColors.primary,
          ),
        ),
      ),
    );
  }
}

// Shared Widgets
class _GlassCard extends StatelessWidget {
  final bool isDark;
  final Widget child;
  const _GlassCard({required this.isDark, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkCard : AppColors.lightSurface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppColors.primary.withValues(alpha: isDark ? 0.12 : 0.1),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: isDark ? 0.06 : 0.05),
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: child,
    );
  }
}

class _CardLabel extends StatelessWidget {
  final String label;
  final bool isDark;
  const _CardLabel({required this.label, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 10,
      children: [
        Container(
          width: 4,
          height: 18,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(2),
            gradient: const LinearGradient(
              colors: [AppColors.primary, AppColors.accent],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            letterSpacing: 1.5,
            color: isDark ? AppColors.darkSubText : AppColors.lightSubText,
          ),
        ),
      ],
    );
  }
}
