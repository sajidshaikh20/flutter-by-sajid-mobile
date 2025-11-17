import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../utils/exports.dart';
import '../../../app/providers/providers.dart';

@RoutePage()
/// Page that displays social login options (Facebook, Google, Apple, Email).
class SocialLoginPage extends ConsumerWidget {
  /// Creates a social login page.
  const SocialLoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final SocialLoginState initialState = const SocialLoginState(
      status: BaseStateStatus.initial,
    );
    
    // Listen to state changes
    ref.listen<SocialLoginState>(
      socialLoginNotifierProvider(initialState),
      (SocialLoginState? previous, SocialLoginState next) async {
        DebugLog.instance.i('SocialLogin Listener - Status: ${next.status}, RedirectRoute: ${next.redirectRoute}');
        
        if (next.msg != null && (next.msg?.isNotEmpty ?? false)) {
          displaySnackBar(next.msg ?? '', context);
        }
        
        // Navigate on success status with a small delay
        if (next.status == BaseStateStatus.success) {
            DebugLog.instance.i('Success status detected, attempting navigation...');
            // Add a small delay to ensure the state is fully processed
            await Future<void>.delayed(const Duration(milliseconds: 100));
            try {
              if (context.mounted) {
                await context.router.replaceAll(<PageRouteInfo>[const DashboardRoute()]);
                DebugLog.instance.i('Navigation completed successfully');
              }
            } on Exception catch (e) {
              DebugLog.instance.e('Navigation failed: $e');
            }
          }
      },
    );

    final SocialLoginState state = ref.watch(socialLoginNotifierProvider(initialState));
    final SocialLoginNotifier notifier = ref.read(socialLoginNotifierProvider(initialState).notifier);
    
    DebugLog.instance.i('SocialLogin Builder - Status: ${state.status}, RedirectRoute: ${state.redirectRoute}');
    return Scaffold(
          resizeToAvoidBottomInset: false,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: Dimens.size16),
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        Dimens.size95.heightBox,
                        Dimens.size3.heightBox,
                        CustomTextLabelWidget(
                          label: context.appString.loginSignupKey,
                          style: context.textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w500,
                            height: Dimens.lineHeight18
                                .toLineHeight(Dimens.fontSize14),
                            fontSize: Dimens.fontSize14,
                          ),
                        ),
                        Dimens.size30.heightBox,
                        CustomButtonWidget(
                          height: Dimens.size44,
                          icon: Assets.svgs.icFacebook.svg(),
                          backgroundColor:
                              MainConfig.appColors.lightBlueDarkColor,
                          titleTextStyle:
                              context.textTheme.headlineMedium?.copyWith(
                            fontSize: Dimens.fontSize14,
                            fontWeight: FontWeight.w600,
                            height: Dimens.lineHeight20
                                .toLineHeight(Dimens.fontSize14),
                            color: MainConfig.appColors.textWhiteColor,
                          ),
                          isPrimaryButton: false,
                          title: context.appString.continueWithFacebookKey,
                          onTap: () async {
                            try {
                              DebugLog.instance
                                  .i('Starting Facebook Sign In process...');

                              Map<String, dynamic>? user =
                                  await getIt<SocialLoginServices>()
                                      .loginWithFacebookClick();

                              if (context.mounted) {
                                if (user != null) {
                                  DebugLog.instance.i('LOGGED IN USER FACEBOOK----> ${user.values}');
                                  String email = Platform.isIOS
                                      ? user["userEmail"]
                                      : user["email"];

                                  // Get Facebook access token
                                  String? facebookToken = user["tokenString"];

                                  await SharedPref.instance.setValue(
                                    PrefsKey.socialLoginTypeKey,
                                    SocialLoginType.facebook.name,
                                  );

                                  await notifier.socialLogin(
                                    email: email,
                                    socialLoginType: SocialLoginType.facebook.name,
                                    facebookToken: facebookToken,
                                  );
                                } else {
                                  DebugLog.instance
                                      .e('Facebook Sign In returned null user');
                                  displaySnackBar(
                                    AppConstant.facebookSignInFailed,
                                    context,
                                  );
                                }
                              }
                            } on Exception catch (error) {
                              DebugLog.instance.e(
                                  'Exception during Facebook Sign In: $error');
                              if (context.mounted) {
                                displaySnackBar(
                                  AppConstant.facebookSignInFailed,
                                  context,
                                );
                              }
                            }
                          },
                        ),
                        Dimens.size16.heightBox,
                        CustomButtonWidget(
                          height: Dimens.size44,
                          icon: Assets.svgs.icGoogle.svg(),
                          backgroundColor:
                              MainConfig.appColors.backgroundLightBlueColor,
                          borderColor:
                              MainConfig.appColors.backgroundBlackColor,
                          titleTextStyle:
                              context.textTheme.headlineMedium?.copyWith(
                            fontSize: Dimens.fontSize14,
                            fontWeight: FontWeight.w600,
                            height: Dimens.lineHeight20
                                .toLineHeight(Dimens.fontSize14),
                            color: MainConfig.appColors.textWhiteColor,
                          ),
                          isPrimaryButton: false,
                          title: context.appString.continueWithGoogleKey,
                          onTap: () async {
                            try {
                              DebugLog.instance
                                  .i('Starting Google Sign In process...');
                              GoogleSignInAccount? user =
                                  await getIt<SocialLoginServices>()
                                      .signInWithGoogle();


                              if (context.mounted) {
                                if (user != null) {
                                  DebugLog.instance.i(
                                      'LOGGED IN USER GMAIL----> ${user.email}');

                                  await SharedPref.instance.setValue(
                                    PrefsKey.socialLoginTypeKey,
                                    SocialLoginType.google.name,
                                  );

                                  // Get Google authentication tokens
                                  final GoogleSignInAuthentication auth = await user.authentication;

                                  await notifier.socialLogin(
                                    email: user.email,
                                    socialLoginType: SocialLoginType.google.name,
                                    googleToken: auth.accessToken, // Use accessToken for authentication
                                  );
                                } else {
                                  DebugLog.instance
                                      .e('Google Sign In returned null user');
                                  displaySnackBar(
                                    AppConstant.googleSignInFailed,
                                    context,
                                  );
                                }
                              }
                            } on Exception catch (error) {
                              DebugLog.instance.e(
                                  'Exception during Google Sign In: $error');
                              if (context.mounted) {
                                displaySnackBar(
                                  AppConstant.googleSignInFailed,
                                  context,
                                );
                              }
                            }
                          },
                        ),
                        Dimens.size16.heightBox,
                        if (Platform.isIOS)
                          CustomButtonWidget(
                            height: Dimens.size44,
                            icon: Assets.svgs.icApple.svg(),
                            backgroundColor: MainConfig.appColors.textBlackColor,
                            titleTextStyle:
                                context.textTheme.headlineMedium?.copyWith(
                              fontSize: Dimens.fontSize14,
                              fontWeight: FontWeight.w600,
                              height: Dimens.lineHeight20
                                  .toLineHeight(Dimens.fontSize14),
                              color: MainConfig.appColors.textWhiteColor,
                            ),
                            isPrimaryButton: false,
                            title: context.appString.continueWithAppleKey,
                            onTap: () async {
                              try {
                                DebugLog.instance
                                    .i('Starting Apple Sign In process...');

                                Map<String, dynamic> appleSignInResult =
                                    await getIt<SocialLoginServices>()
                                        .handleAppleSignInWithToken();

                                if (context.mounted) {
                                  AppleDecodedModel user = appleSignInResult['user'];
                                  String identityToken = appleSignInResult['identityToken'];
                                  String authorizationCode = appleSignInResult['authorizationCode'];

                                  DebugLog.instance.i('Apple Identity Token: $identityToken');
                                  DebugLog.instance.i('Apple access Token: $authorizationCode');

                                  if (user.email != null) {
                                    DebugLog.instance.i('LOGGED IN USER APPLE----> ${user.email}');

                                    await SharedPref.instance.setValue(
                                      PrefsKey.socialLoginTypeKey,
                                      SocialLoginType.apple.name,
                                    );

                                    // Call the social login API with Apple token
                                    await notifier.socialLogin(
                                      email: user.email ?? '',
                                      socialLoginType: SocialLoginType.apple.name,
                                      appleToken: authorizationCode.isNotEmpty ? authorizationCode : '',
                                    );
                                  } else {
                                    DebugLog.instance
                                        .e('Apple Sign In returned null or empty email');
                                    displaySnackBar(
                                      AppConstant.appleSignInFailed,
                                      context,
                                    );
                                  }
                                }
                              } on Exception catch (error) {
                                DebugLog.instance.e(
                                    'Exception during Apple Sign In: $error');
                                if (context.mounted) {
                                  displaySnackBar(
                                    AppConstant.appleSignInFailed,
                                    context,
                                  );
                                }
                              }
                            },
                          ),
                        if (Platform.isIOS) Dimens.size16.heightBox,
                        CustomButtonWidget(
                          height: Dimens.size44,
                          icon: Assets.svgs.icMail.svg(),
                          backgroundColor: MainConfig.appColors.mainColor,
                          titleTextStyle:
                              context.textTheme.headlineMedium?.copyWith(
                            fontSize: Dimens.fontSize14,
                            fontWeight: FontWeight.w600,
                            height: Dimens.lineHeight20
                                .toLineHeight(Dimens.fontSize14),
                            color: MainConfig.appColors.textWhiteColor,
                          ),
                          isPrimaryButton: false,
                          title: context.appString.continueWithMobileEmailKey,
                          onTap: () async {
                            await context.router.push(LoginRoute());
                          },
                        ),
                        Dimens.size56.heightBox,
                        Padding(
                          padding: const EdgeInsets.only(bottom: 100),
                          child: InkWell(
                            splashFactory: NoSplash.splashFactory,
                            splashColor: MainConfig.appColors.transparent,
                            highlightColor: MainConfig.appColors.transparent,
                            overlayColor:
                                WidgetStateProperty.all(Colors.transparent),
                            onTap: () async {
                              //# TODO as of now comment this line when we develop then uncomment
                              displaySnackBar("Comming Soon", context);
                             // await context.router.replaceAll(<PageRouteInfo>[const DashboardRoute()]);
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: Dimens.space10),
                              child: CustomTextLabelWidget(
                                label: context.appString.continueAsGuestKey,
                                style: context.textTheme.titleLarge?.copyWith(
                                  height: Dimens.lineHeight20
                                      .toLineHeight(Dimens.fontSize20),
                                  fontWeight: FontWeight.w600,
                                  fontSize: Dimens.fontSize14,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        );
  }
}
