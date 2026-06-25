import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mansi_lathiya_portfolio/controllers/portfolio_controller.dart';
import 'package:mansi_lathiya_portfolio/utils/app_colors.dart';
import 'package:mansi_lathiya_portfolio/utils/app_constants.dart';
import 'package:mansi_lathiya_portfolio/utils/portfolio_data.dart';
import 'package:mansi_lathiya_portfolio/utils/responsive_helper.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    final responsive = context.responsive;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isDesktop = responsive.isDesktop;
    final pad = responsive.hPad;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkCard : AppColors.lightSurface,
        border: Border(
          top: BorderSide(color: AppColors.primary.withValues(alpha: 0.12)),
        ),
      ),
      child: Column(
        children: [
          // Main content
          Padding(
            padding: EdgeInsets.symmetric(horizontal: pad, vertical: 52),
            child: isDesktop
                ? _DesktopContent(isDark: isDark)
                : _MobileContent(isDark: isDark),
          ),
          // Divider
          Container(
            height: 1,
            margin: EdgeInsets.symmetric(horizontal: pad),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.transparent,
                  AppColors.primary.withValues(alpha: 0.3),
                  AppColors.accent.withValues(alpha: 0.3),
                  Colors.transparent,
                ],
              ),
            ),
          ),
          // Bottom bar
          Padding(
            padding: EdgeInsets.symmetric(horizontal: pad, vertical: 20),
            child: _BottomBar(isDark: isDark, isDesktop: isDesktop),
          ),
        ],
      ),
    );
  }
}

// Desktop: three-column layout
class _DesktopContent extends StatelessWidget {
  final bool isDark;
  const _DesktopContent({required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 40,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Col 1 — brand
        Expanded(flex: 3, child: _BrandColumn(isDark: isDark)),
        // Col 2 — quick links
        Expanded(flex: 2, child: _LinksColumn(isDark: isDark)),
        // Col 3 — contact info
        Expanded(flex: 3, child: _ContactColumn(isDark: isDark)),
      ],
    );
  }
}

// Mobile: stacked layout
class _MobileContent extends StatelessWidget {
  final bool isDark;
  const _MobileContent({required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _BrandColumn(isDark: isDark, centered: true),
        const SizedBox(height: 36),
        _LinksColumn(isDark: isDark, centered: true),
        const SizedBox(height: 36),
        _ContactColumn(isDark: isDark, centered: true),
      ],
    );
  }
}

// Brand column
class _BrandColumn extends StatelessWidget {
  final bool isDark;
  final bool centered;
  const _BrandColumn({required this.isDark, this.centered = false});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: centered
          ? CrossAxisAlignment.center
          : CrossAxisAlignment.start,
      children: [
        // Name with gradient
        ShaderMask(
          shaderCallback: (b) => AppColors.primaryGradient.createShader(b),
          child: Text(
            PortfolioData.name,
            style: GoogleFonts.poppins(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(height: 6),
        // Tagline
        Text(
          PortfolioData.tagline,
          style: GoogleFonts.poppins(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: AppColors.primary,
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 14),
        Text(
          "Crafting beautiful, high-performance\ncross-platform apps with Flutter.",
          textAlign: centered ? TextAlign.center : TextAlign.start,
          style: GoogleFonts.poppins(
            fontSize: 13.5,
            height: 1.65,
            color: isDark ? AppColors.darkSubText : AppColors.lightSubText,
          ),
        ),
        const SizedBox(height: 22),
        // Social icons
        _SocialsRow(centered: centered),
      ],
    );
  }
}

// Quick links column
class _LinksColumn extends GetView<PortfolioController> {
  final bool isDark;
  final bool centered;
  const _LinksColumn({required this.isDark, this.centered = false});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: centered
          ? CrossAxisAlignment.center
          : CrossAxisAlignment.start,
      children: [
        _FooterHeading(text: "Quick Links", centered: centered),
        const SizedBox(height: 16),
        ...PortfolioData.links.map(
          (item) => _FooterLink(
            label: item.$2,
            centered: centered,
            isDark: isDark,
            onTap: () => controller.navigateTo(item.$1),
          ),
        ),
      ],
    );
  }
}

// Contact column
class _ContactColumn extends GetView<PortfolioController> {
  final bool isDark;
  final bool centered;
  const _ContactColumn({required this.isDark, this.centered = false});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 16,
      crossAxisAlignment: centered
          ? CrossAxisAlignment.center
          : CrossAxisAlignment.start,
      children: [
        _FooterHeading(text: "Get In Touch", centered: centered),
        // const SizedBox(height: 16),
        Column(
          crossAxisAlignment: centered
              ? CrossAxisAlignment.center
              : CrossAxisAlignment.start,
          children: [
            _ContactItem(
              icon: Icons.email_outlined,
              text: PortfolioData.email,
              isDark: isDark,
              centered: centered,
              onTap: () =>
                  controller.launchURL("mailto:${PortfolioData.email}"),
            ),
            // _ContactItem(
            //   icon: Icons.phone_outlined,
            //   text: PortfolioData.phone,
            //   isDark: isDark,
            //   centered: centered,
            //   onTap: () => controller.launchURL('tel:${PortfolioData.phone}'),
            // ),
            _ContactItem(
              icon: Icons.location_on_outlined,
              text: PortfolioData.location,
              isDark: isDark,
              centered: centered,
            ),
          ],
        ),
        // const SizedBox(height: 16),
        // Availability badge
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(
            color: AppColors.accentGreen.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(30),
            border: Border.all(
              color: AppColors.accentGreen.withValues(alpha: 0.35),
            ),
          ),
          child: Row(
            spacing: 8,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFF00E5A0),
                ),
              ),
              Text(
                // 'Available for freelance work',
                PortfolioData.availableWork,
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF00E5A0),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// Social icons row
class _SocialsRow extends GetView<PortfolioController> {
  final bool centered;
  const _SocialsRow({this.centered = false});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: centered
          ? MainAxisAlignment.center
          : MainAxisAlignment.start,
      spacing: 10,
      children: [
        _SocialBtn(
          icon: FontAwesomeIcons.github,
          url: PortfolioData.github,
          tooltip: "GitHub",
        ),
        _SocialBtn(
          icon: FontAwesomeIcons.linkedin,
          url: PortfolioData.linkedin,
          tooltip: "LinkedIn",
        ),
        _SocialBtn(
          icon: FontAwesomeIcons.solidEnvelope,
          url: "mailto:${PortfolioData.email}",
          tooltip: "Email",
        ),
      ],
    );
  }
}

class _SocialBtn extends GetView<PortfolioController> {
  final FaIconData icon;
  final String url;
  final String tooltip;
  const _SocialBtn({
    required this.icon,
    required this.url,
    required this.tooltip,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return _HoverWidget(
      builder: (hovered) => Tooltip(
        message: tooltip,
        child: GestureDetector(
          onTap: () => controller.launchURL(url),
          child: MouseRegion(
            cursor: SystemMouseCursors.click,
            child: AnimatedContainer(
              duration: AppConstants.duration200,
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: hovered ? AppColors.primaryGradient : null,
                color: hovered
                    ? null
                    : (isDark ? AppColors.darkSurface : AppColors.lightCard),
                border: Border.all(
                  color: hovered
                      ? Colors.transparent
                      : AppColors.primary.withValues(alpha: 0.2),
                ),
                boxShadow: hovered
                    ? [
                        BoxShadow(
                          color: AppColors.primary.withValues(alpha: 0.35),
                          blurRadius: 12,
                          spreadRadius: 1,
                        ),
                      ]
                    : [],
              ),
              child: Center(
                child: FaIcon(
                  icon,
                  size: 16,
                  color: hovered
                      ? Colors.white
                      : (isDark
                            ? AppColors.darkSubText
                            : AppColors.lightSubText),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// Bottom bar
class _BottomBar extends StatelessWidget {
  final bool isDark;
  final bool isDesktop;
  const _BottomBar({required this.isDark, required this.isDesktop});

  @override
  Widget build(BuildContext context) {
    final copyright = Text(
      "© ${DateTime.now().year} Mansi Lathiya. All rights reserved.",
      style: GoogleFonts.poppins(
        fontSize: 12.5,
        color: isDark ? AppColors.darkSubText : AppColors.lightSubText,
      ),
    );

    final crafted = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          "Crafted with ",
          style: GoogleFonts.poppins(
            fontSize: 12.5,
            color: isDark ? AppColors.darkSubText : AppColors.lightSubText,
          ),
        ),
        Text("💙", style: GoogleFonts.poppins(fontSize: 13)),
        Text(
          " using Flutter",
          style: GoogleFonts.poppins(
            fontSize: 12.5,
            fontWeight: FontWeight.w600,
            color: AppColors.primary,
          ),
        ),
      ],
    );

    if (isDesktop) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [copyright, crafted],
      );
    }
    return Column(children: [copyright, const SizedBox(height: 6), crafted]);
  }
}

// Reusable footer heading
class _FooterHeading extends StatelessWidget {
  final String text;
  final bool centered;
  const _FooterHeading({required this.text, this.centered = false});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 8,
      crossAxisAlignment: centered
          ? CrossAxisAlignment.center
          : CrossAxisAlignment.start,
      children: [
        Text(
          text,
          style: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.3,
          ),
        ),
        Container(
          width: 30,
          height: 3,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(2),
            gradient: const LinearGradient(
              colors: [AppColors.primary, AppColors.accent],
            ),
          ),
        ),
      ],
    );
  }
}

// Footer nav link
class _FooterLink extends StatelessWidget {
  final String label;
  final bool isDark;
  final bool centered;
  final VoidCallback onTap;
  const _FooterLink({
    required this.label,
    required this.isDark,
    required this.onTap,
    this.centered = false,
  });

  @override
  Widget build(BuildContext context) {
    return _HoverWidget(
      builder: (hovered) => GestureDetector(
        onTap: onTap,
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: centered
                  ? MainAxisAlignment.center
                  : MainAxisAlignment.start,
              children: [
                AnimatedContainer(
                  duration: AppConstants.duration200,
                  width: hovered ? 14 : 0,
                  height: 2,
                  margin: EdgeInsets.only(right: hovered ? 6 : 0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(1),
                    gradient: const LinearGradient(
                      colors: [AppColors.primary, AppColors.accent],
                    ),
                  ),
                ),
                Text(
                  label,
                  style: GoogleFonts.poppins(
                    fontSize: 13.5,
                    fontWeight: hovered ? FontWeight.w600 : FontWeight.w400,
                    color: hovered
                        ? AppColors.primary
                        : (isDark
                              ? AppColors.darkSubText
                              : AppColors.lightSubText),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ── Contact item ──────────────────────────────────────────────────────────────
class _ContactItem extends StatelessWidget {
  final IconData icon;
  final String text;
  final bool isDark;
  final bool centered;
  final VoidCallback? onTap;

  const _ContactItem({
    required this.icon,
    required this.text,
    required this.isDark,
    this.centered = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: GestureDetector(
        onTap: onTap,
        child: MouseRegion(
          cursor: onTap != null
              ? SystemMouseCursors.click
              : SystemMouseCursors.basic,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: centered
                ? MainAxisAlignment.center
                : MainAxisAlignment.start,
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, size: 15, color: AppColors.primary),
              ),
              const SizedBox(width: 10),
              Flexible(
                child: Text(
                  text,
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    color: isDark
                        ? AppColors.darkSubText
                        : AppColors.lightSubText,
                    decoration: onTap != null ? TextDecoration.underline : null,
                    decorationColor: AppColors.primary.withValues(alpha: 0.4),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Hover state helper ────────────────────────────────────────────────────────
class _HoverWidget extends StatefulWidget {
  final Widget Function(bool hovered) builder;
  const _HoverWidget({required this.builder});

  @override
  State<_HoverWidget> createState() => _HoverWidgetState();
}

class _HoverWidgetState extends State<_HoverWidget> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: widget.builder(_hovered),
    );
  }
}
