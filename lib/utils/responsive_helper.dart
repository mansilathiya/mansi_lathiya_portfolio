import 'package:flutter/material.dart';

abstract final class Breakpoints {
  static const double mobile = 600;
  static const double tablet = 900;
  static const double desktop = 1200;
}

class ResponsiveHelper {
  final double width;
  const ResponsiveHelper._(this.width);

  factory ResponsiveHelper.of(BuildContext context) =>
      ResponsiveHelper._(MediaQuery.sizeOf(context).width);

  // Screen class
  bool get isMobile => width < Breakpoints.mobile;
  bool get isTablet =>
      width >= Breakpoints.mobile && width < Breakpoints.desktop;
  bool get isDesktop => width >= Breakpoints.desktop;
  bool get isWide => width >= Breakpoints.tablet; // tablet + desktop

  // Horizontal page padding
  double get hPad {
    if (isDesktop) return width * 0.09;
  
    if(isWide) return 48.0;
    if (isMobile) return 20.0;
    return 28.0;
  }

  /// Tighter padding used inside cards / narrow containers.
  double get innerPad => isMobile ? 16.0 : 24.0;

  // Grid
  /// Number of columns for a standard card grid.
  int get colCount {
    if (isDesktop) return 3;
    if (isWide) return 2;
    return 1;
  }

  /// Column count for a skills / feature grid (max 3).
  int get skillCols {
    if (isDesktop) return 3;
    if (width >= 768) return 2;
    return 1;
  }

  double cardWidth({required double totalWidth, double gap = 20, int? cols}) {
    final c = cols ?? colCount;
    return (totalWidth - gap * (c - 1)) / c;
  }

  // Spacing
  double get sectionV => isDesktop
      ? 100.0
      : isWide
      ? 80.0
      : 60.0;
  double get cardPad => isMobile ? 18.0 : 24.0;
  double get sectionGap => isMobile ? 40.0 : 60.0;

  // Typography
  double fontSize(double base) {
    if (isMobile) return base * 0.88;
    if (isDesktop) return base * 1.10;
    return base;
  }

  double get heroTitleSize => isMobile
      ? 36.0
      : isDesktop
      ? 58.0
      : 46.0;
  double get h1 => isMobile
      ? 26.0
      : isDesktop
      ? 38.0
      : 32.0;
  double get h2 => isMobile
      ? 20.0
      : isDesktop
      ? 28.0
      : 24.0;
  double get body => isMobile ? 12.0 : 14.0;
  double get caption => isMobile ? 11.0 : 12.0;

  // Misc helpers
  double get avatarSize => isMobile
      ? 200.0
      : isDesktop
      ? 270.0
      : 230.0;
  double get navBarHeight => 68.0;

  T when<T>({required T mobile, T? tablet, required T desktop}) {
    if (isDesktop) return desktop;
    if (isWide && tablet != null) return tablet;
    if (isMobile) return mobile;
    return tablet ?? mobile;
  }
}

class ResponsiveBuilder extends StatelessWidget {
  final WidgetBuilder mobile;
  final WidgetBuilder? tablet;
  final WidgetBuilder desktop;

  const ResponsiveBuilder({
    super.key,
    required this.mobile,
    this.tablet,
    required this.desktop,
  });

  @override
  Widget build(BuildContext context) {
    final r = ResponsiveHelper.of(context);
    if (r.isDesktop) return desktop(context);
    if (r.isWide && tablet != null) return tablet!(context);
    return mobile(context);
  }
}

extension ResponsiveX on BuildContext {
  ResponsiveHelper get responsive => ResponsiveHelper.of(this);
}
