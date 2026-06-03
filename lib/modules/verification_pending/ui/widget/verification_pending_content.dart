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
    final Color titleColor = isDark
        ? AppColors.textPrimaryDark
        : AppColors.textPrimaryLight;
    final Color bodyColor = isDark
        ? AppColors.textSecondaryDark
        : AppColors.textSecondaryLight;
    final Color cardColor = isDark ? AppColors.cardDark : AppColors.cardLight;
    final Color iconCircleColor = isDark
        ? AppColors.surfaceDark
        : AppColors.whiteColor;
    final Color iconCircleBorder = isDark
        ? AppColors.borderDark
        : AppColors.borderLight;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          _TopGlowBackground(isDark: isDark),
          SafeArea(
            child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                return SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: Dimens.size24,
                  ),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Dimens.size24.heightBox,
                        _HeaderLogo(isDark: isDark),
                        Dimens.size28.heightBox,
                        CustomTextLabelWidget(
                          label: context.appString.verificationPendingTitleKey,
                          style: context.textTheme.titleLarge?.copyWith(
                            height: Dimens.lineHeight28.toLineHeight(
                              Dimens.fontSize26,
                            ),
                            fontWeight: FontWeight.w800,
                            fontSize: Dimens.fontSize26,
                            color: titleColor,
                          ),
                        ),
                        Dimens.size10.heightBox,
                        CustomTextLabelWidget(
                          label:
                              context.appString.verificationPendingSubtitleKey,
                          style: context.textTheme.bodyMedium?.copyWith(
                            color: bodyColor,
                            fontSize: Dimens.fontSize14,
                            height: Dimens.lineHeight20.toLineHeight(
                              Dimens.fontSize14,
                            ),
                          ),
                        ),
                        Dimens.size32.heightBox,
                        _VerificationStatusCard(
                          cardColor: cardColor,
                          isDark: isDark,
                        ),
                        Dimens.size28.heightBox,
                        _VerificationInfoRow(
                          icon: Icons.mail_outline_rounded,
                          label: context.appString.verificationPendingNotifyKey,
                          bodyColor: bodyColor,
                          iconCircleColor: iconCircleColor,
                          iconCircleBorder: iconCircleBorder,
                        ),
                        Dimens.size20.heightBox,
                        _VerificationInfoRow(
                          icon: Icons.shield_outlined,
                          label: context
                              .appString
                              .verificationPendingProcessingTimeKey,
                          bodyColor: bodyColor,
                          iconCircleColor: iconCircleColor,
                          iconCircleBorder: iconCircleBorder,
                        ),
                        Dimens.size32.heightBox,
                        CustomButtonWidget(
                          title: context
                              .appString
                              .verificationPendingMarkVerifiedKey,
                          height: Dimens.size52,
                          borderRadius: Dimens.radius12,
                          onTap: () => _onVerificationDone(context),
                        ),
                        Dimens.size32.heightBox,
                        CustomTextLabelWidget(
                          label:
                              context.appString.verificationPendingNeedAssistanceKey,
                          style: context.textTheme.bodyMedium?.copyWith(
                            color: titleColor,
                            fontSize: Dimens.fontSize14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Dimens.size8.heightBox,
                        CustomTextLabelWidget(
                          label: context
                              .appString
                              .verificationPendingContactSupportKey,
                          style: context.textTheme.bodyMedium?.copyWith(
                            color: AppColors.primaryPurple,
                            fontSize: Dimens.fontSize14,
                            fontWeight: FontWeight.w600,
                            decoration: TextDecoration.underline,
                            decorationColor: AppColors.primaryPurple,
                          ),
                          onTap: () => _onContactSupport(context),
                        ),
                        Dimens.size32.heightBox,
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _onVerificationDone(BuildContext context) async {
    await AccountVerificationHelper.setVerified();
    if (!context.mounted) {
      return;
    }
    await context.router.replaceAll(<PageRouteInfo>[
      const DashboardRoute(),
    ]);
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

/// Soft purple glow behind the header logo.
class _TopGlowBackground extends StatelessWidget {
  const _TopGlowBackground({required this.isDark});

  final bool isDark;

  @override
  Widget build(BuildContext context) {
    if (!isDark) {
      return const SizedBox.shrink();
    }

    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        width: Dimens.size280,
        height: Dimens.size280,
        margin: const EdgeInsets.only(top: Dimens.size40),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: RadialGradient(
            colors: <Color>[
              AppColors.primaryPurple.withValues(alpha: 0.35),
              AppColors.primaryPurple.withValues(alpha: 0.08),
              Colors.transparent,
            ],
            stops: const <double>[0.0, 0.45, 1.0],
          ),
        ),
      ),
    );
  }
}

class _HeaderLogo extends StatelessWidget {
  const _HeaderLogo({required this.isDark});

  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: AppColors.primaryPurple.withValues(
              alpha: isDark ? 0.45 : 0.15,
            ),
            blurRadius: 40,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Assets.png.icCropWekoIcon.image(
        height: Dimens.size72,
        width: Dimens.size72,
        fit: BoxFit.contain,
      ),
    );
  }
}

class _VerificationStatusCard extends StatelessWidget {
  const _VerificationStatusCard({
    required this.cardColor,
    required this.isDark,
  });

  final Color cardColor;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    final Color labelColor = isDark
        ? AppColors.textSecondaryDark
        : AppColors.textSecondaryLight;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(Dimens.radius24),
        border: Border.all(
          color: isDark
              ? AppColors.borderDark.withValues(alpha: 0.6)
              : AppColors.borderLight,
          width: Dimens.borderWidth05,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(Dimens.size20),
        child: Row(
          children: <Widget>[
            Container(
              width: Dimens.size56,
              height: Dimens.size56,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.primaryPurple.withValues(
                  alpha: isDark ? 0.25 : 0.12,
                ),
              ),
              alignment: Alignment.center,
              child: const Text(
                '⏳',
                style: TextStyle(fontSize: Dimens.fontSize28),
              ),
            ),
            Dimens.size16.widthBox,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  CustomTextLabelWidget(
                    label: context.appString.verificationPendingCurrentStatusKey
                        .toUpperCase(),
                    style: context.textTheme.bodySmall?.copyWith(
                      color: labelColor,
                      fontSize: Dimens.fontSize11,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1.2,
                    ),
                  ),
                  Dimens.size6.heightBox,
                  CustomTextLabelWidget(
                    label: context.appString.verificationPendingUnderReviewKey,
                    style: context.textTheme.titleMedium?.copyWith(
                      color: AppColors.primaryPurple,
                      fontSize: Dimens.fontSize18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _VerificationInfoRow extends StatelessWidget {
  const _VerificationInfoRow({
    required this.icon,
    required this.label,
    required this.bodyColor,
    required this.iconCircleColor,
    required this.iconCircleBorder,
  });

  final IconData icon;
  final String label;
  final Color bodyColor;
  final Color iconCircleColor;
  final Color iconCircleBorder;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: Dimens.size44,
          height: Dimens.size44,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: iconCircleColor,
            border: Border.all(
              color: iconCircleBorder,
              width: Dimens.borderWidth05,
            ),
          ),
          alignment: Alignment.center,
          child: Icon(
            icon,
            size: Dimens.size22,
            color: AppColors.primaryPurple,
          ),
        ),
        Dimens.size14.widthBox,
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: Dimens.size4),
            child: CustomTextLabelWidget(
              label: label,
              style: context.textTheme.bodyMedium?.copyWith(
                color: bodyColor,
                fontSize: Dimens.fontSize14,
                height: Dimens.lineHeight22.toLineHeight(Dimens.fontSize14),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
