import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mansi_lathiya_portfolio/models/portfolio_model.dart';
import 'package:mansi_lathiya_portfolio/utils/app_colors.dart';
import 'package:mansi_lathiya_portfolio/utils/app_constants.dart';
import 'package:mansi_lathiya_portfolio/utils/portfolio_data.dart';
import 'package:mansi_lathiya_portfolio/utils/responsive_helper.dart';
import 'package:mansi_lathiya_portfolio/widgets/common_widgets.dart';

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final responsive = context.responsive;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final crossAxisCount = responsive.skillCols;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: responsive.hPad,
        vertical: responsive.sectionV,
      ),
      child: Column(
        children: [
          const SectionTitle(
            title: "Skills & Expertise",
            subtitle: "WHAT I KNOW",
            description:
                "Technologies & tools I excel in and utilize effectively",
          ),
          const SizedBox(height: 60),
          Center(
            child: SizedBox(
              width: double.infinity,
              child: _SkillGrid(crossAxisCount: crossAxisCount, isDark: isDark),
            ),
          ),
        ],
      ),
    );
  }
}

class _SkillGrid extends StatelessWidget {
  final int crossAxisCount;
  final bool isDark;

  const _SkillGrid({required this.crossAxisCount, required this.isDark});

  @override
  Widget build(BuildContext context) {
    final categories = PortfolioData.skillCategoriesList;
    final rows = <Widget>[];

    for (var i = 0; i < categories.length; i += crossAxisCount) {
      final rowItems = categories.sublist(
        i,
        (i + crossAxisCount).clamp(0, categories.length),
      );
      rows.add(
        IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              for (var j = 0; j < rowItems.length; j++) ...[
                if (j > 0) const SizedBox(width: 24),
                Expanded(
                  child: _SkillCard(category: rowItems[j], isDark: isDark),
                ),
              ],
              // Fill remaining columns with invisible placeholders
              for (var k = rowItems.length; k < crossAxisCount; k++) ...[
                const SizedBox(width: 24),
                const Expanded(child: SizedBox.shrink()),
              ],
            ],
          ),
        ),
      );
      if (i + crossAxisCount < categories.length) {
        rows.add(const SizedBox(height: 24));
      }
    }

    return Column(children: rows);
  }
}

class _SkillCard extends StatefulWidget {
  final SkillCategory category;
  final bool isDark;

  const _SkillCard({required this.category, required this.isDark});

  @override
  State<_SkillCard> createState() => _SkillCardState();
}

class _SkillCardState extends State<_SkillCard> {
  bool _isHover = false;

  @override
  Widget build(BuildContext context) {
    final responsive = context.responsive;
    final isMobile = responsive.isMobile;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHover = true),
      onExit: (_) => setState(() => _isHover = false),
      child: AnimatedContainer(
        duration: AppConstants.duration250,
        transform: Matrix4.translationValues(
          0.0,
          !isMobile && _isHover ? -8.0 : 0.0,
          0.0,
        ),
        padding: EdgeInsets.all(responsive.cardPad),
        decoration: BoxDecoration(
          color: widget.isDark ? AppColors.darkCard : AppColors.lightSurface,
          borderRadius: BorderRadius.circular(28),
          border: Border.all(color: AppColors.primary.withValues(alpha: 0.15)),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withValues(
                alpha: _isHover ? 0.12 : 0.05,
              ),
              blurRadius: _isHover ? 28 : 16,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: isMobile ? 56 : 68,
              height: isMobile ? 56 : 68,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                gradient: const LinearGradient(
                  colors: [AppColors.primary, AppColors.accent],
                ),
              ),
              child: Icon(
                widget.category.icon,
                color: Colors.white,
                size: responsive.when(mobile: 24, desktop: 30),
              ),
            ),
            const SizedBox(height: 14),
            Text(
              widget.category.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.poppins(
                fontSize: responsive.when(mobile: 16, desktop: 20),
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 14),
            ...widget.category.skills.map(
              (skill) => Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 7),
                      width: 6,
                      height: 6,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          colors: [AppColors.primary, AppColors.accent],
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        skill,
                        style: GoogleFonts.poppins(
                          fontSize: responsive.body,
                          height: 1.5,
                          color: widget.isDark
                              ? Colors.white70
                              : Colors.black87,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
