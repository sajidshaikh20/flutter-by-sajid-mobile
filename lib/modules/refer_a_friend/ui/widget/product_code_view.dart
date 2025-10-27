import '../../../../utils/exports.dart';

/// Widget that displays the product code/referral code with sharing functionality.
class ProductCodeView extends StatelessWidget {
  /// Creates a product code view widget.
  const ProductCodeView({super.key, this.device = ScreenType.mobile});

  /// The screen type for responsive design.
  final ScreenType device;

  @override
  Widget build(BuildContext context) {
    double spaceMobTab34_44 = Dimens.space34;
    switch (device) {
      case ScreenType.mobile:
        break;
      case ScreenType.tablet:
        spaceMobTab34_44 = Dimens.space44;
      default:
        break;
    }
    return Visibility(
        child: ColoredBox(
          color: MainConfig.appColors.backgroundWhiteColor,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: spaceMobTab34_44),
            child: Column(
              children: <Widget>[
                // const StepsPage(),
                CustomTextLabelWidget(
                  label: context.appString.inviteKey,
                  style: context.textTheme.titleLarge?.copyWith(
                      height:
                      Dimens.lineHeight22.toLineHeight(Dimens.fontSize18),
                      fontWeight: FontWeight.w700,
                      color: MainConfig.appColors.mainColor,
                      fontSize: Dimens.fontSize18),
                ),
                Dimens.size33.heightBox,
                ReferalCodeView(
                  device: device,
                ),
                Dimens.size40.heightBox,
                BlocBuilder<ReferEarnCubit, ReferEarnState>(
                  builder: (BuildContext context, ReferEarnState state) {
                    return CustomGradientButtonWidget(
                      device: device,
                      title: context.appString.shareKey,
                      titleTextStyle: context.textTheme.titleLarge?.copyWith(
                          height:
                          Dimens.lineHeight24.toLineHeight(Dimens.fontSize16),
                          fontWeight: FontWeight.w700,
                          color: AppColors.whiteColor,
                          fontSize: Dimens.fontSize16),
                      onTap: () async {
                        await Share.share('${context.appString.referalKey}  ${state.referCode}. '''
                            '${"https://play.google.com/store/games?hl=en_IN"}');
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ));
  }
}
