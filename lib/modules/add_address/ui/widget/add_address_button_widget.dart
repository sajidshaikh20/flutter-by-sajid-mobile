import '../../../../utils/exports.dart';

/// A button widget that allows the user to add a new address.
///
/// This button can be used in both checkout flows and general address
/// management screens.
///
/// The appearance or behavior can be customized based on the [device] type.
class AddAddressButtonWidget extends StatelessWidget {
  /// Creates an [AddAddressButtonWidget].
  ///
  /// The [isForCheckOut] flag indicates whether the button is being used
  /// during a checkout process.
  /// The [device] parameter allows customizing the layout for different
  /// screen types (mobile, tablet, web).
  const AddAddressButtonWidget({
    super.key,
    required this.isForCheckOut,
    this.device = ScreenType.mobile,
  });

  /// Whether the button is being used during a checkout process.
  final bool isForCheckOut;

  /// The type of device to adjust the button layout or styling.
  final ScreenType device;
  @override
  Widget build(BuildContext context) {
    double horizontalMargin=Dimens.space16;
    double addAddressFontSize=Dimens.fontSize18;
    double verticalPadding=Dimens.space10;
    switch(device){

      case ScreenType.tablet:
        horizontalMargin=Dimens.space32;
        addAddressFontSize=Dimens.fontSize24;
        verticalPadding=Dimens.space15;
      

      default:
        break;
    }

    return Container(
      width: MediaQuery.of(context).size.width,
      margin:  EdgeInsets.symmetric(horizontal:horizontalMargin),
      padding:  EdgeInsets.symmetric(
          vertical: verticalPadding, horizontal: Dimens.space6),
      decoration: BoxDecorationExtension.customDecoration(
        borderRadius: Dimens.radius6.borderRadius,
        boxShadow:  <BoxShadow>[
          BoxShadow(
            color: MainConfig.appColors.shadowBlackColor,
            blurRadius: Dimens.radius6,
          )
        ],
        color: MainConfig.appColors.backgroundWhiteColor,
      ),
      child: CustomTextLabelWidget(
        label:
            "+ ${MainConfig.dynamicString(JsonServiceString.keyAddNewAddress)}",
        style: context.textTheme.headlineMedium?.copyWith(
          fontSize: addAddressFontSize,
          color: MainConfig.appColors.textDarkBlueColor,
        ),
        onTap: () async {
          // context.router.pushNamed(AppPaths.addAddress,);
          await context.router.push(AddNewAddressRoute(
            isEdit: false,
            isForCheckOut: isForCheckOut,
          ));
        },
      ),
    );
  }
}
