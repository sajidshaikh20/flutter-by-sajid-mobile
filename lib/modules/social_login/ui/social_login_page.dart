import '../../../utils/exports.dart';

@RoutePage()
class SocialLoginPage extends BaseResponsiveView {
  /// Creates a social login page.
  const SocialLoginPage({super.key});

  /// Builds the social login view with BlocProvider.
  Widget buildView(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

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
      ),
      child: BlocConsumer<SocialLoginCubit, SocialLoginState>(
        listener: (BuildContext context, SocialLoginState state) async {
          DebugLog.instance.i(
            'SocialLogin BlocListener - Status: ${state.status}, RedirectRoute: ${state.redirectRoute}',
          );

          if (state.msg != null && (state.msg?.isNotEmpty ?? false)) {
            displaySnackBar(state.msg ?? '', context);
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
                await context.router.replaceAll(<PageRouteInfo>[
                  const DashboardRoute(),
                ]);
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
                // 2. Main content container
                SafeArea(
                  child: Center(
                    child: SingleChildScrollView(
                      physics: const ClampingScrollPhysics(),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: Dimens.size24,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            // Weko logo centered with a soft glow
                            DecoratedBox(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                boxShadow: <BoxShadow>[
                                  BoxShadow(
                                    color: isDark
                                        ? AppColors.primaryPurple.withValues(
                                            alpha: 0.2,
                                          )
                                        : AppColors.primaryPurple.withValues(
                                            alpha: 0.08,
                                          ),
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
                            Dimens.size22.heightBox,
                            // Welcome Back Title
                            CustomTextLabelWidget(
                              label: context.appString.welcomeBackKey,
                              style: context.textTheme.headlineLarge?.copyWith(
                                fontWeight: FontWeight.w800,
                                fontSize: Dimens.fontSize30,
                                color: titleColor,
                                letterSpacing: 0.5,
                              ),
                            ),
                            Dimens.size8.heightBox,
                            // Subtitle / Prompt
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: Dimens.size16,
                              ),
                              child: CustomTextLabelWidget(
                                label: context.appString.loginSignupKey,
                                style: context.textTheme.bodyMedium?.copyWith(
                                  fontWeight: FontWeight.w500,
                                  color: subtitleColor,
                                  fontSize: Dimens.fontSize14,
                                  height: Dimens.lineHeight20.toLineHeight(
                                    Dimens.fontSize14,
                                  ),
                                ),
                              ),
                            ),
                            Dimens.size40.heightBox,

                            CustomButtonWidget(
                              isPrimaryButton: false,
                              isButtonEnabled: true,
                              title: context.appString.continueWithGoogleKey,
                              onTap: () async {
                                if (state.status == BaseStateStatus.loading) {
                                  return;
                                }
                                await context
                                    .read<SocialLoginCubit>()
                                    .socialLoginWithGoogle();
                              },
                            ),
                            Dimens.size32.heightBox,
                            CustomButtonWidget(
                              isPrimaryButton: false,
                              isButtonEnabled: true,
                              title:
                                  context.appString.continueWithMobileEmailKey,
                              onTap: () async {
                                await context.router.push(LoginRoute());
                              },
                            ),

                            // 5. "Don't have an account? Sign Up" / "New here? Sign up"
                            GestureDetector(
                              onTap: () async {
                                await context.router.push(LoginRoute());
                              },
                              child: CustomTextLabelWidget(
                                label: context.appString.dontHaveAccountKey,
                                style: context.textTheme.bodyMedium?.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.primaryPurple,
                                  fontSize: Dimens.fontSize14,
                                ),
                              ),
                            ),
                            Dimens.size48.heightBox,

                            // 6. Terms and Privacy Policy Disclaimer
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: Dimens.size16,
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
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: isDark
                                            ? AppColors.textPrimaryDark
                                            : AppColors.textPrimaryLight,
                                        decoration: TextDecoration.underline,
                                      ),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          displaySnackBar(
                                            'Terms of Service clicked',
                                            context,
                                          );
                                        },
                                    ),
                                    TextSpan(
                                      text: ' ${context.appString.andKey} ',
                                    ),
                                    TextSpan(
                                      text: context.appString.privacyPolicyKey,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: isDark
                                            ? AppColors.textPrimaryDark
                                            : AppColors.textPrimaryLight,
                                        decoration: TextDecoration.underline,
                                      ),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          displaySnackBar(
                                            'Privacy Policy clicked',
                                            context,
                                          );
                                        },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Dimens.size24.heightBox,
                          ],
                        ),
                      ),
                    ),
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
