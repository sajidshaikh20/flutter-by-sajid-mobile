import '../../../../../utils/exports.dart';

/// A widget for handling social authentication options.
/// Displays buttons for various social login methods like Google or Facebook.
class SocialAuth extends StatelessWidget {
  /// A Constructor for handling social authentication options.
  /// Displays buttons for various social login methods like Google or Facebook.
  const SocialAuth({super.key, this.device = ScreenType.mobile});

  /// The type of device (e.g., mobile, tablet, etc.).
  final ScreenType device;

  @override
  Widget build(BuildContext context) {
    double? heightOfIcon;
    double? widthIcon;
    switch (device) {
      case ScreenType.mobile:
        break;
      case ScreenType.tablet:
        heightOfIcon = Dimens.size60;
        widthIcon = Dimens.size100;
      case ScreenType.desktop:
        break;
    }
    return Row(
      mainAxisAlignment: Platform.isIOS
          ? MainAxisAlignment.spaceEvenly
          : MainAxisAlignment.center,
      children: <Widget>[
        if (Platform.isIOS)
          InkWell(
            onTap: () async {
              AppleDecodedModel user =
              await getIt<SocialLoginServices>().handleAppleSignIn();
              if (context.mounted) {
                if (user.email != null) {
                  await SharedPref.instance.setValue(
                    PrefsKey.socialLoginTypeKey,
                    SocialLoginType.apple.name,
                  );
                  if (context.mounted) {
                    displaySnackBar(
                      '${AppConstant.appleSignInSuccess} ${user.email}',
                      context,
                    );
                  }
                } else {
                  displaySnackBar(
                    AppConstant.appleSignInFailed,
                    context,
                  );
                }
              }
            },
            child: Assets.svgs.icAppleIcon.svg(
              height: heightOfIcon,
              width: widthIcon,
            ),
          ),
        InkWell(
          onTap: () async {
            GoogleSignInAccount? user =
            await getIt<SocialLoginServices>().signInWithGoogle();
            if (context.mounted) {
              if (user != null) {
                DebugLog.instance.i('LOGGED IN USER GMAIL----> ${user.email}');
                await SharedPref.instance.setValue(
                  PrefsKey.socialLoginTypeKey,
                  SocialLoginType.google.name,
                );
                if (context.mounted) {
                  displaySnackBar(
                    '${AppConstant.googleSignInSuccess} ${user.email}',
                    context,
                  );
                }
              }
            }
          },
          child: Assets.svgs.icGoogleIcon.svg(
            height: heightOfIcon,
            width: widthIcon,
          ),
        ),
        if (!Platform.isIOS) Dimens.space16.widthBox,
        InkWell(
          onTap: () async {
            Map<String, dynamic>? user =
            await getIt<SocialLoginServices>().loginWithFacebookClick();
            if (context.mounted) {
              if (user != null) {
                DebugLog.instance.i('LOGGED IN USER FACEBOOK----> ${user.values}');
                if (Platform.isIOS) {
                  displaySnackBar(
                    "${AppConstant.facebookSignInSuccess} ${user["userEmail"]}",
                    context,
                  );
                } else {
                  displaySnackBar(
                    "${AppConstant.facebookSignInSuccess} ${user["email"]}",
                    context,
                  );
                }
                await SharedPref.instance.setValue(
                  PrefsKey.socialLoginTypeKey,
                  SocialLoginType.facebook.name,
                );
              } else {
                displaySnackBar(
                  AppConstant.facebookSignInFailed,
                  context,
                );
              }
            }
          },
          child: Assets.svgs.icRoundFacebook.svg(
            height: heightOfIcon,
            width: widthIcon,
          ),
        ),
      ],
    );
  }
}
