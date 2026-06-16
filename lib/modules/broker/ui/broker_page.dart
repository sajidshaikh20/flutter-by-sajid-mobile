import '../../../utils/exports.dart';

@RoutePage()
class BrokerPage extends BaseResponsiveView {
  const BrokerPage({super.key});

  @override
  Widget buildDesktopWidget(BuildContext context) => _build(context);

  @override
  Widget buildTabletWidget(BuildContext context) => _build(context);

  @override
  Widget buildMobileWidget(BuildContext context) => _build(context);

  Widget _build(BuildContext context) {
    return BlocProvider<BrokerCubit>(
      create: (BuildContext context) => BrokerCubit(),
      child: const BrokerViewBody(),
    );
  }
}

class BrokerViewBody extends StatefulWidget {
  const BrokerViewBody({super.key});

  @override
  State<BrokerViewBody> createState() => _BrokerViewBodyState();
}

class _BrokerViewBodyState extends State<BrokerViewBody> {
  @override
  Widget build(BuildContext context) {
    final bool isDark = context.isDark;
    final Color pageBg = isDark ? AppColors.backgroundDark : AppColors.backgroundLight;
    final Color textColor = isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight;
    final Color cardBorder = isDark ? AppColors.borderDark : AppColors.borderLight;

    return BlocBuilder<BrokerCubit, BrokerState>(
      builder: (BuildContext context, BrokerState state) {
        return Scaffold(
          backgroundColor: pageBg,
          body: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // Header (Back button + Title)
                _buildHeader(context, isDark, textColor, cardBorder),

                // Content View (Scrollable list of brokers)
                Expanded(
                  child: ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.symmetric(horizontal: Dimens.space16, vertical: Dimens.space8),
                    itemCount: state.brokers.length,
                    separatorBuilder: (BuildContext ctx, int index) => const SizedBox(height: Dimens.space16),
                    itemBuilder: (BuildContext ctx, int index) {
                      final BrokerModel broker = state.brokers[index];
                      return _buildBrokerCard(context, isDark, textColor, cardBorder, broker);
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildHeader(BuildContext context, bool isDark, Color textColor, Color borderCol) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: Dimens.space16,
        vertical: Dimens.space12,
      ),
      child: Row(
        children: <Widget>[
          GestureDetector(
            onTap: () => context.router.back(),
            child: Container(
              padding: const EdgeInsets.all(Dimens.space8),
              decoration: BoxDecoration(
                color: isDark ? AppColors.surfaceDark : Colors.white,
                shape: BoxShape.circle,
                border: Border.all(color: borderCol),
              ),
              child: Icon(
                Icons.arrow_back_ios_new_rounded,
                color: textColor,
                size: Dimens.size16,
              ),
            ),
          ),
          const SizedBox(width: Dimens.space12),
          Expanded(
            child: Row(
              children: <Widget>[
                Icon(
                  Icons.business_center_outlined,
                  color: isDark ? AppColors.successColor : AppColors.primaryPurple,
                  size: Dimens.size24,
                ),
                const SizedBox(width: Dimens.space8),
                CustomTextLabelWidget(
                  label: 'Top Brokers',
                  style: TextStyle(
                    fontSize: Dimens.fontSize20,
                    fontWeight: FontWeight.w900,
                    color: textColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBrokerCard(
    BuildContext context,
    bool isDark,
    Color textColor,
    Color borderCol,
    BrokerModel broker,
  ) {
    final Color subtextColor = isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight;
    final Color cardBg = isDark ? const Color(0xFF0F1524) : Colors.white;
    final Color badgeBg = isDark ? const Color(0xFF1E2838) : Colors.grey.shade100;
    final Color openBtnBg = isDark ? Colors.white : AppColors.primaryPurple;
    final Color openBtnText = isDark ? Colors.black : Colors.white;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(Dimens.radius16),
        border: Border.all(color: borderCol, width: 0.8),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.25 : 0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(Dimens.space16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Top section: Details + 3D Logo Block
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // Left Details Column
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      // Name & Category Badge Row
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Flexible(
                            child: CustomTextLabelWidget(
                              label: broker.name,
                              style: TextStyle(
                                fontSize: Dimens.fontSize18,
                                fontWeight: FontWeight.bold,
                                color: textColor,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(width: Dimens.space8),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: badgeBg,
                              borderRadius: BorderRadius.circular(Dimens.radius6),
                            ),
                            child: CustomTextLabelWidget(
                              label: broker.badge.toUpperCase(),
                              style: TextStyle(
                                fontSize: 8,
                                fontWeight: FontWeight.w900,
                                color: isDark ? Colors.white70 : Colors.black87,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 2),

                      // Broker type description
                      CustomTextLabelWidget(
                        label: broker.brokerType,
                        style: TextStyle(
                          fontSize: Dimens.fontSize11,
                          color: subtextColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: Dimens.space12),

                      // Tradable assets info
                      RichText(
                        text: TextSpan(
                          style: TextStyle(
                            fontSize: Dimens.fontSize11,
                            color: subtextColor,
                            fontFamily: FontFamily.inter,
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text: 'Tradable assets: ',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: textColor.withValues(alpha: 0.9),
                              ),
                            ),
                            TextSpan(text: broker.assets),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: Dimens.space12),

                // Right 3D offset logo block
                SizedBox(
                  width: 85,
                  height: 85,
                  child: Stack(
                    children: <Widget>[
                      // Offset colored backing shadow
                      Positioned(
                        right: 0,
                        bottom: 0,
                        child: Container(
                          width: 76,
                          height: 76,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(Dimens.radius20),
                            color: isDark ? AppColors.primaryPurple.withValues(alpha: 0.8) : const Color(0xFFE8DFFF),
                          ),
                        ),
                      ),
                      // Main white container carrying logo image
                      Positioned(
                        left: 0,
                        top: 0,
                        child: Container(
                          width: 76,
                          height: 76,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(Dimens.radius20),
                            border: Border.all(
                              color: isDark ? AppColors.borderDark : Colors.grey.shade300,
                              width: 0.8,
                            ),
                          ),
                          padding: const EdgeInsets.all(6),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Image.network(
                              broker.logoUrl,
                              fit: BoxFit.contain,
                              errorBuilder: (BuildContext ctx, Object err, StackTrace? stack) {
                                return Container(
                                  color: Colors.white,
                                  alignment: Alignment.center,
                                  child: CustomTextLabelWidget(
                                    label: broker.name.substring(0, 1).toUpperCase(),
                                    style: const TextStyle(
                                      color: AppColors.primaryPurple,
                                      fontWeight: FontWeight.w900,
                                      fontSize: Dimens.fontSize24,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: Dimens.space12),

            // Middle section: Ratings and stats row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                // Rating details with dynamic star icons
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    CustomTextLabelWidget(
                      label: '${broker.rating} • ${broker.ratingText}',
                      style: TextStyle(
                        fontSize: Dimens.fontSize11,
                        color: textColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Row(
                      children: List<Widget>.generate(5, (int index) {
                        final double starVal = index + 1.0;
                        IconData icon = Icons.star_rounded;
                        Color starColor = const Color(0xFFFFC107);
                        if (broker.rating < starVal) {
                          if (broker.rating >= starVal - 0.5) {
                            icon = Icons.star_half_rounded;
                          } else {
                            icon = Icons.star_outline_rounded;
                            starColor = isDark ? Colors.white30 : Colors.black12;
                          }
                        }
                        return Icon(icon, color: starColor, size: Dimens.size14);
                      }),
                    ),
                  ],
                ),

                // Reviews count
                Row(
                  children: <Widget>[
                    Icon(Icons.chat_bubble_outline_rounded, color: subtextColor, size: Dimens.size16),
                    const SizedBox(width: Dimens.space6),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        CustomTextLabelWidget(
                          label: broker.reviewsCount,
                          style: TextStyle(
                            fontSize: Dimens.fontSize11,
                            fontWeight: FontWeight.bold,
                            color: textColor,
                          ),
                        ),
                        CustomTextLabelWidget(
                          label: 'Reviews',
                          style: TextStyle(fontSize: 8, color: subtextColor),
                        ),
                      ],
                    ),
                  ],
                ),

                // Accounts count
                Row(
                  children: <Widget>[
                    Icon(Icons.person_outline_rounded, color: subtextColor, size: Dimens.size16),
                    const SizedBox(width: Dimens.space6),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        CustomTextLabelWidget(
                          label: broker.accountsCount,
                          style: TextStyle(
                            fontSize: Dimens.fontSize11,
                            fontWeight: FontWeight.bold,
                            color: textColor,
                          ),
                        ),
                        CustomTextLabelWidget(
                          label: 'Accounts',
                          style: TextStyle(fontSize: 8, color: subtextColor),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: Dimens.space16),

            // Bottom section: Open Account Redirect Button (NO Learn More button as requested)
            SizedBox(
              height: 40,
              child: ElevatedButton(
                onPressed: () {
                  unawaited(context.read<BrokerCubit>().openBrokerLink(broker.redirectUrl));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: openBtnBg,
                  foregroundColor: openBtnText,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(Dimens.radius8),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    CustomTextLabelWidget(
                      label: 'Open account',
                      style: TextStyle(
                        color: openBtnText,
                        fontSize: Dimens.fontSize12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: Dimens.space6),
                    Icon(
                      Icons.call_made_rounded,
                      color: openBtnText,
                      size: Dimens.size12,
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
