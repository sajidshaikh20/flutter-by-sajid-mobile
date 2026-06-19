import '../../../utils/exports.dart';

/// A premium, visually-appealing widget shown when a feature is locked
/// because the user does not have an active subscription.
class SubscriptionLockWidget extends StatelessWidget {
  /// Creates a [SubscriptionLockWidget].
  const SubscriptionLockWidget({
    super.key,
    this.title = 'Unlock Premium Trades',
    this.subtitle = 'Access to high-probability trade setups is reserved for active subscribers.',
  });

  /// The main heading text.
  final String title;

  /// The explanation subtext.
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    final bool isDark = context.isDark;
    final Color textColor = isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight;
    final Color subtextColor = isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight;
    final Color cardBg = isDark ? const Color(0xFF131828) : const Color(0xFFF3F6FF);
    final Color cardBorder = isDark 
        ? AppColors.primaryPurple.withValues(alpha: 0.2) 
        : AppColors.primaryPurple.withValues(alpha: 0.1);

    return Center(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: Dimens.space24, vertical: Dimens.space20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Glowing Lock Icon
            Container(
              width: 90,
              height: 90,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: <Color>[
                    AppColors.primaryPurple.withValues(alpha: 0.2),
                    AppColors.primaryPurple.withValues(alpha: 0.0),
                  ],
                ),
              ),
              child: Center(
                child: Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    color: isDark ? AppColors.surfaceDark : Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: AppColors.primaryPurple.withValues(alpha: isDark ? 0.3 : 0.15),
                        blurRadius: 16,
                        offset: const Offset(0, 8),
                      ),
                    ],
                    border: Border.all(
                      color: AppColors.primaryPurple.withValues(alpha: 0.3),
                      width: 1.5,
                    ),
                  ),
                  child: const ShaderMask(
                    shaderCallback: _gradientShader,
                    child: Icon(
                      Icons.lock_rounded,
                      color: Colors.white,
                      size: Dimens.size32,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: Dimens.space24),

            // Title
            CustomTextLabelWidget(
              label: title,
              style: TextStyle(
                fontSize: Dimens.fontSize20,
                fontWeight: FontWeight.w900,
                color: textColor,
                letterSpacing: -0.5,
              ),
            ),
            const SizedBox(height: Dimens.space8),

            // Subtitle
            CustomTextLabelWidget(
              label: subtitle,
              style: TextStyle(
                fontSize: Dimens.fontSize13,
                color: subtextColor,
                height: 1.4,
              ),
              maxLines: 3,
            ),
            const SizedBox(height: Dimens.space28),

            // Premium Features Checklist Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(Dimens.space16),
              decoration: BoxDecoration(
                color: cardBg,
                borderRadius: BorderRadius.circular(Dimens.radius16),
                border: Border.all(color: cardBorder),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const CustomTextLabelWidget(
                    label: 'UNLOCKED WITH PREMIUM',
                    style: TextStyle(
                      fontSize: Dimens.fontSize10,
                      fontWeight: FontWeight.w900,
                      color: AppColors.primaryPurple,
                      letterSpacing: 1.2,
                    ),
                  ),
                  const SizedBox(height: Dimens.space14),
                  _buildFeatureRow('Live Crypto & Forex trade signals'),
                  _buildFeatureRow('Detailed entry, take profit & stop loss levels'),
                  _buildFeatureRow('Real-time push notification updates'),
                  _buildFeatureRow('Full historic performance metrics & track records'),
                ],
              ),
            ),
            const SizedBox(height: Dimens.space32),

            // Main Gradient Button
            GestureDetector(
              onTap: () {
                unawaited(context.router.push(const SubscriptionPlansRoute()));
              },
              child: Container(
                height: 52,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: AppColors.primaryGradient,
                  ),
                  borderRadius: BorderRadius.circular(Dimens.radius12),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: AppColors.primaryPurple.withValues(alpha: isDark ? 0.35 : 0.2),
                      blurRadius: 14,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.star_rounded,
                      color: Colors.white,
                      size: Dimens.size18,
                    ),
                    SizedBox(width: Dimens.space8),
                    CustomTextLabelWidget(
                      label: 'View Subscription Plans',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: Dimens.fontSize14,
                      ),
                    ),
                    SizedBox(width: Dimens.space8),
                    Icon(
                      Icons.arrow_forward_rounded,
                      color: Colors.white,
                      size: Dimens.size16,
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

  static Shader _gradientShader(Rect bounds) {
    return AppColors.primaryButtonGradient.createShader(bounds);
  }

  Widget _buildFeatureRow(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: Dimens.space10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Icon(
            Icons.check_circle_rounded,
            color: AppColors.primaryPurple,
            size: Dimens.size16,
          ),
          const SizedBox(width: Dimens.space10),
          Expanded(
            child: CustomTextLabelWidget(
              label: text,
              style: const TextStyle(
                fontSize: Dimens.fontSize12,
                fontWeight: FontWeight.w600,
                height: 1.3,
              ),
              textAlign: TextAlign.start,
            ),
          ),
        ],
      ),
    );
  }
}
