import 'dart:math';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mansi_lathiya_portfolio/controllers/portfolio_controller.dart';
import 'package:mansi_lathiya_portfolio/utils/app_colors.dart';
import 'package:mansi_lathiya_portfolio/utils/app_constants.dart';
import 'package:mansi_lathiya_portfolio/utils/portfolio_data.dart';
import 'package:mansi_lathiya_portfolio/utils/responsive_helper.dart';
import 'package:mansi_lathiya_portfolio/widgets/common_widgets.dart';

class HeroSection extends StatefulWidget {
  final void Function() onViewProjects;
  const HeroSection({super.key, required this.onViewProjects});

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection>
    with SingleTickerProviderStateMixin {
  int _roleIndex = 0;
  late final AnimationController _controller;
  late final Animation<double> _fade;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: AppConstants.duration600,
    );
    _fade = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
    _controller.forward();
    _cycleRoles();
  }

  void _cycleRoles() async {
    await Future.delayed(AppConstants.duration2Second);
    while (mounted) {
      await Future.delayed(AppConstants.duration2Second);
      await _controller.reverse();
      if (!mounted) return;
      setState(
        () => _roleIndex = (_roleIndex + 1) % PortfolioData.rolesList.length,
      );
      _controller.forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final responsive = context.responsive;
    final isWide = responsive.isWide;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final hPad = responsive.hPad;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: isDark
              ? [AppColors.darkBg, AppColors.darkSurface]
              : [AppColors.lightBg, const Color(0xFFE8E8FF)],
        ),
      ),
      child: Padding(
        padding: EdgeInsets.only(top: 110, bottom: 90, left: hPad, right: hPad),
        child: isWide
            ? Row(
                spacing: 60,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(child: _buildText(context)),
                  const _HeroAvatar(),
                ],
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 40,
                children: [const _HeroAvatar(), _buildText(context)],
              ),
      ),
    );
  }

  Widget _buildText(BuildContext context) {
    final responsive = context.responsive;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FadeInDown(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: AppColors.accentGreen.withValues(alpha: 0.12),
              border: Border.all(
                color: AppColors.accentGreen.withValues(alpha: 0.4),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              spacing: 8,
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.accentGreen,
                  ),
                ),
                Text(
                  // 'Available for opportunities',
                  PortfolioData.availableWork,
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: AppColors.accentGreen,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 22),
        // FadeInLeft(
        //   child: Container(
        //     padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        //     decoration: BoxDecoration(
        //       color: AppColors.primary.withValues(alpha: 0.12),
        //       borderRadius: BorderRadius.circular(20),
        //     ),
        //     child:  Text(
        //       '👋  Hello, I\'m',
        //       style: GoogleFonts.poppins(

        //         color: AppColors.primary,
        //         fontWeight: FontWeight.w600,
        //         fontSize: 15,
        //       ),
        //     ),
        //   ),
        // ),
        // const SizedBox(height: 16),
        FadeInLeft(
          delay: AppConstants.duration100,
          child: ShaderMask(
            shaderCallback: (bounds) => const LinearGradient(
              colors: [AppColors.primary, AppColors.accent],
            ).createShader(bounds),
            child: Text(
              PortfolioData.name,
              style: GoogleFonts.poppins(
                fontSize: responsive.heroTitleSize,
                fontWeight: FontWeight.w900,
                color: Colors.white,
                height: 1.05,
                letterSpacing: -1,
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),
        FadeInLeft(
          delay: AppConstants.duration200,
          child: Row(
            children: [
              Text(
                "I'm a ",
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
              FadeTransition(
                opacity: _fade,
                child: Text(
                  PortfolioData.rolesList[_roleIndex],
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: AppColors.primary,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        FadeInLeft(
          delay: AppConstants.duration300,
          child: Text(
            PortfolioData.heroDescription,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              height: 1.7,
              color: isDark ? AppColors.darkSubText : AppColors.lightSubText,
            ),
          ),
        ),
        const SizedBox(height: 32),
        FadeInUp(
          delay: AppConstants.duration500,
          child: Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              GradientButton(
                label: "View Projects",
                icon: Icons.work_outline,
                onTap: widget.onViewProjects,
              ),
              _OutlineBtn(
                label: "Download Resume",
                icon: Icons.download_rounded,
                onTap: () => Get.find<PortfolioController>().downloadResume(),
              ),
            ],
          ),
        ),
        const SizedBox(height: 40),
        FadeInLeft(
          delay: AppConstants.duration500,
          child: Row(
            children: [
              _stat("3+", "Experience"),
              _divider(),
              _stat(PortfolioData.projectsCompleted, "Projects"),
              // _divider(),
              // _stat(PortfolioData.totalCompanies, 'Companies'),
            ],
          ),
        ),
        const SizedBox(height: 28),
        const _SocialRow(),
      ],
    );
  }

  Widget _stat(String value, String label) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ShaderMask(
          shaderCallback: (b) => const LinearGradient(
            colors: [AppColors.primary, AppColors.accent],
          ).createShader(b),
          child: Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: 28,
              fontWeight: FontWeight.w900,
              color: Colors.white,
            ),
          ),
        ),
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 12,
            color: AppColors.lightSubText,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _divider() => Container(
    margin: const EdgeInsets.symmetric(horizontal: 24),
    width: 1,
    height: 40,
    color: AppColors.primary.withValues(alpha: 0.3),
  );
}

// Outline button
class _OutlineBtn extends StatefulWidget {
  final String label;
  final IconData icon;
  final void Function() onTap;
  const _OutlineBtn({
    required this.label,
    required this.icon,
    required this.onTap,
  });

  @override
  State<_OutlineBtn> createState() => _OutlineBtnState();
}

class _OutlineBtnState extends State<_OutlineBtn> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: InkWell(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: AppConstants.duration180,
          padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: AppColors.primary, width: 2),
            color: _hover
                ? AppColors.primary.withValues(alpha: 0.1)
                : Colors.transparent,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            spacing: 8,
            children: [
              Icon(widget.icon, color: AppColors.primary, size: 18),
              Text(
                widget.label,
                style: GoogleFonts.poppins(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                  letterSpacing: 0.3,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SocialChip extends StatefulWidget {
  final IconData icon;
  final String label, url;
  const _SocialChip({
    required this.icon,
    required this.label,
    required this.url,
  });

  @override
  State<_SocialChip> createState() => _SocialChipState();
}

class _SocialChipState extends State<_SocialChip> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: InkWell(
        onTap: () =>
            Get.find<PortfolioController>().launchURL(widget.url.toString()),
        child: AnimatedContainer(
          duration: AppConstants.duration180,
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            gradient: _hover ? AppColors.primaryGradient : null,
            color: _hover
                ? null
                : (context.isDark ? context.cardColor : Colors.white),
            border: Border.all(
              color: _hover
                  ? Colors.transparent
                  : (context.isDark
                        ? context.borderColor
                        : AppColors.lightBorderGlow),
            ),
            boxShadow: _hover
                ? [
                    BoxShadow(
                      color: AppColors.primary.withValues(alpha: 0.3),
                      blurRadius: 12,
                    ),
                  ]
                : [
                    if (!context.isDark)
                      BoxShadow(
                        color: AppColors.primary.withValues(alpha: 0.06),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                  ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            spacing: 7,
            children: [
              Icon(
                widget.icon,
                size: 15,
                color: _hover ? Colors.white : AppColors.primary,
              ),
              Text(
                widget.label.toString(),
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: _hover ? Colors.white : context.textSecondary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Socials
class _SocialRow extends StatelessWidget {
  const _SocialRow();

  static const _socials = [
    (Icons.code_rounded, "GitHub", PortfolioData.github),
    (Icons.link_rounded, "LinkedIn", PortfolioData.linkedin),
    (Icons.email_rounded, "Email", "mailto:${PortfolioData.email}"),
  ];

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: _socials
          .map((s) => _SocialChip(icon: s.$1, label: s.$2, url: s.$3))
          .toList(),
    );
  }
}

// Avatar
class _HeroAvatar extends StatefulWidget {
  const _HeroAvatar();

  @override
  State<_HeroAvatar> createState() => _HeroAvatarState();
}

class _HeroAvatarState extends State<_HeroAvatar>
    with SingleTickerProviderStateMixin {
  late final AnimationController _rot;

  @override
  void initState() {
    super.initState();
    _rot = AnimationController(
      vsync: this,
      duration: AppConstants.duration12Second,
    )..repeat();
  }

  @override
  void dispose() {
    _rot.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = context.responsive.avatarSize;
    return FadeIn(
      delay: AppConstants.duration300,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Outer glow
          Container(
            width: size + 60,
            height: size + 60,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  AppColors.primary.withValues(alpha: 0.22),
                  AppColors.accent.withValues(alpha: 0.08),
                  Colors.transparent,
                ],
                stops: const [0.0, 0.5, 1.0],
              ),
            ),
          ),
          // Rings — single AnimatedBuilder, single repaint boundary
          RepaintBoundary(
            child: AnimatedBuilder(
              animation: _rot,
              builder: (context, child) => SizedBox(
                width: size + 36,
                height: size + 36,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Transform.rotate(
                      angle: _rot.value * 2 * pi,
                      child: CustomPaint(
                        size: Size(size + 36, size + 36),
                        painter: const _DashedRingPainter(),
                      ),
                    ),
                    Transform.rotate(
                      angle: -_rot.value * pi,
                      child: Container(
                        width: size + 14,
                        height: size + 14,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: AppColors.accent.withValues(alpha: 0.22),
                            width: 1,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Main circle — static
          Container(
            width: size,
            height: size,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [AppColors.primary, AppColors.accent],
              ),
            ),
            child: Container(
              margin: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: context.cardColor,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ShaderMask(
                    shaderCallback: (b) =>
                        AppColors.primaryGradient.createShader(b),
                    child: Text(
                      'ML',
                      style: GoogleFonts.poppins(
                        fontSize: size * 0.26,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                        letterSpacing: -2,
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Flutter Dev',
                    style: GoogleFonts.poppins(
                      fontSize: size * 0.063,
                      color: context.textSecondary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
          // // profile Image
          // Container(
          //   width: sz,
          //   height: sz,
          //   margin: EdgeInsets.zero,
          //   padding: EdgeInsets.zero,
          //   decoration: BoxDecoration(
          //     shape: BoxShape.circle,
          //   ),
          //   child: ClipOval(
          //     child: Image.network(
          //       "https://media.licdn.com/dms/image/v2/D4D03AQGhzL7ChfzBSg/profile-displayphoto-shrink_200_200/B4DZdO6mngHAAY-/0/1749375677233?e=2147483647&v=beta&t=Rv0omGL5LRFx7GthXadypkQTf2slEreC4X-2TGy9WRo",
          //       fit: BoxFit.fill,
          //     ),
          //   ),
          // ),
          Positioned(
            top: 30,
            right: 10,
            child: _FloatingBadge(
              icon: Icons.flutter_dash_rounded,
              label: 'Flutter',
              color: AppColors.accent,
            ),
          ),
          Positioned(
            bottom: 28,
            left: 8,
            child: _FloatingBadge(
              icon: Icons.star_rounded,
              label: '3+ yrs',
              color: AppColors.accentGreen,
            ),
          ),
        ],
      ),
    );
  }
}

// Dashed ring painter
class _DashedRingPainter extends CustomPainter {
  const _DashedRingPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.primary.withValues(alpha: 0.35)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.8;
    const dashCount = 24;
    const dashAngle = pi * 2 / dashCount;
    const gap = 0.4;
    final r = size.width / 2 - 1;
    final center = Offset(size.width / 2, size.height / 2);
    for (var i = 0; i < dashCount; i++) {
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: r),
        i * dashAngle,
        dashAngle * (1 - gap),
        false,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(_DashedRingPainter _) => false;
}

// Floating badge
class _FloatingBadge extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  const _FloatingBadge({
    required this.icon,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: context.isDark ? context.cardColor : Colors.white,
        border: Border.all(color: color.withValues(alpha: 0.4)),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: context.isDark ? 0.25 : 0.18),
            blurRadius: 14,
          ),
          if (!context.isDark)
            BoxShadow(
              color: Colors.white.withValues(alpha: 0.9),
              blurRadius: 4,
            ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        spacing: 6,
        children: [
          Icon(icon, size: 14, color: color),
          Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: 11,
              color: color,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
