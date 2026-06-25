import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:animate_do/animate_do.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mansi_lathiya_portfolio/controllers/portfolio_controller.dart';
import 'package:mansi_lathiya_portfolio/models/portfolio_model.dart';
import 'package:mansi_lathiya_portfolio/utils/app_colors.dart';
import 'package:mansi_lathiya_portfolio/utils/app_constants.dart';
import 'package:mansi_lathiya_portfolio/utils/portfolio_data.dart';
import 'package:mansi_lathiya_portfolio/utils/responsive_helper.dart';
import 'package:mansi_lathiya_portfolio/widgets/common_widgets.dart';

class ProjectsSection extends GetView<PortfolioController> {
  const ProjectsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final responsive = context.responsive;
    final pad = responsive.hPad;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: pad,
        vertical: responsive.sectionV,
      ),
      decoration: BoxDecoration(
        gradient: context.isDark
            ? LinearGradient(
                colors: [
                  AppColors.darkCard.withValues(alpha: 0.25),
                  AppColors.darkBg,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              )
            : const LinearGradient(
                colors: [
                  Color(0xFFE8E6FF),
                  Color(0xFFF0EEFF),
                  Color(0xFFE8E6FF),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
      ),
      child: Column(
        children: [
          FadeInDown(
            child: const SectionTitle(
              title: "Featured Projects",
              subtitle: "MY WORK",
              description:
                  "A showcase of my most impactful and innovative projects",
            ),
          ),
          // const SizedBox(height: 32),
          // FadeInDown(
          //   delay:AppConstants.duration250,
          //   child: _FilterBar(),
          // ),
          const SizedBox(height: 40),
          // Obx(
          //   () => _ProjectGrid(
          //     // projects: controller.filteredProjects,
          //     allProjects: controller.projects,
          //   ),
          // ),
          _ProjectGrid(
            // projects: controller.filteredProjects,
            allProjects: controller.projects,
          ),
        ],
      ),
    );
  }
}

// // Filter bar
// class _FilterBar extends GetView<PortfolioController> {
//   int _countFor(String filter, List<ProjectModel> all) {
//     if (filter == 'All') return all.length;
//     return all.where((p) {
//       if (filter == 'iOS') {
//         return p.platform.contains('iOS') && !p.platform.contains('Android');
//       }
//       if (filter == 'Android') {
//         return p.platform.contains('Android') && !p.platform.contains('iOS');
//       }
//       if (filter == 'Cross-Platform') {
//         return p.platform.contains('Android') && p.platform.contains('iOS');
//       }
//       if (filter == 'Web') return p.platform.contains('Web');
//       return false;
//     }).length;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Obx(
//       () => SingleChildScrollView(
//         scrollDirection: Axis.horizontal,
//         child: Row(
//           spacing: 10,
//           children: controller.projectFilters.map((f) {
//             final count = _countFor(f, controller.projects);
//             return _FilterChip(
//               label: f,
//               count: count,
//               isActive: controller.selectedFilter.value == f,
//               onTap: () => controller.setFilter(f),
//             );
//           }).toList(),
//         ),
//       ),
//     );
//   }
// }

// class _FilterChip extends StatefulWidget {
//   final String label;
//   final int count;
//   final bool isActive;
//   final VoidCallback onTap;

//   const _FilterChip({
//     required this.label,
//     required this.count,
//     required this.isActive,
//     required this.onTap,
//   });

//   @override
//   State<_FilterChip> createState() => _FilterChipState();
// }

// class _FilterChipState extends State<_FilterChip> {
//   bool _hovered = false;

//   static const _icons = {
//     'All': '✦',
//     'iOS': '🍎',
//     'Android': '🤖',
//     'Cross-Platform': '📱',
//     'Web': '🌐',
//   };

//   @override
//   Widget build(BuildContext context) {
//     final active = widget.isActive;
//     return MouseRegion(
//       onEnter: (_) => setState(() => _hovered = true),
//       onExit: (_) => setState(() => _hovered = false),
//       child: InkWell(
//         onTap: widget.onTap,
//         child: AnimatedContainer(
//           duration: AppConstants.duration200,
//           padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(30),
//             gradient: active ? AppColors.primaryGradient : null,
//             color: active
//                 ? null
//                 : (_hovered
//                       ? AppColors.primary.withValues(alpha: 0.08)
//                       : context.cardColor),
//             border: Border.all(
//               color: active
//                   ? Colors.transparent
//                   : (_hovered
//                         ? AppColors.primary.withValues(alpha: 0.5)
//                         : context.borderColor),
//             ),
//             boxShadow: active
//                 ? [
//                     BoxShadow(
//                       color: AppColors.primary.withValues(alpha: 0.4),
//                       blurRadius: 14,
//                       offset: const Offset(0, 4),
//                     ),
//                   ]
//                 : [],
//           ),
//           child: Row(
//             mainAxisSize: MainAxisSize.min,
//             spacing: 6,
//             children: [
//               Text(
//                 _icons[widget.label] ?? '●',
//                 style: GoogleFonts.poppins(fontSize: 13),
//               ),
//               Text(
//                 widget.label,
//                 style: GoogleFonts.poppins(
//                   fontSize: 13,
//                   fontWeight: active ? FontWeight.w700 : FontWeight.w500,
//                   color: active ? Colors.white : context.textSecondary,
//                 ),
//               ),
//               Container(
//                 padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(20),
//                   color: active
//                       ? Colors.white.withValues(alpha: 0.25)
//                       : AppColors.primary.withValues(alpha: 0.12),
//                 ),
//                 child: Text(
//                   '${widget.count}',
//                   style: GoogleFonts.poppins(
//                     fontSize: 10,
//                     fontWeight: FontWeight.w700,
//                     color: active ? Colors.white : AppColors.primary,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// Project grid
class _ProjectGrid extends StatelessWidget {
  // final List<ProjectModel> projects;
  final List<ProjectModel> allProjects;

  const _ProjectGrid({
    // required this.projects,
    required this.allProjects,
  });

  @override
  Widget build(BuildContext context) {
    final responsive = context.responsive;
    final width = MediaQuery.sizeOf(context).width;
    if (allProjects.isEmpty) return const _EmptyState();
    if (responsive.isMobile) {
      return ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        // itemCount: projects.length,
        itemCount: allProjects.length,
        separatorBuilder: (_, _) => const SizedBox(height: 16),
        itemBuilder: (_, index) {
          // final globalIndex = allProjects.indexOf(projects[i]);
          var currentObject = allProjects[index];
          return FadeInUp(
            delay: Duration(milliseconds: index * 60),
            // child: _ProjectCard(project: projects[i], index: globalIndex),
            child: _ProjectCard(project: currentObject, index: index),
          );
        },
      );
    }
    final cols = responsive.colCount;
    final colWidth = responsive.cardWidth(
      totalWidth: width - responsive.hPad * 2,
    );
    return Wrap(
      spacing: 20,
      runSpacing: 20,
      children: List.generate(allProjects.length, (index) {
        final currentObject = allProjects[index];
        return FadeInUp(
          delay: Duration(milliseconds: (index % cols) * 80),
          child: SizedBox(
            width: colWidth,
            child: _ProjectCard(project: currentObject, index: index),
          ),
        );
      }),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 60),
      child: Column(
        spacing: 12,
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.primary.withValues(alpha: 0.1),
              border: Border.all(
                color: AppColors.primary.withValues(alpha: 0.3),
              ),
            ),
            child: Center(
              child: Text("🔍", style: GoogleFonts.poppins(fontSize: 36)),
            ),
          ),
          Text(
            "No projects in this category",
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: context.textPrimary,
            ),
          ),
          Text(
            "Try selecting a different filter above",
            style: GoogleFonts.poppins(
              fontSize: 13,
              color: context.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}

// Project card
class _ProjectCard extends GetView<PortfolioController> {
  final ProjectModel project;
  final int index;
  const _ProjectCard({required this.project, required this.index});

  @override
  Widget build(BuildContext context) {
    final gradient = AppColors.gradientAt(index);
    final platformColor = AppColors.platformColor(project.platform);
    return _HoverCard(
      gradient: gradient,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            spacing: 12,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  gradient: gradient,
                  boxShadow: [
                    BoxShadow(
                      color: gradient.colors.first.withValues(alpha: 0.35),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    project.icon,
                    style: GoogleFonts.poppins(fontSize: 24),
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 4,
                  children: [
                    Text(
                      "#${(index + 1).toString().padLeft(2, '0')}",
                      style: GoogleFonts.poppins(
                        fontSize: 11,
                        color: gradient.colors.first,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    _PlatformBadge(
                      platform: project.platform,
                      color: platformColor,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Text(
            project.title.toString(),
            style: GoogleFonts.poppins(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: context.textPrimary,
              height: 1.3,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            project.description.toString(),
            style: GoogleFonts.poppins(
              fontSize: 12.5,
              color: context.textSecondary,
              height: 1.75,
            ),
            maxLines: 4,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 14),
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: project.tags
                .take(4)
                .map((tag) => _TagChip(label: tag, gradient: gradient))
                .toList(),
          ),
          const SizedBox(height: 16),
          Container(
            height: 1,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  gradient.colors.first.withValues(alpha: 0.4),
                  Colors.transparent,
                ],
              ),
            ),
          ),
          const SizedBox(height: 14),
          _StoreLinks(project: project, gradient: gradient),
        ],
      ),
    );
  }
}

// Platform badge
class _PlatformBadge extends StatelessWidget {
  final String platform;
  final Color color;
  const _PlatformBadge({required this.platform, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: color.withValues(alpha: 0.12),
        border: Border.all(color: color.withValues(alpha: 0.35)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        spacing: 4,
        children: [
          Icon(PortfolioData.platformIcon(platform), size: 11, color: color),
          Text(
            PortfolioData.platformShort(platform),
            style: GoogleFonts.poppins(
              fontSize: 10,
              color: color,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

// Tag chip
class _TagChip extends StatelessWidget {
  final String label;
  final LinearGradient gradient;
  const _TagChip({required this.label, required this.gradient});

  @override
  Widget build(BuildContext context) {
    final color = gradient.colors.first;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: color.withValues(alpha: 0.08),
        border: Border.all(color: color.withValues(alpha: 0.25)),
      ),
      child: Text(
        label,
        style: GoogleFonts.poppins(
          fontSize: 10,
          color: color,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

// Store links
class _StoreLinks extends GetView<PortfolioController> {
  final ProjectModel project;
  final LinearGradient gradient;
  const _StoreLinks({required this.project, required this.gradient});

  @override
  Widget build(BuildContext context) {
    final links = <StoreLinkData>[];
    if (project.playStoreUrl != null) {
      links.add(
        StoreLinkData(
          Icons.android_rounded,
          "Play Store",
          AppColors.accentGreen,
          project.playStoreUrl!,
        ),
      );
    }
    if (project.appStoreUrl != null) {
      links.add(
        StoreLinkData(
          Icons.apple_rounded,
          "App Store",
          AppColors.primaryLight,
          project.appStoreUrl!,
        ),
      );
    }
    if (project.websiteUrl != null) {
      links.add(
        StoreLinkData(
          Icons.language_rounded,
          "Website",
          AppColors.accent,
          project.websiteUrl!,
        ),
      );
    }

    if (links.isEmpty) {
      return Row(
        spacing: 6,
        children: [
          Icon(
            Icons.lock_outline_rounded,
            size: 13,
            color: context.textSecondary,
          ),
          Text(
            "Private / NDA",
            style: GoogleFonts.poppins(
              fontSize: 11,
              color: context.textSecondary,
            ),
          ),
        ],
      );
    }

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: links
          .map(
            (link) => _StoreBadge(
              data: link,
              onTap: () => controller.launchURL(link.url),
            ),
          )
          .toList(),
    );
  }
}

class _StoreBadge extends StatefulWidget {
  final StoreLinkData data;
  final VoidCallback onTap;
  const _StoreBadge({required this.data, required this.onTap});

  @override
  State<_StoreBadge> createState() => _StoreBadgeState();
}

class _StoreBadgeState extends State<_StoreBadge> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final color = widget.data.color;
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: InkWell(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: AppConstants.duration180,
          padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 6),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: _hovered
                ? color.withValues(alpha: 0.18)
                : color.withValues(alpha: 0.08),
            border: Border.all(
              color: _hovered
                  ? color.withValues(alpha: 0.65)
                  : color.withValues(alpha: 0.28),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            spacing: 5,
            children: [
              Icon(widget.data.icon, size: 13, color: color),
              Text(
                widget.data.label.toString(),
                style: GoogleFonts.poppins(
                  fontSize: 11,
                  color: color,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Icon(
                Icons.open_in_new_rounded,
                size: 10,
                color: color.withValues(alpha: 0.65),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Hover card
class _HoverCard extends StatefulWidget {
  final Widget child;
  final LinearGradient gradient;

  const _HoverCard({required this.child, required this.gradient});

  @override
  State<_HoverCard> createState() => _HoverCardState();
}

class _HoverCardState extends State<_HoverCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final glowColor = widget.gradient.colors.first;
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: AppConstants.duration220,
        curve: Curves.easeOutCubic,
        transform: Matrix4.translationValues(0, _hovered ? -6 : 0, 0),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: context.isDark ? AppColors.darkCard : Colors.white,
          border: Border.all(
            color: _hovered
                ? glowColor.withValues(alpha: 0.55)
                : (context.isDark
                      ? context.borderColor
                      : AppColors.lightBorderGlow),
            width: _hovered ? 1.5 : 1,
          ),
          boxShadow: _hovered
              ? [
                  BoxShadow(
                    color: glowColor.withValues(alpha: 0.20),
                    blurRadius: 24,
                    offset: const Offset(0, 8),
                  ),
                  BoxShadow(
                    color: glowColor.withValues(alpha: 0.08),
                    blurRadius: 48,
                    spreadRadius: 4,
                  ),
                ]
              : [
                  BoxShadow(
                    color: Colors.black.withValues(
                      alpha: context.isDark ? 0.18 : 0.07,
                    ),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
        ),
        child: widget.child,
      ),
    );
  }
}
