import '../../../../utils/exports.dart';

/// A widget that displays a single address row in a list.
///
/// This row can be used in both checkout flows and address management screens.
/// It optionally shows a delete button and adapts layout based on the [device] type.
class AddressListItemRow extends StatelessWidget {
  /// Creates an [AddressListItemRow].
  ///
  /// The [isForCheckOut] flag indicates whether the row is being used
  /// during a checkout process.
  /// The [addressModel] provides the address data to display.
  /// If [isShowDeleteButton] is true, a delete button is shown.
  /// The [onDeleteTap] callback is called when the delete button is tapped.
  /// The [device] parameter allows customizing the layout for different
  /// screen types (mobile, tablet, web).
  const AddressListItemRow({
    super.key,
    required this.isForCheckOut,
    this.addressModel,
    this.isShowDeleteButton,
    this.onDeleteTap,
    this.device = ScreenType.mobile,
  });

  /// Whether the row is being displayed in a checkout process.
  final bool isForCheckOut;

  /// The address data to display.
  final BillingAddress? addressModel;

  /// Whether to show the delete button.
  final bool? isShowDeleteButton;

  /// Callback invoked when the delete button is tapped.
  final Function()? onDeleteTap;

  /// The type of device to adjust the layout or styling.
  final ScreenType device;


  @override
  Widget build(BuildContext context) {
    double iconSize=Dimens.size20;
    double addressTitleFontSize=Dimens.fontSize16;
    double pencilIconSize=Dimens.size25;
    double paddingLeftOrRightFOrAddressType=Dimens.space6;
    double checkoutFontSize=Dimens.size20;
    double paddingBtnPencilIconAndText=Dimens.space5;
    double editTxtPadding=Dimens.space13;
    switch(device){
      case ScreenType.mobile:

        break;
      case ScreenType.tablet:
        editTxtPadding=Dimens.space17;
        iconSize=Dimens.size30;
        pencilIconSize=Dimens.size35;
        paddingLeftOrRightFOrAddressType=Dimens.space12;
        checkoutFontSize=Dimens.size24;
        addressTitleFontSize=Dimens.fontSize20;
        paddingBtnPencilIconAndText=Dimens.space8;
        
      case ScreenType.desktop:
        break;
    }

    return Padding(
      padding: const EdgeInsets.only(right: Dimens.space8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Visibility(
                  visible: !isForCheckOut,
                  child: Padding(
                    padding: const EdgeInsets.only(top: Dimens.space8),
                    child: CustomTextLabelWithIcon(
                      isPrefix: true,
                      iconPadding: isLanguageAlignmentLTR
                          ?  EdgeInsets.only(right: paddingLeftOrRightFOrAddressType)
                          :  EdgeInsets.only(
                              left: paddingLeftOrRightFOrAddressType,
                            ),
                      size:  Size(iconSize, iconSize),
                      image: getAddressType(addressModel?.addressTitle ?? ""),
                      label: getAddressTitle(isLtr: isLanguageAlignmentLTR,
                          title:  addressModel?.addressTitle ?? ""),
                      style: MainConfig.appStyle.textBold.copyWith(
                        fontSize: addressTitleFontSize,
                        color: MainConfig.appColors.textColorGreyBlack,
                        height: Dimens.fontHeight1_7,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: isForCheckOut ? Dimens.size8 : Dimens.size0,
                ),
                ListTextView(
                  device: device,
                  label: "${addressModel?.firstname} ${addressModel?.lastname}",
                  textStyle: isForCheckOut
                      ? MainConfig.appStyle.textBold.copyWith(
                          color: MainConfig.appColors.textBlackColor,
                          fontSize: checkoutFontSize,
                        )
                      : null,
                ),
              ],
            ),
          ),
          InkWell(
            onTap: () async {
              await context.router.push(AddNewAddressRoute(
                isEdit: true,
                billingAddress: addressModel,
                isForCheckOut: isForCheckOut,
              ));
            },
            child: Row(
              children: <Widget>[
                isForCheckOut
                    ? Container(
                        margin:  EdgeInsets.only(right: paddingBtnPencilIconAndText),
                        child: Assets.svgs.icPencilIcon.svg(
                          height: pencilIconSize,
                          width: pencilIconSize,
                        ))
                    : const SizedBox(),
                Padding(
                  padding: isLanguageAlignmentLTR
                      ? EdgeInsets.zero
                      :  EdgeInsets.only(left: editTxtPadding),
                  child: LabelTextWidget(
                    device: device,
                    label: MainConfig.dynamicString(JsonServiceString.keyEdit),
                    textColor: isForCheckOut
                        ? MainConfig.appColors.textBlackColor
                        : MainConfig.appColors.textLightBlueColor,
                  ),
                ),
              ],
            ),
          ),
          Visibility(
            visible: (isShowDeleteButton ?? false) && (!isForCheckOut),
            child: Dimens.size20.widthBox,
          ),
          Visibility(
            visible: (isShowDeleteButton ?? false) && (!isForCheckOut),
            child: InkWell(
              onTap: () {
                onDeleteTap?.call();
              },
              child: Padding(
                padding: EdgeInsets.only(left: isLanguageAlignmentLTR ? Dimens.space0 : editTxtPadding),
                child: LabelTextWidget(
                    device: device,
                    label:
                        MainConfig.dynamicString(JsonServiceString.keyDelete)),
              ),
            ),
          ),
          Dimens.size14.heightBox,
        ],
      ),
    );
  }
///getAddressTitle function
  String getAddressTitle({required bool isLtr,required String title}) {
    if (isLtr) {
      return title;
    } else {
      if (title == AddressType.home.name) {
        return MainConfig.dynamicString(JsonServiceString.keyHome);
      } else if (title == AddressType.work.name) {
        return MainConfig.dynamicString(JsonServiceString.keyOffice);
      } else if (title == AddressType.other.name) {
        return MainConfig.dynamicString(JsonServiceString.keyOther);
      } else {
        return MainConfig.dynamicString(JsonServiceString.keyHome);
      }
    }
  }
///getAddressType svg
  SvgGenImage getAddressType(String title) {
    if (title == AddressType.home.name) {
      return Assets.svgs.icHome;
    } else if (title == AddressType.work.name) {
      return Assets.svgs.icBriefcase;
    } else if (title == AddressType.other.name) {
      return Assets.svgs.icOtherIcon;
    } else {
      return Assets.svgs.icHome;
    }
  }
}
