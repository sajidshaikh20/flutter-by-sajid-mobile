import '../../../../utils/exports.dart';

/// A widget that displays the top view for onboarding or login screens.
class TopViewOnboardingLogin extends StatelessWidget {
  /// Creates a [TopViewOnboardingLogin] widget.
  ///
  const TopViewOnboardingLogin(
      {super.key, this.device = ScreenType.mobile, this.isFromLogin = false});

  /// [device] specifies the type of device (e.g., mobile, tablet). Defaults to [ScreenType.mobile].
  final ScreenType device;

  /// [isFromLogin] indicates whether this view is part of the login process. Defaults to false.
  final bool isFromLogin;

  @override
  Widget build(BuildContext context) {
    final bool isRTL = Directionality.of(context) == TextDirection.rtl;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Visibility(
          visible: isFromLogin,
          maintainSize: true,
          maintainState: true,
          maintainAnimation: true,
          child: Align(
            alignment: isRTL ? Alignment.topRight : Alignment.topLeft,
            child: GestureDetector(
                onTap: () {
                  goBack(context);
                },
                child: Container(
                    margin: const EdgeInsets.only(
                        top: Dimens.space54,
                        left: Dimens.space10,
                        right: Dimens.space10),
                    child: RotatedIcon(
                        isLanguageAlignmentLTR: !isRTL,
                        iconWidget: Assets.svgs.icBack.svg()))),
          ),
        ),
        Container(
            margin: const EdgeInsets.only(
                bottom: Dimens.size31,
                left: Dimens.size87,
                right: Dimens.size88),
            color: AppColors.whiteColor,
            child: Assets.png.icCropWekoIcon
                .image(height: Dimens.size110, width: Dimens.size200)),
       /* const ColoredBox(
          color: AppColors.greyColor,
          child: SizedBox(
            height: Dimens.size10,
            width: double.maxFinite,
          ),
        )*/
      ],
    );
  }
}
