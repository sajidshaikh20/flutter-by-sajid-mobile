import '../../../utils/exports.dart';

@RoutePage()
class SocialLoginPage extends BaseResponsiveView {
  /// Creates a social login page.
  const SocialLoginPage({super.key});

  /// Builds the social login view with BlocProvider.
  Widget buildView(BuildContext context) {
    final bool isDark = context.isDark;

    // Choose premium colors based on the theme
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

    return BlocProvider<SocialLoginCubit>(
      create: (BuildContext ctx) => SocialLoginCubit(
        initialState: const SocialLoginState(status: BaseStateStatus.initial),
        loginRepository: LoginRepositoryImpl(),
      ),
      child: BlocConsumer<SocialLoginCubit, SocialLoginState>(
        listener: (BuildContext context, SocialLoginState state) async {
          DebugLog.instance.i(
            'SocialLogin BlocListener - Status: ${state.status}, RedirectRoute: ${state.redirectRoute}',
          );

          if (state.msg != null && (state.msg?.isNotEmpty ?? false)) {
            displaySnackBar(state.msg ?? '', context);
            context.read<SocialLoginCubit>().clearMsg();
          }

          // Navigate on success status with a small delay
          if (state.status == BaseStateStatus.success) {
            DebugLog.instance.i(
              'Success status detected, attempting navigation...',
            );
            // Add a small delay to ensure the state is fully processed
            await Future<void>.delayed(const Duration(milliseconds: 100));
            try {
              if (context.mounted) {
                final PageRouteInfo route =
                    state.redirectRoute ??
                    AccountVerificationHelper.resolvePostLoginRoute();
                await context.router.push(route);
                DebugLog.instance.i('Navigation completed successfully');
              }
            } on Exception catch (e) {
              DebugLog.instance.e('Navigation failed: $e');
            }
          }
        },
        builder: (BuildContext context, SocialLoginState state) {
          return Scaffold(
            backgroundColor: backgroundColor,
            resizeToAvoidBottomInset: false,
            body: Stack(
              fit: StackFit.expand,
              children: <Widget>[
                // 1. Dynamic bottom wave dotted pattern
                Positioned.fill(
                  child: CustomPaint(
                    painter: WaveDottedPainter(color: dotColor),
                  ),
                ),
                SafeArea(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,

                    children: <Widget>[
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            /// TOP SECTION
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: Dimens.size24,
                              ),
                              child: Column(
                                children: <Widget>[
                                  DecoratedBox(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      boxShadow: <BoxShadow>[
                                        BoxShadow(
                                          color: isDark
                                              ? AppColors.primaryPurple
                                                    .withValues(alpha: 0.2)
                                              : AppColors.primaryPurple
                                                    .withValues(alpha: 0.08),
                                          blurRadius: 30,
                                          spreadRadius: 5,
                                        ),
                                      ],
                                    ),
                                    child: Assets.png.icCropWekoIcon.image(
                                      height: Dimens.size110,
                                      width: Dimens.size110,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                  CustomTextLabelWidget(
                                    label: context.appString.welcomeBackKey,
                                    style: context.textTheme.headlineLarge
                                        ?.copyWith(
                                          fontWeight: FontWeight.w800,
                                          fontSize: Dimens.fontSize30,
                                          color: titleColor,
                                          letterSpacing: 0.5,
                                        ),
                                  ),

                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: Dimens.size16,
                                    ),
                                    child: CustomTextLabelWidget(
                                      label: context.appString.loginSignupKey,
                                      style: context.textTheme.bodyMedium
                                          ?.copyWith(
                                            fontWeight: FontWeight.w500,
                                            color: subtitleColor,
                                            fontSize: Dimens.fontSize14,
                                            height: Dimens.lineHeight20
                                                .toLineHeight(
                                                  Dimens.fontSize14,
                                                ),
                                          ),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: Dimens.size24,
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  CustomButtonWidget(
                                    title:
                                        context.appString.continueWithGoogleKey,
                                    height: Dimens.size52,
                                    borderRadius: Dimens.radius12,
                                    backgroundColor: isDark
                                        ? AppColors.surfaceDark
                                        : AppColors.whiteColor,
                                    borderColor: isDark
                                        ? AppColors.borderDark
                                        : AppColors.borderLight,
                                    hasBorder: true,
                                    childWidget: Stack(
                                      alignment: Alignment.center,
                                      children: <Widget>[
                                        Positioned(
                                          left: Dimens.size12,
                                          child: Assets.svgs.icGoogleIcon.svg(),
                                        ),
                                        CustomTextLabelWidget(
                                          label: context
                                              .appString
                                              .continueWithGoogleKey,
                                          style: context.textTheme.bodyLarge
                                              ?.copyWith(
                                                fontWeight: FontWeight.w600,
                                                fontSize: Dimens.fontSize12,
                                                color: isDark
                                                    ? AppColors.textPrimaryDark
                                                    : AppColors
                                                          .textPrimaryLight,
                                              ),
                                        ),
                                      ],
                                    ),
                                    onTap: () async {
                                      await context
                                          .read<SocialLoginCubit>()
                                          .socialLoginWithGoogle();
                                    },
                                  ),

                                  Dimens.size16.heightBox,

                                  CustomButtonWidget(
                                    title: 'Continue with WhatsApp',
                                    height: Dimens.size52,
                                    borderRadius: Dimens.radius12,
                                    backgroundColor: isDark
                                        ? AppColors.surfaceDark
                                        : AppColors.whiteColor,
                                    borderColor: isDark
                                        ? AppColors.borderDark
                                        : AppColors.borderLight,
                                    hasBorder: true,
                                    childWidget: Stack(
                                      alignment: Alignment.center,
                                      children: <Widget>[
                                        Positioned(
                                          left: Dimens.size10,
                                          child: Assets.svgs.icWp.svg(),
                                        ),
                                        CustomTextLabelWidget(
                                          label:
                                          'Continue with WhatsApp',
                                          style: context.textTheme.bodyLarge
                                              ?.copyWith(
                                                fontWeight: FontWeight.w600,
                                                fontSize: Dimens.fontSize12,
                                                color: isDark
                                                    ? AppColors.textPrimaryDark
                                                    : AppColors
                                                          .textPrimaryLight,
                                              ),
                                        ),
                                      ],
                                    ),
                                    onTap: () async {
                                      await context.router.push(
                                        const WhatsAppLoginRoute(),
                                      );
                                    },
                                  ),

                                  Dimens.size16.heightBox,

                                  CustomButtonWidget(
                                    title: context
                                        .appString
                                        .continueWithMobileEmailKey,
                                    height: Dimens.size52,
                                    borderRadius: Dimens.radius12,
                                    childWidget: Stack(
                                      alignment: Alignment.center,
                                      children: <Widget>[
                                        const Positioned(
                                          left: Dimens.size12,
                                          child: Icon(
                                            Icons.mail_outlined,
                                            color: AppColors.whiteColor,
                                            size: 20,
                                          ),
                                        ),
                                        Text(
                                          context
                                              .appString
                                              .continueWithMobileEmailKey,
                                          style: context.textTheme.bodyLarge
                                              ?.copyWith(
                                                fontWeight: FontWeight.w600,
                                                fontSize: Dimens.fontSize12,
                                                color: Colors.white,
                                              ),
                                        ),
                                      ],
                                    ),
                                    onTap: () async {
                                      await context.router.push(LoginRoute());
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      /// BOTTOM SECTION
                      Padding(
                        padding: const EdgeInsets.fromLTRB(
                          Dimens.size24,
                          0,
                          Dimens.size24,
                          Dimens.size24,
                        ),
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            style: context.textTheme.bodySmall?.copyWith(
                              fontSize: Dimens.fontSize12,
                              color: subtitleColor,
                              height: 1.4,
                            ),
                            children: <InlineSpan>[
                              TextSpan(
                                text:
                                    '${context.appString.byContinuingAgreeKey} ',
                              ),
                              TextSpan(
                                text: context.appString.termsOfServiceKey,
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    unawaited(
                                      Navigator.of(context).push(
                                        MaterialPageRoute<void>(
                                          builder: (BuildContext context) =>
                                              const InAppWebViewPage(
                                                title: 'Terms & Conditions',
                                                url:
                                                    'https://weko.pro/terms-and-conditions',
                                              ),
                                        ),
                                      ),
                                    );
                                  },
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: titleColor,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                              TextSpan(text: ' ${context.appString.andKey} '),
                              TextSpan(
                                text: context.appString.privacyPolicyKey,
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    unawaited(
                                      Navigator.of(context).push(
                                        MaterialPageRoute<void>(
                                          builder: (BuildContext context) =>
                                              const InAppWebViewPage(
                                                title: 'Privacy Policy',
                                                url:
                                                    'https://weko.pro/privacy-policy',
                                              ),
                                        ),
                                      ),
                                    );
                                  },
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: titleColor,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
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
        },
      ),
    );
  }

  @override
  Widget buildDesktopWidget(BuildContext context) {
    return buildView(context);
  }

  @override
  Widget buildMobileWidget(BuildContext context) {
    return buildView(context);
  }

  @override
  Widget buildTabletWidget(BuildContext context) {
    return buildView(context);
  }
}
