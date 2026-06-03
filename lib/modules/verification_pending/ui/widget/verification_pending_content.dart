import '../../../../utils/exports.dart';

/// Body content for the account verification pending screen.
class VerificationPendingContent extends StatelessWidget {
  /// Creates [VerificationPendingContent].
  const VerificationPendingContent({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isDark = context.isDark;
    final Color backgroundColor = isDark
        ? AppColors.backgroundDark
        : AppColors.backgroundLight;
    final Color dotColor = isDark
        ? AppColors.primaryPurple.withValues(alpha: 0.15)
        : AppColors.primaryPurple.withValues(alpha: 0.12);
    final Color titleColor = isDark
        ? AppColors.textPrimaryDark
        : AppColors.textPrimaryLight;
    final Color subtitleColor = isDark
        ? AppColors.textSecondaryDark
        : AppColors.textSecondaryLight;
    final Color cardColor = isDark ? AppColors.surfaceDark : AppColors.whiteColor;
    final Color cardBorderColor = isDark
        ? AppColors.borderDark
        : AppColors.borderLight;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Positioned.fill(
            child: CustomPaint(painter: WaveDottedPainter(color: dotColor)),
          ),
          SafeArea(
            child: Column(
              children: <Widget>[
                Dimens.size12.heightBox,
                DecoratedBox(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: isDark
                            ? AppColors.primaryPurple.withValues(alpha: 0.2)
                            : AppColors.primaryPurple.withValues(alpha: 0.08),
                        blurRadius: 30,
                        spreadRadius: 5,
                      ),
                    ],
                  ),
                  child: Assets.png.icCropWekoIcon.image(
                    height: Dimens.size80,
                    width: Dimens.size80,
                    fit: BoxFit.contain,
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(
                      horizontal: Dimens.size16,
                      vertical: Dimens.size8,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Dimens.size16.heightBox,
                        CustomTextLabelWidget(
                          label: context.appString.verificationPendingTitleKey,
                          style: context.textTheme.titleLarge?.copyWith(
                            height: Dimens.lineHeight28.toLineHeight(
                              Dimens.fontSize24,
                            ),
                            fontWeight: FontWeight.w800,
                            fontSize: Dimens.fontSize24,
                            color: titleColor,
                          ),
                        ),
                        Dimens.size8.heightBox,
                        CustomTextLabelWidget(
                          label:
                              context.appString.verificationPendingSubtitleKey,
                          style: context.textTheme.bodyMedium?.copyWith(
                            color: subtitleColor,
                            fontSize: Dimens.fontSize14,
                            height: Dimens.lineHeight20.toLineHeight(
                              Dimens.fontSize14,
                            ),
                          ),
                        ),
                        Dimens.size24.heightBox,
                        CustomTextLabelWidget(
                          label: context
                              .appString
                              .verificationPendingDescriptionKey,
                          style: context.textTheme.bodyMedium?.copyWith(
                            color: subtitleColor,
                            fontSize: Dimens.fontSize14,
                            height: Dimens.lineHeight22.toLineHeight(
                              Dimens.fontSize14,
                            ),
                          ),
                          textAlign: TextAlign.start,
                        ),
                        Dimens.size24.heightBox,
                        _VerificationStatusCard(
                          cardColor: cardColor,
                          borderColor: cardBorderColor,
                          isDark: isDark,
                        ),
                        Dimens.size24.heightBox,
                        CustomTextLabelWidget(
                          label: context.appString.verificationPendingNotifyKey,
                          style: context.textTheme.bodyMedium?.copyWith(
                            color: subtitleColor,
                            fontSize: Dimens.fontSize14,
                            height: Dimens.lineHeight22.toLineHeight(
                              Dimens.fontSize14,
                            ),
                          ),
                          textAlign: TextAlign.start,
                        ),
                        Dimens.size16.heightBox,
                        CustomTextLabelWidget(
                          label:
                              context.appString.verificationPendingThankYouKey,
                          style: context.textTheme.bodyMedium?.copyWith(
                            color: subtitleColor,
                            fontSize: Dimens.fontSize14,
                            height: Dimens.lineHeight22.toLineHeight(
                              Dimens.fontSize14,
                            ),
                          ),
                          textAlign: TextAlign.start,
                        ),
                        Dimens.size32.heightBox,
                        Center(
                          child: CustomRichTextLabel(
                            maxLines: 3,
                            isSpaceNeeded: false,
                            primaryLabel: context
                                .appString
                                .verificationPendingNeedAssistanceKey,
                            secondaryLabel: context
                                .appString
                                .verificationPendingContactSupportKey,
                            primaryStyle: context.textTheme.bodyMedium
                                ?.copyWith(
                              color: subtitleColor,
                              fontSize: Dimens.fontSize14,
                              fontWeight: FontWeight.w400,
                            ),
                            secondaryStyle: context.textTheme.bodyMedium
                                ?.copyWith(
                              color: AppColors.primaryPurple,
                              fontSize: Dimens.fontSize14,
                              fontWeight: FontWeight.w600,
                              decoration: TextDecoration.underline,
                              decorationColor: AppColors.primaryPurple,
                            ),
                            onTapSecondaryLabel: () =>
                                _onContactSupport(context),
                          ),
                        ),
                        Dimens.size24.heightBox,
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _onContactSupport(BuildContext context) async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: 'support@weko.com',
      queryParameters: <String, String>{
        'subject': context.appString.verificationPendingSupportEmailSubjectKey,
      },
    );
    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri);
      return;
    }
    if (context.mounted) {
      displaySnackBar(
        context.appString.verificationPendingContactSupportKey,
        context,
      );
    }
  }
}

class _VerificationStatusCard extends StatelessWidget {
  const _VerificationStatusCard({
    required this.cardColor,
    required this.borderColor,
    required this.isDark,
  });

  final Color cardColor;
  final Color borderColor;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    final Color subtitleColor = isDark
        ? AppColors.textSecondaryDark
        : AppColors.textSecondaryLight;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(Dimens.radius12),
        border: Border.all(
          color: borderColor,
          width: Dimens.borderWidth05,
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: AppColors.primaryPurple.withValues(
              alpha: isDark ? 0.12 : 0.06,
            ),
            blurRadius: Dimens.blurRadius10,
            offset: const Offset(0, Dimens.offset2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(Dimens.size16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            CustomTextLabelWidget(
              label: context.appString.verificationPendingCurrentStatusKey,
              style: context.textTheme.bodySmall?.copyWith(
                color: subtitleColor,
                fontSize: Dimens.fontSize12,
                fontWeight: FontWeight.w500,
                letterSpacing: 0.4,
              ),
            ),
            Dimens.size12.heightBox,
            Row(
              children: <Widget>[
                const Text(
                  '⏳',
                  style: TextStyle(fontSize: Dimens.fontSize20),
                ),
                Dimens.size8.widthBox,
                Expanded(
                  child: CustomTextLabelWidget(
                    label: context
                        .appString
                        .verificationPendingUnderReviewKey,
                    style: context.textTheme.titleMedium?.copyWith(
                      color: AppColors.primaryPurple,
                      fontSize: Dimens.fontSize16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
