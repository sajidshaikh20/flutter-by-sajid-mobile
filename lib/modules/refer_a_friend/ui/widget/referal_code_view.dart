import '../../../../utils/exports.dart';

/// Widget that displays the referral code with copy functionality.
class ReferalCodeView extends StatelessWidget {
  /// Creates a referral code view widget.
  const ReferalCodeView({super.key, this.device = ScreenType.mobile});

  /// The screen type for responsive design.
  final ScreenType device;

  /// The border radius for the widget.
  final double radius = Dimens.radius10;

  @override
  Widget build(BuildContext context) {
    ReferEarnCubit cubit = context.instance<ReferEarnCubit>();

    return GestureDetector(
      onTap: () async {
        await _copyToClipboard(context, cubit.state.referCode!);
      },
      child: DottedBorder(
        options: RoundedRectDottedBorderOptions(
          radius: const Radius.circular(Dimens.radius10),
          color: MainConfig.appColors.lightGreyColor,
          dashPattern: const <double>[1, 1], // 6px line, 3px gap
          padding: EdgeInsets.zero, // keeps border snug to child
        ),
        child: DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: Dimens.radius10.borderRadius,
            color: AppColors.whiteColor,
          ),
          child: Padding(
            padding: const EdgeInsets.only(
                left: Dimens.space12,
                top: Dimens.space7,
                bottom: Dimens.space7,
                right: Dimens.space13),
            child: Column(
              children: <Widget>[
                CustomTextLabelWidget(
                  label: context.appString.yourReferralCodeKey,
                  textAlign: TextAlign.start,
                  style: context.textTheme.titleLarge?.copyWith(
                    height: Dimens.lineHeight18.toLineHeight(Dimens.fontSize14),
                    fontWeight: FontWeight.w600,
                    color: MainConfig.appColors.creyColor,
                    fontSize: Dimens.fontSize14,
                  ),
                ),
                Dimens.size4.heightBox,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    BlocBuilder<ReferEarnCubit, ReferEarnState>(
                      builder: (BuildContext context, ReferEarnState state) {
                        return Flexible(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: Dimens.space10),
                            child: CustomTextLabelWidget(
                              label: state.referCode ?? "",
                              style: context.textTheme.titleLarge?.copyWith(
                                height: Dimens.lineHeight28
                                    .toLineHeight(Dimens.fontSize24),
                                fontWeight: FontWeight.w700,
                                decoration: TextDecoration.underline,
                                decorationColor:
                                    MainConfig.appColors.secondaryColor,
                                color: MainConfig.appColors.secondaryColor,
                                fontSize: Dimens.fontSize18,
                              ),
                            ),
                          ),
                        );
                      },
                      buildWhen:
                          (ReferEarnState previous, ReferEarnState current) {
                        return previous.referCode != current.referCode;
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _copyToClipboard(BuildContext context, String textToCopy) async {
    await Clipboard.setData(ClipboardData(text: textToCopy)).then((_) {

    });
  }
}
