import '../../../../utils/exports.dart';

/// Theme-aware colors for gradient app bars.
class GradientAppBarColors {
  /// Creates [GradientAppBarColors].
  const GradientAppBarColors({
    required this.background,
    required this.surfaceTint,
    required this.gradientColors,
    required this.elevatedBackground,
    required this.glowColor,
    required this.shadowColor,
    required this.iconColor,
    required this.titleColor,
  });

  /// Resolves colors from [BuildContext] (light / dark).
  factory GradientAppBarColors.of(BuildContext context) {
    final bool isDark = context.isDark;
    if (isDark) {
      return GradientAppBarColors(
        background: AppColors.backgroundDark,
        surfaceTint: AppColors.backgroundDark,
        gradientColors: const <Color>[
          AppColors.backgroundDark,
          AppColors.surfaceDark,
          AppColors.cardDark,
        ],
        elevatedBackground: AppColors.cardDark,
        glowColor: AppColors.primaryPurple,
        shadowColor: AppColors.primaryPurple.withValues(alpha: 0.3),
        iconColor: AppColors.textPrimaryDark,
        titleColor: AppColors.textPrimaryDark,
      );
    }
    return GradientAppBarColors(
      background: AppColors.backgroundLight,
      surfaceTint: AppColors.backgroundLight,
      gradientColors: const <Color>[
        AppColors.backgroundLight,
        AppColors.surfaceLight,
        AppColors.cardLight,
      ],
      elevatedBackground: AppColors.cardLight,
      glowColor: AppColors.primaryPurple,
      shadowColor: AppColors.primaryPurple.withValues(alpha: 0.15),
      iconColor: AppColors.textPrimaryLight,
      titleColor: AppColors.textPrimaryLight,
    );
  }

  /// App bar background.
  final Color background;

  /// Material 3 surface tint.
  final Color surfaceTint;

  /// Header gradient stops.
  final List<Color> gradientColors;

  /// Back button container fill.
  final Color elevatedBackground;

  /// Accent for borders and glow.
  final Color glowColor;

  /// Elevation shadow.
  final Color shadowColor;

  /// Leading icon color.
  final Color iconColor;

  /// Title text color.
  final Color titleColor;
}

/// Fixed gradient app bar with styled back button (use in [Scaffold.appBar] or body).
class GradientAppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  /// Creates [GradientAppBarWidget].
  const GradientAppBarWidget({
    super.key,
    required this.title,
    this.onBackPressed,
    this.height = Dimens.size60,
    this.elevation = Dimens.elevation4,
    this.actions,
    this.automaticallyImplyLeading = true,
  });

  /// App bar title.
  final String title;

  /// Back action; defaults to [goBack].
  final VoidCallback? onBackPressed;

  /// Toolbar height.
  final double height;

  /// App bar elevation.
  final double elevation;

  /// Optional trailing actions.
  final List<Widget>? actions;

  /// When false, hides the custom leading back control.
  final bool automaticallyImplyLeading;

  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  Widget build(BuildContext context) {
    final GradientAppBarColors colors = GradientAppBarColors.of(context);
    final bool isRTL = Directionality.of(context) == TextDirection.rtl;

    return AppBar(
      toolbarHeight: height,
      backgroundColor: colors.background,
      surfaceTintColor: colors.surfaceTint,
      elevation: elevation,
      shadowColor: colors.shadowColor,
      iconTheme: IconThemeData(color: colors.iconColor),
      automaticallyImplyLeading: false,
      leading: automaticallyImplyLeading
          ? IconButton(
              onPressed: onBackPressed ?? () => goBack(context),
              icon: RotatedIcon(
                isLanguageAlignmentLTR: !isRTL,
                iconWidget: Assets.svgs.icBack.svg(
                  height: Dimens.size20,
                  width: Dimens.size20,
                  color: colors.iconColor,
                ),
              ),
            )
          : null,
      title: CustomTextLabelWidget(
        label: title,
        style: context.textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.w800,
          fontSize: Dimens.fontSize18,
          color: colors.titleColor,
        ),
      ),
      actions: actions,
      flexibleSpace: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: colors.gradientColors,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
      ),
    );
  }
}

/// Sliver wrapper around [GradientAppBarWidget] for scrollable screens only.
class GradientSliverAppBarWidget extends StatelessWidget {
  /// Creates [GradientSliverAppBarWidget].
  const GradientSliverAppBarWidget({
    super.key,
    required this.title,
    this.onBackPressed,
    this.height = Dimens.size60,
    this.elevation = Dimens.elevation4,
    this.actions,
    this.automaticallyImplyLeading = true,
  });

  /// App bar title.
  final String title;

  /// Back action; defaults to [goBack].
  final VoidCallback? onBackPressed;

  /// Toolbar height.
  final double height;

  /// App bar elevation.
  final double elevation;

  /// Optional trailing actions.
  final List<Widget>? actions;

  /// When false, hides the custom leading back control.
  final bool automaticallyImplyLeading;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: GradientAppBarWidget(
        title: title,
        onBackPressed: onBackPressed,
        height: height,
        elevation: elevation,
        actions: actions,
        automaticallyImplyLeading: automaticallyImplyLeading,
      ),
    );
  }
}
