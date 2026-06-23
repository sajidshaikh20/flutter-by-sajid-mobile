import '../../../utils/exports.dart';

@RoutePage()
/// Tool tab displaying available calculation and planning tools.
class ToolPage extends BaseResponsiveView {
  const ToolPage({super.key});

  @override
  Widget buildDesktopWidget(BuildContext context) => _build(context);

  @override
  Widget buildTabletWidget(BuildContext context) => _build(context);

  @override
  Widget buildMobileWidget(BuildContext context) => _build(context);

  Widget _build(BuildContext context) {
    final bool isDark = context.isDark;
    final Color textColor = isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight;
    final Color subtextColor = isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight;
    final Color pageBg = isDark ? AppColors.backgroundDark : AppColors.backgroundLight;

    return Scaffold(
      backgroundColor: pageBg,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Use common app bar without action buttons as requested
            const HomeHeaderAppBar(
              showProfileImage: false,
              showNotification: false,
              title: 'Tools',
            ),
            
            // Main scrollable body
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: Dimens.space16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const SizedBox(height: Dimens.space8),
                    // Header Banner Card
                    _buildHeaderBanner(context, isDark, textColor, subtextColor),
                    const SizedBox(height: Dimens.space28),
                    
                    // Section Title
                    CustomTextLabelWidget(
                      label: 'All Tools',
                      style: TextStyle(
                        color: textColor,
                        fontSize: Dimens.fontSize18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: Dimens.space16),
                    // PIP Calculator Card
                    _buildPipCalculatorCard(context, isDark, textColor, subtextColor),
                    const SizedBox(height: Dimens.space16),
                    // Compound Interest Card
                    _buildCompoundInterestCard(context, isDark, textColor, subtextColor),
                    const SizedBox(height: Dimens.space24),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderBanner(BuildContext context, bool isDark, Color textColor, Color subtextColor) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF130E26) : const Color(0xFFF1EAFF),
        borderRadius: BorderRadius.circular(Dimens.radius16),
        border: Border.all(
          color: isDark ? AppColors.borderDark : AppColors.borderLight,
        ),
        boxShadow: <BoxShadow>[
          if (isDark)
            BoxShadow(
              color: AppColors.primaryPurple.withValues(alpha: 0.15),
              blurRadius: 16,
              offset: const Offset(0, 4),
            ),
        ],
      ),
      padding: const EdgeInsets.all(Dimens.space16),
      child: Row(
        children: <Widget>[
          // Left Text Panel
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                // Styled title
                RichText(
                  text: TextSpan(
                    style: const TextStyle(
                      fontSize: Dimens.fontSize22,
                      fontWeight: FontWeight.w800,
                      fontFamily: AppConstant.interFontFamily,
                      height: 1.25,
                    ),
                    children: <TextSpan>[
                      const TextSpan(
                        text: 'Smart ',
                        style: TextStyle(color: AppColors.primaryPurple),
                      ),
                      TextSpan(
                        text: 'tools for\n',
                        style: TextStyle(color: textColor),
                      ),
                      const TextSpan(
                        text: 'smarter ',
                        style: TextStyle(color: AppColors.primaryPurple),
                      ),
                      TextSpan(
                        text: 'decisions',
                        style: TextStyle(color: textColor),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: Dimens.space10),
                CustomTextLabelWidget(
                  label: 'Calculate, plan and grow with confidence',
                  style: TextStyle(
                    color: subtextColor,
                    fontSize: Dimens.fontSize12,
                    fontWeight: FontWeight.w400,
                    height: 1.3,
                  ),
                  textAlign: TextAlign.start,
                ),
              ],
            ),
          ),
          
          // Right floating 3D graphic panel
          const HeaderGraphic(),
        ],
      ),
    );
  }

  Widget _buildPipCalculatorCard(BuildContext context, bool isDark, Color textColor, Color subtextColor) {
    final Color cardBg = isDark ? const Color(0xFF0F0B22) : Colors.white;
    final Color borderCol = isDark ? AppColors.borderDark : AppColors.borderLight.withValues(alpha: 0.7);

    return GestureDetector(
      onTap: () => context.router.push(const PipCalculatorRoute()),
      child: Container(
        width: double.infinity,
        height: 140,
        decoration: BoxDecoration(
          color: cardBg,
          borderRadius: BorderRadius.circular(Dimens.radius16),
          border: Border.all(color: borderCol),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.black.withValues(alpha: isDark ? 0.2 : 0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(Dimens.radius16),
        child: Padding(
          padding: const EdgeInsets.all(Dimens.space16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // Top Row (Icon, Info, Arrow Button)
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  // Glowing Icon Container
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimens.radius12),
                      gradient: const LinearGradient(
                        colors: <Color>[
                          Color(0xFF9F5DFF),
                          Color(0xFF7024FF),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                          color: AppColors.primaryPurple.withValues(alpha: 0.35),
                          blurRadius: 8,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    alignment: Alignment.center,
                    child: const Icon(
                      Icons.calculate_outlined,
                      color: AppColors.whiteColor,
                      size: Dimens.size26,
                    ),
                  ),
                  const SizedBox(width: Dimens.space12),

                  // Title and Subtitle
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const SizedBox(height: 2),
                        CustomTextLabelWidget(
                          label: 'PIP Calculator',
                          style: TextStyle(
                            color: textColor,
                            fontSize: Dimens.fontSize16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 4),
                        CustomTextLabelWidget(
                          label: 'Calculate pip value for any currency pair',
                          style: TextStyle(
                            color: subtextColor,
                            fontSize: Dimens.fontSize12,
                            fontWeight: FontWeight.w400,
                          ),
                          textAlign: TextAlign.start,
                          maxLines: 2,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: Dimens.space8),

                  // Arrow circle button
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isDark ? const Color(0xFF1E1736) : const Color(0xFFF1EAFF),
                    ),
                    alignment: Alignment.center,
                    child: Icon(
                      Icons.arrow_forward_rounded,
                      color: isDark ? AppColors.whiteColor : AppColors.primaryPurple,
                      size: Dimens.size18,
                    ),
                  ),
                ],
              ),
              const Spacer(),

              // Popular Badge
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimens.radius20),
                  color: AppColors.primaryPurple,
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Icon(
                      Icons.star_rounded,
                      color: AppColors.whiteColor,
                      size: Dimens.size12,
                    ),
                    SizedBox(width: Dimens.space4),
                    CustomTextLabelWidget(
                      label: 'Popular',
                      style: TextStyle(
                        color: AppColors.whiteColor,
                        fontSize: Dimens.fontSize10,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

  Widget _buildCompoundInterestCard(BuildContext context, bool isDark, Color textColor, Color subtextColor) {
    final Color cardBg = isDark ? const Color(0xFF0F0B22) : Colors.white;
    final Color borderCol = isDark ? AppColors.borderDark : AppColors.borderLight.withValues(alpha: 0.7);

    return GestureDetector(
      onTap: () => context.router.push(const CompoundInterestRoute()),
      child: Container(
        width: double.infinity,
        height: 140,
        decoration: BoxDecoration(
          color: cardBg,
          borderRadius: BorderRadius.circular(Dimens.radius16),
          border: Border.all(color: borderCol),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.black.withValues(alpha: isDark ? 0.2 : 0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(Dimens.radius16),
        child: Padding(
          padding: const EdgeInsets.all(Dimens.space16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // Top Row (Icon, Info, Arrow Button)
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  // Glowing Icon Container
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimens.radius12),
                      gradient: const LinearGradient(
                        colors: <Color>[
                          Color(0xFF9F5DFF),
                          Color(0xFF7024FF),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                          color: AppColors.primaryPurple.withValues(alpha: 0.35),
                          blurRadius: 8,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    alignment: Alignment.center,
                    child: const Icon(
                      Icons.pie_chart_outline_rounded,
                      color: AppColors.whiteColor,
                      size: Dimens.size26,
                    ),
                  ),
                  const SizedBox(width: Dimens.space12),

                  // Title and Subtitle
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const SizedBox(height: 2),
                        CustomTextLabelWidget(
                          label: 'Compound Interest',
                          style: TextStyle(
                            color: textColor,
                            fontSize: Dimens.fontSize16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 4),
                        CustomTextLabelWidget(
                          label: 'Calculate future value of your investments',
                          style: TextStyle(
                            color: subtextColor,
                            fontSize: Dimens.fontSize12,
                            fontWeight: FontWeight.w400,
                          ),
                          textAlign: TextAlign.start,
                          maxLines: 2,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: Dimens.space8),

                  // Arrow circle button
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isDark ? const Color(0xFF1E1736) : const Color(0xFFF1EAFF),
                    ),
                    alignment: Alignment.center,
                    child: Icon(
                      Icons.arrow_forward_rounded,
                      color: isDark ? AppColors.whiteColor : AppColors.primaryPurple,
                      size: Dimens.size18,
                    ),
                  ),
                ],
              ),
              const Spacer(),

              // Popular Badge
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimens.radius20),
                  color: AppColors.primaryPurple,
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Icon(
                      Icons.star_rounded,
                      color: AppColors.whiteColor,
                      size: Dimens.size12,
                    ),
                    SizedBox(width: Dimens.space4),
                    CustomTextLabelWidget(
                      label: 'Popular',
                      style: TextStyle(
                        color: AppColors.whiteColor,
                        fontSize: Dimens.fontSize10,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
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

class HeaderGraphic extends StatelessWidget {
  const HeaderGraphic({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 130,
      height: 100,
      child: Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none,
        children: <Widget>[
          // Glowing background shadow
          Positioned(
            right: 0,
            top: 10,
            child: Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: AppColors.primaryPurple.withValues(alpha: 0.35),
                    blurRadius: 25,
                    spreadRadius: 10,
                  ),
                ],
              ),
            ),
          ),

          // Floating 3D-like Calculator Graphic
          Positioned(
            right: 5,
            top: 0,
            child: Transform.rotate(
              angle: 0.1,
              child: Container(
                width: 65,
                height: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimens.radius12),
                  gradient: const LinearGradient(
                    colors: <Color>[
                      Color(0xFFB480FF),
                      Color(0xFF8B40FF),
                      Color(0xFF5A16DF),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.3),
                      blurRadius: 10,
                      offset: const Offset(3, 6),
                    ),
                  ],
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.2),
                  ),
                ),
                padding: const EdgeInsets.all(7),
                child: Column(
                  children: <Widget>[
                    // Screen
                    Container(
                      height: 16,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: const Color(0xFF321A70),
                        borderRadius: BorderRadius.circular(Dimens.radius4),
                      ),
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: Container(
                        width: 20,
                        height: 3,
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.7),
                          borderRadius: BorderRadius.circular(1),
                        ),
                      ),
                    ),
                    const SizedBox(height: 6),
                    // Buttons
                    Expanded(
                      child: GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 3,
                          mainAxisSpacing: 3,
                          childAspectRatio: 1.2,
                        ),
                        itemCount: 9,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.15),
                              borderRadius: BorderRadius.circular(2),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          
          // Tiny 3D Coins/Bars
          Positioned(
            right: 0,
            bottom: 5,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  width: 14,
                  height: 8,
                  decoration: BoxDecoration(
                    color: const Color(0xFFC5A0FF),
                    borderRadius: BorderRadius.circular(2),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.2),
                        blurRadius: 2,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 3),
                Container(
                  width: 14,
                  height: 12,
                  decoration: BoxDecoration(
                    color: const Color(0xFFD4B8FF),
                    borderRadius: BorderRadius.circular(2),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.2),
                        blurRadius: 2,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
