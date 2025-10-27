import '../../../../utils/exports.dart';

/// A widget that displays the details of a membership tier in a card format.
///
/// This widget takes a [membershipTierModelTier] parameter to display the information
/// related to a specific membership tier. The widget is typically used to show
/// tier-specific details like benefits, pricing, or other related information.
class HowItsWorkedCardWidget extends StatelessWidget {
  /// The membership tier model that holds the data for the specific membership tier.
  final MembershipTierModelTier membershipTierModelTier;

  /// Creates an instance of [HowItsWorkedCardWidget].
  ///
  /// [membershipTierModelTier] is required to display the details of the membership tier.
  const HowItsWorkedCardWidget(
      {super.key, required this.membershipTierModelTier});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SvgPicture.asset(
          membershipTierModelTier.iconPath,
          width: Dimens.size52,
          height: Dimens.size52,
        ),
        Dimens.size12.widthBox,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              CustomTextLabelWidget(
                textAlign: TextAlign.start,
                label: membershipTierModelTier.title,
                style: context.textTheme.headlineMedium?.copyWith(
                  color: MainConfig.appColors.textBlackColor,
                  fontWeight: FontWeight.w700,
                  fontSize: Dimens.fontSize14,
                  height: Dimens.lineHeight16.toLineHeight(Dimens.fontSize14),
                ),
              ),
              Dimens.size6.heightBox,
              createSpannableText(
                  defaultTextStyle: context.textTheme.headlineMedium?.copyWith(
                    color: MainConfig.appColors.textBlackColor,
                    fontSize: Dimens.size12,
                    height: Dimens.lineHeight14.toLineHeight(Dimens.size12),
                    fontWeight: FontWeight.w400,
                  ),
                  boldTextStyle: context.textTheme.headlineMedium?.copyWith(
                    color: MainConfig.appColors.textBlackColor,
                    fontSize: Dimens.size12,
                    height: Dimens.lineHeight14.toLineHeight(Dimens.size12),
                    fontWeight: FontWeight.w700,
                  ),
                  context: context,
                  content: membershipTierModelTier.description,
                  boldPhrases: <String>[
                    membershipTierModelTier.maxPoints,
                    membershipTierModelTier.pointsPerKD,
                    membershipTierModelTier.point,
                    membershipTierModelTier.pointCount,
                    membershipTierModelTier.points,
                  ])
            ],
          ),
        )
      ],
    );
  }
}
