import '../../../../utils/exports.dart';

/// A widget for displaying a contact us item with an icon, title, subtitle, and a tap action.
class ContactUsItemWidget extends StatelessWidget {
  /// Creates a [ContactUsItemWidget].
  ///
  /// [contactUsModel] is required and provides the data for the item.
  /// [onTap] is required and is the callback when the item is tapped.
  /// [device] is optional and defaults to [ScreenType.mobile].
  const ContactUsItemWidget(
      {super.key,
      required this.contactUsModel,
      required this.onTap,
      this.device = ScreenType.mobile});

  /// The model containing the data for the contact us item.
  final LocalContactUsModel contactUsModel;

  /// The callback when the item is tapped.
  final Function() onTap;

  /// The type of device the widget is displayed on.
  final ScreenType device;

  /// Builds the widget.
  @override
  Widget build(BuildContext context) {
    double customStylesFontSize=Dimens.fontSize16;
    double horizontalPadding=Dimens.space15;
    double iconSize=Dimens.space22;
    switch(device){

      case ScreenType.tablet:
        customStylesFontSize=Dimens.fontSize24;
        horizontalPadding=Dimens.space28;
        iconSize=Dimens.space28;
      
      default:
        break;
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        ListTile(
          onTap: onTap,
          title: CustomTextLabelWidget(
            label: contactUsModel.title ?? "",
            textAlign: TextAlign.start,
            style: context.textTheme.headlineMedium?.copyWith(
                color: MainConfig.appColors.textMediumDarkBlueColor,
                fontSize: customStylesFontSize),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              CustomTextLabelWidget(
                label: contactUsModel.subTitle ?? "",
                textAlign: TextAlign.start,
                style: context.textTheme.labelMedium?.copyWith(
                    color: MainConfig.appColors.textLabelGreyColor,
                    fontSize: customStylesFontSize),
              ),
              Visibility(
                visible: contactUsModel.secondSubTitle.isNotNullOrEmpty,
                child: CustomTextLabelWidget(
                  label: contactUsModel.secondSubTitle ?? "",
                  textAlign: TextAlign.start,
                  style: context.textTheme.labelMedium?.copyWith(
                      color: MainConfig.appColors.textLabelGreyColor,
                      fontSize: customStylesFontSize),
                ),
              ),
            ],
          ),
          leading: contactUsModel.imageWidget?.svg(
              width: iconSize,height: iconSize
          ),
          trailing: RotatedIcon(
            isLanguageAlignmentLTR: isLanguageAlignmentLTR
                ,
            iconWidget: Assets.svgs.icArrowNext.svg(
              width: iconSize,height: iconSize
            )),
          contentPadding:  EdgeInsets.symmetric(horizontal: horizontalPadding),
        ),
        Dimens.size10.heightBox,
        CustomDivider(
          color: MainConfig.appColors.dividerGreyExtraLight,
          height: Dimens.size1,
        ),
      ],
    );
  }
}
